--[[
InsertMode に入ると、signature help を表示する
]]

local a = vim.api
local lsp_util = require'vim.lsp.util'
local ts_utils = require'nvim-treesitter.ts_utils'
local parsers = require'nvim-treesitter.parsers'

-- 前回の情報
local last_sig_info = {
  -- 結果
  signature = {},
  -- 関数呼び出しのnode
  fcall_node = nil
}

local M = {
  -- _winnr,
  -- _bufnr,
}

local ns = a.nvim_create_namespace('my_signature_help')

-- From vim/lsp/buf.lua
local request = function(method, params, handler)
  vim.validate {
    method = {method, 's'};
    handler = {handler, 'f', true};
  }
  return vim.lsp.buf_request(0, method, params, handler)
end

--- ウィンドウの一番上に表示されているカレントバッファの行の番号 (1 base-index)
local win_topline_lnum = function()
  return vim.fn.line('.') - vim.fn.winline() + 1
end

---
---@param text string 表示するテキスト
---@param line number バッファ内の行番号 (この値をもとに、表示する位置を計算する)
---@param col number float window を表示する位置の桁
---@return number winnr
---@return number bufnr
local open_floating_window = function(text, line, col)
  -- pprint(text)
  local width, height = lsp_util._make_floating_popup_size({text})
  local bufnr = a.nvim_create_buf(false, true)
  local wininfo = vim.fn.getwininfo(vim.fn.win_getid())[1]
  local row = line - win_topline_lnum() + 1

  local opts = {
    -- 南西 (左下) を起点
    anchor = 'SW',
    row = row,
    col = col,
    relative = 'win',
    style = 'minimal',
    height = height,
    width = width,
  }
  -- pprint('width: '..width)
  a.nvim_buf_set_lines(bufnr, 0, -1, true, {text})
  if M._winnr == nil or not a.nvim_win_is_valid(M._winnr) then
    M._winnr = a.nvim_open_win(bufnr, false, opts)

    -- local events = {"BufHidden", "BufLeave"}
    -- a.nvim_command [[augroup my-signature-help-close]]
    -- a.nvim_command [[  autocmd!]]
    -- a.nvim_command(("  autocmd %s <buffer> ++once lua pcall(vim.api.nvim_win_close, %s, true)"):format(table.concat(events, ','), M._winnr))
    -- a.nvim_command [[augroup END]]
  else
    a.nvim_win_set_config(M._winnr, opts)
    a.nvim_win_set_buf(M._winnr, bufnr)
  end
  return M._winnr, bufnr
end

--- From vim/lsp/util.lua
---@param signature_label string シグニチャヘルプのテキスト
---@param parameter_label string|number[] ラベルのテキスト or 引数のラベルのタプル(start, end)
---@param arg_idx number 引数のidx
---@return number start_pos
---@return number end_pos
local get_active_param_range = function(signature_label, parameter_label, arg_idx)
  -- string | [uinteger, uinteger]
  if type(parameter_label) == 'table' then
    -- [uinteger, uinteger] なら、そのまま返す
    return parameter_label
  end

  -- TODO: うまいこと、

  -- signature_label のなかで、探す
  -- \V を使って、リテラル文字で検索する
  -- TODO: うまく検索できない...
  -- local re = vim.regex(string.format(([[\v<\V%s\v>]]), parameter_label))
  local re = vim.regex(parameter_label)
  local s, e = re:match_str(signature_label)
  if e == nil then
    return {-1, -1}
  end
  return {s, e}
end

-- local get_node_at_cursor = function()
--   local cursor_row, cursor_col = unpack(a.nvim_win_get_cursor(0))
--   local _root = parsers.get_parser():parse()[1]:root()
--
--   local _get_node_at_cursor
--   _get_node_at_cursor= function(root, results, depth)
--     results = results or {}
--     depth = depth or 1
--
--     for i = 1, root:named_child_count() do
--       -- 範囲内にいれば、それ
--       local x = root:named_child(i-1)
--       if x ~= nil then
--         print(x:type())
--       end
--     end
--     -- for node, _ in root:iter_children() do
--     --   if node:named() then
--     --     if ts_utils.is_in_node_range(node, cursor_row-1, cursor_col) then
--     --       -- カーソル位置に入っていたら入れる
--     --       table.insert(results, node)
--     --     end
--     --     -- depth = depth + 1
--     --     _get_node_at_cursor(node, results, depth)
--     --   end
--     -- end
--     return results
--   end
--   -- ts_utils.get_node_at_cursor() だと、うまくとれなかったため
--   -- token_tree みたいなのをとってしまった
--   -- 深い方を取る
--   _get_node_at_cursor(_root)
--   return ts_utils.get_node_at_cursor()
-- end

local arguments_node_at_cursor = function()
  local node = ts_utils.get_node_at_cursor()
  -- local node = get_node_at_cursor()
  local args_node = nil
  -- function_call になるまでのぼる
  -- 関数名っぽいのを取得、また、関数呼び出しの引数の中かをチェックする？
  local idx = 0
  while node and node:type() ~= 'program' do
    local s_row, s_col, e_row, e_col = ts_utils.get_node_range(node)
    -- pprint(string.format("%s [%d, %d] - [%d, %d]", node:type(), s_row, s_col, e_row, e_col))

    if node:type() == 'arguments' then
      -- args_node = node
      return node
    end

    node = node:parent()
    idx = idx + 1
    if idx > 1000 then
      node = nil
    end
  end
  return args_node
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
    -- pprint(arg_node:type() .. ' ' .. start_col .. ' ' .. end_col)
    if _is_in_node_range(arg_node, cursor_row-1, cursor_col, before_arg_end_line, before_arg_end_col) then
      idx = i
    end
    _, _, before_arg_end_line, before_arg_end_col = arg_node:range()
    if arg_node:type() ~= 'ERROR' then
      valid_node_cnt = valid_node_cnt + 1
    end
  end

  -- pprint(idx .. tostring(ts_utils.is_in_node_range(args, cursor_row-1, cursor_col)))
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


local update_winpos_sig_help = function()
  -- 横の位置だけ変更する
  local win_config = a.nvim_win_get_config(M._winnr)
  local _, col = unpack(a.nvim_win_get_cursor(0))
  win_config.col = col
  a.nvim_win_set_config(M._winnr, win_config)
end

--- See https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_signatureHelp
---@param funcname string
---@param line number 0 base index
---@return function
local make_signature_help_handler = function(funcname, line)
  funcname = funcname or ''
  return function(_, method, result)
    -- pprint(result)
    if not (result and type(result) == 'table' and result.signatures and result.signatures[1]) then
      -- print('No signature help available')
      return
    end

    -- activeSignature よくわからん
    local active_signature = result.activeSignature or 0
    if active_signature >= #result.signatures then
      active_signature = 0
    end

    local signature = result.signatures[active_signature + 1]
    if not signature or signature.label == '' then
      return
    end

    last_sig_info.signature = signature

    -- カーソル下のパラメータを取得
    local parameter = get_param_at_cursor(signature.parameters)
    if not parameter then return end

    -- 関数名より前と、それ以降に分割
    local pre_text, signature_text = split_signature_label(signature.label, funcname)

    -- 関数がある行にfloat windowを表示する
    local _, col = unpack(a.nvim_win_get_cursor(0))
    local _, bufnr = open_floating_window(signature_text, line, col)

    -- パラメータをハイライトする
    update_highlight_param(signature, funcname, bufnr)
    M._bufnr = bufnr
  end
end


local get_funcname = function(node)
  -- function_call のノードの１つ下の子ノードを取る
  local text = ts_utils.get_node_text(ts_utils.get_previous_node(node))[1] or ''
  local re = vim.regex([[\k\+$]])
  local start, _end = re:match_str(text)
  if start and _end then
    return text:sub(start+1, _end)
  end
  return ts_utils.get_node_text(node)
end

-- From vim/lsp/util.lua
local make_position_params = function(line, col)
  return {
    textDocument = lsp_util.make_text_document_params();
    position = {
      line = line,
      character = col
    }
  }
end

local show_signature_help = function()
  if not string.find(a.nvim_get_mode().mode, 'i') then
    -- insert mode じゃない場合、終わり
    return
  end
  -- :h lua-treesitter
  -- カーソル位置のargumentsノードを取得
  local args_node = arguments_node_at_cursor()

  -- 関数呼び出しの中ではない場合、終わり
  if args_node == nil then
    -- ついでに消しておく
    M._clear()
    return
  end
  local funcname = get_funcname(args_node)
  local line, col, _, _ = ts_utils.get_node_range(args_node)
  -- get_node_range() が返すのは、 0 base-index のため、1を加算
  col = col + 1

  -- 関数呼び出しのノードを取得する
  local fcall_node = nil
  while node and node:type() ~= 'program' and not fcall_node do
    if node:type() == 'function_call' then
      fcall_node = node
    end
    node = node:parent()
  end

  -- もし、前のnodeと違う or ウィンドウがない場合、signatureHelp を呼び出す
  if last_sig_info.fcall_node ~= fcall_node or
      not (M._winnr and a.nvim_win_is_valid(M._winnr)) then
    local params = make_position_params(line, col)
    request('textDocument/signatureHelp', params, make_signature_help_handler(funcname, line))
    last_sig_info.fcall_node = fcall_node
  else
    -- 同じなら、ただ単に、ウィンドウを動かして、ハイライトを変えるだけ
    update_winpos_sig_help()
    update_highlight_param(last_sig_info.signature, funcname, M._bufnr)
  end
end


-- From nvim-treesitter-playground/utils.lua
local timer = nil

M._on_timer = function()
  local delay = 50

  -- delayミリ秒後に、show_signature_help() を実行する。
  -- もし、delay ミリ秒内に再度、_on_timer() が呼ばれたら、もう一回、delayミリ秒数える
  if timer ~= nil then
    timer:stop()
    timer:close()
  end
  timer = vim.loop.new_timer()
  -- local interval = 100

  -- vim.schedule_wrap() を使うことで、 vim.~()を使える
  -- start(timeout, repeat, callback)
  timer:start(delay, 0, vim.schedule_wrap(show_signature_help))
end


M._clear = function()
  if M._winnr and a.nvim_win_is_valid(M._winnr) then
    a.nvim_win_close(M._winnr, true)
    M._winnr = nil
    timer:stop()
  end
end

-- echodoc.vim と nvim-treesitter/playglound を参考にする

-- on_attach() で呼び出す想定
M.setup_autocmds = function(bufnr)
  vim.cmd( [[augroup my-signature-help]])
  vim.cmd( [[  autocmd!]])
  vim.cmd(([[  autocmd InsertEnter,CursorMovedI <buffer=%d> lua require'xlsp.signature_help'._on_timer()]]):format(bufnr))
  vim.cmd(([[  autocmd InsertLeave              <buffer=%d> lua require'xlsp.signature_help'._clear()]]):format(bufnr))
  vim.cmd( [[augroup END]])
end

return M
