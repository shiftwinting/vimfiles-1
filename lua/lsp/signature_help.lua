--[[
  InsertMode に入ると、signature help を表示する
]]

local a = vim.api
local lsp_util = require'vim.lsp.util'
local ts_utils = require'nvim-treesitter.ts_utils'
local parsers = require'nvim-treesitter.parsers'

local M = {
  -- _winnr,
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

local highlight_params = function(bufnr, start_col, end_col)
  a.nvim_buf_add_highlight(bufnr, ns, 'TSText', 0, start_col, end_col)
end

--- ウィンドウの一番上に表示されているカレントバッファの行の番号 (1 base-index)
local win_topline_lnum = function()
  return vim.fn.line('.') - vim.fn.winline() + 1
end

local open_floating_window = function(text, line, col)
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

-- From vim/lsp/util.lua
-- @return (start, end)
local get_active_param_range = function(signature_label, parameter_label)
  -- string | [uinteger, uinteger]
  if type(parameter_label) == 'table' then
    -- [uinteger, uinteger] なら、そのまま返す
    return parameter_label
  end

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

local arguments_node_at_cursor = function()
  local node = ts_utils.get_node_at_cursor()
  local args_node = nil
  -- function_call になるまでのぼる
  -- 関数名っぽいのを取得、また、関数呼び出しの引数の中かをチェックする？
  local idx = 0
  while node and node:type() ~= 'program' and args_node == nil do
    if node:type() == 'arguments' then
      args_node = node
    end
    node = node:parent()
    idx = idx + 1
    if idx > 10 then
      node = nil
    end
  end
  return args_node
end

-- カーソル下の arguments ノードの引数の位置を返す (1始まり)
local args_node_idx_at_cursor = function()
  -- TODO: 引数の数以降のどーするか
  --@param node
  --@param line 0 base
  --@param col 0 base
  --@param before_arg_end_col nilなら、start_colを使う (1つ目の引数はnilを想定)
  local _is_in_node_range = function(node, line, col, before_arg_end_col)
    local start_line, start_col, end_line, end_col = node:range()
    start_col = (before_arg_end_col and before_arg_end_col + 1) or start_col

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

  local before_arg_end_col = nil
  local idx = -1
  local cursor_row, cursor_col = unpack(a.nvim_win_get_cursor(0))
  local valid_node_cnt = 0
  for i = 1, args:named_child_count() do
    -- 範囲内にいれば、それ
    local arg_node = args:named_child(i-1)
    -- local _, start_col, _, end_col = arg_node:range()
    -- pprint(arg_node:type() .. ' ' .. start_col .. ' ' .. end_col)
    if _is_in_node_range(arg_node, cursor_row-1, cursor_col, before_arg_end_col) then
      idx = i
    end
    _, _, _, before_arg_end_col = arg_node:range()
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

-- @param funcname (string)
-- @param line (number)
-- @param col (number)
-- see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_signatureHelp
local make_signature_help_handler = function(funcname, line, col, args_node)
  funcname = funcname or ''
  return function(_, method, result)
    if not (result and type(result) == 'table' and result.signatures and result.signatures[1]) then
      -- print('No signature help available')
      return
    end

    local active_signature = result.activeSignature or 0
    -- If the activeSignature is not inside the valid range, then clip it.
    if active_signature >= #result.signatures then
      active_signature = 0
    end
    local signature = result.signatures[active_signature + 1]
    if not signature then
      return
    end

    -- 現在のargsの位置 (前から何個目か) を取得
    local idx = args_node_idx_at_cursor()
    if idx == -1 then
      idx = 1
    end
    local parameter = signature.parameters[idx]
    if not parameter then
      return
    end

    -- active param column
    local text = signature.label
    if text == '' then
      return
    end
    -- 関数名より前を消す (別名を付けられていたら、うまく消せない)
    -- local signature_text = text:gsub('^.*' .. funcname, funcname)
    -- '-' は最短一致
    local pre_text, signature_text = text:match(string.format('^(.-)(%s.*)', funcname))
    -- 1は微調整
    col = col - #funcname + 1
    local _, bufnr = open_floating_window(signature_text, line, col)

    -- ハイライトする
    local p_start, p_end = unpack(get_active_param_range(signature.label, parameter.label))
    if p_start == -1 then
      return
    end
    p_start, p_end = p_start - #pre_text, p_end - #pre_text
    highlight_params(bufnr, p_start, p_end)
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
  -- 0 base-index のため、1を加算
  col = col + 1

  -- 関数呼び出しのノードを取得する
  -- local fcall_node = nil
  -- while node and node:type() ~= 'program' and not fcall_node do
  --   if node:type() == 'function_call' then
  --     fcall_node = node
  --   end
  --   node = node:parent()
  -- end

  -- 現在、表示中の関数呼び出しのノードと異なる or シグニチャが表示されていない
  -- if M.args_node ~= args_node or M._winnr == nil then
  --   M.args_node = args_node
  local params = make_position_params(line, col)
  request('textDocument/signatureHelp', params, make_signature_help_handler(funcname, line, col, args_node))
  -- else
  --   -- 引数のハイライト
  --   highlight_params()
  -- end
end


-- From nvim-treesitter-playground/utils.lua
local timer = nil

M._on_timer = function()
  if timer ~= nil then
    timer:stop()
    timer:close()
  end
  timer = vim.loop.new_timer()

  local delay = 100
  local interval = 100

  -- vim.schedule_wrap() を使うことで、 vim.api~を使える
  -- start(timeout, repeat, callback)
  -- delay ミリ秒後に、show_signature_help() を実行する。
  -- また、interval ミリ秒ごとに show_signature_help() を実行する
  timer:start(delay, interval, vim.schedule_wrap(show_signature_help))
end

M._clear = function()
  vim.defer_fn(function()
    if M._winnr and a.nvim_win_is_valid(M._winnr) then
      a.nvim_win_close(M._winnr, true)
      M._winnr = nil
      timer:stop()
    end
  end, 30)
end

-- echodoc.vim と nvim-treesitter/playglound を参考にする

-- on_attach() で呼び出す想定
M.setup_autocmds = function()
  vim.cmd [[augroup my-signature-help]]
  vim.cmd [[  autocmd!]]
  vim.cmd [[  autocmd InsertEnter,CursorMovedI <buffer> lua require'lsp.signature_help'._on_timer()]]
  vim.cmd [[  autocmd InsertLeave              <buffer> lua require'lsp.signature_help'._clear()]]
  vim.cmd [[augroup END]]
end

return M
