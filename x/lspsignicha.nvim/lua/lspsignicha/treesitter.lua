
-- nvim-treesitter-textobjects を参考にしてみる
local NODE_NAME_MAP = {
  lua = {
    funccall = 'function_call',
    arguments = 'arguments',
  },
  rust = {
    funccall = 'call_expression',
    arguments = 'arguments',
  },
  python = {
    funccall = 'call',
    arguments = 'argument_list',
  },
}


--- Is the type of node a function call?
---@param node node
---@return string
local is_type_funccall = function(node)
  return node:type() == NODE_NAME_MAP[vim.bo.filetype].funccall
end

--- Is the type of node a arguments?
---@param node node
---@return string
local is_type_arguments = function(node)
  return node:type() == NODE_NAME_MAP[vim.bo.filetype].arguments
end

local get_node_at_cursor = function()
  if not parsers.has_parser() then return end
  local cursor = a.nvim_win_get_cursor(winnr or 0)
  local root = parsers.get_parser():parse()[1]:root()
  -- return root:named_descendant_for_range(cursor[1]-1,cursor[2],cursor[1]-1,cursor[2])

  -- もし、カーソル下のnodeの親が関数呼び出しの場合、 +1 する
  -- arguments の範囲がちょっとだけ大きいため、微調整
  local start_col = cursor[2]
  if is_type_funccall(ts_utils.get_node_at_cursor()) then
    start_col = start_col + 1
  end
  return root:named_descendant_for_range(cursor[1]-1, start_col, cursor[1]-1, cursor[2])
end

local arguments_node_at_cursor = function()
  -- local node = ts_utils.get_node_at_cursor()
  local node = get_node_at_cursor()

  -- function_call になるまでのぼる
  -- 関数名っぽいのを取得、また、関数呼び出しの引数の中かをチェックする？
  local idx = 0
  while node and node:type() ~= 'program' do
    local s_row, s_col, e_row, e_col = ts_utils.get_node_range(node)
    pprint(string.format("%s [%d, %d] - [%d, %d]", node:type(), s_row, s_col, e_row, e_col))

    if is_type_arguments(node) then
      pprint('hi')
      return node
    end

    node = node:parent()
  end
  return nil
end

-- カーソル下の arguments ノードの引数の位置を返す (1始まり)
local args_node_idx_at_cursor = function()

  --- line/col が node:range() の中か？
  ---@param node node
  ---@param line number
  ---@param col number
  ---@param before_arg_end_line number 1つ前の引数の行
  ---@param before_arg_end_col number 1つ前の引数の桁
  ---@return boolean
  local _is_in_node_range = function(node, line, col, before_arg_end_line, before_arg_end_col)
    local start_line, start_col, end_line, end_col = node:range()

    -- もし、同じ行なら、前の引数の後ろから見る
    if before_arg_end_line == start_line then
      start_col = before_arg_end_col + 1
    end

    -- まずは、大雑把に確認
    if line >= start_line and line <= end_line then
      if line == start_line and line == end_line then
        -- 1行内で収まっている
        --  前の引数のcol以降で、範囲内か
        print('col: ' .. col .. ', start_col: ' .. start_col)
        return col >= start_col and col <= end_col
      elseif line == start_line then
        -- 複数行で、最初の行にカーソルがある
        -- 前の引数のcol以降か？
        return col >= start_col
      elseif line == end_line then
        -- 複数行で、最後の行にカーソルがある
        return col <= end_col
      else
        return true
      end
    else
      return false
    end
  end

  local args = arguments_node_at_cursor()
  if args == nil then
    return -1
  end
  -- pprint(ts_utils.get_node_range(args))

  local before_arg_end_line = nil
  local before_arg_end_col = nil
  local idx = -1
  local cursor_row, cursor_col = unpack(a.nvim_win_get_cursor(0))
  local valid_node_cnt = 0
  for i = 1, args:named_child_count() do
    -- 範囲内にいれば、それ
    local arg_node = args:named_child(i-1)
    -- local _, start_col, _, end_col = arg_node:range()
    -- pprint(arg_node:type() .. cursor_col .. ' ' .. start_col .. ' ' .. end_col)
    if _is_in_node_range(arg_node, cursor_row-1, cursor_col, before_arg_end_line, before_arg_end_col) then
      idx = i
    end
    _, _, before_arg_end_line, before_arg_end_col = arg_node:range()
    if arg_node:type() ~= 'ERROR' then
      valid_node_cnt = valid_node_cnt + 1
    end
  end

  -- もし、最後なら、大目に見る
  if idx == -1 and ts_utils.is_in_node_range(args, cursor_row-1, cursor_col) then
    -- argments の中に入っていたら、最後の引数とする
    idx = valid_node_cnt + 1
  end
  return idx
end

---カーソル下のパラメータに対応する signature.parameters の要素を返す
---@param parameters table signature.parameters
---@return table parameter カーソル下に対応する parameter
local get_param_at_cursor = function(parameters)
  -- 現在のargsの位置 (前から何個目か) を取得
  local idx = args_node_idx_at_cursor()
  if idx == -1 then
    idx = 1
  end
  return parameters[idx]
end

---
---@param label string signature.label
---@param funcname string 呼び出している関数名
---@return string pre_text 関数名よりも前のテキスト
---@return string signature_text 関数名以降のテキスト
local split_signature_label = function(label, funcname)
  if funcname == '' then
    return '', label
  end

  -- XXX: もしかしたら、public とかもラベルに入っているかもしれない！？

  -- シグニチャヘルプの関数名より前のテキスト
  -- function func1(a, b, c)
  -- ^^^^^^^^^ この部分
  local pre_text = ''

  -- 関数部分
  -- function func1(a, b, c)
  --          ^^^^^^^^^^^^^^ この部分
  local signature_text = label

  -- 関数名より前を消す (別名を付けられていたら、うまく消せない)
  -- '-' は最短一致
  pre_text, signature_text = label:match(string.format('^(.-)(%s.*)', funcname))
  -- もし、うまく取れなかったら、もとに戻す
  if not signature_text then
    pre_text = ''
    signature_text = label
  end

  return pre_text, signature_text
end

--- signature help のパラメータのハイライトを更新する
---@param signature table signature
---@param funcname string 呼び出している関数名
---@param bufnr number float window の bufnr
local update_highlight_param = function(signature, funcname, bufnr)
  -- カーソル下のパラメータを取得
  local parameter = get_param_at_cursor(signature.parameters)
  if not parameter then return end

  -- 関数名より前と、それ以降に分割
  local pre_text, _ = split_signature_label(signature.label, funcname)

  local start_col, end_col = unpack(get_active_param_range(signature.label, parameter.label))
  if start_col == -1 or end_col == -1 then
    return
  end
  start_col, end_col = start_col - #pre_text, end_col - #pre_text
  a.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  a.nvim_buf_add_highlight(bufnr, ns, 'SigHelpParam', 0, start_col, end_col)
end


