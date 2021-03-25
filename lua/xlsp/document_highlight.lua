--[[
  documentHighlight をいい感じにする
  nミリ秒後にハイライトして、カーソル移動しても、ハイライトの範囲なら、消さないようにした
]]

local a = vim.api

local lsp, lsp_buf, util
local has_nlsp, _ = pcall(require, 'nlsp')
if has_nlsp then
  lsp = require'nlsp'
  lsp_buf = require'nlsp.buf'
  util = require'nlsp.util'
else
  lsp = vim.lsp
  lsp_buf = vim.lsp.buf
  util = vim.lsp.util
end

local M = {}

local buf_highlights = {
  -- bufnr = {
  --   start_pos,
  --   end_pos
  -- }
}

--- カーソル位置がハイライトされているか？
local in_highlight_range = function(bufnr)
  bufnr = bufnr or a.nvim_get_current_buf()
  if not buf_highlights[bufnr] then
    return false
  end

  local line, col = unpack(a.nvim_win_get_cursor(0))
  line = line - 1

  for _, reference in ipairs(buf_highlights[bufnr]) do
    local start_line = reference['start_pos']['line']
    local start_col = reference['start_pos']['col']
    local end_line = reference['end_pos']['line']
    local end_col = reference['end_pos']['col'] - 1

    -- まずは大雑把に
    if line >= start_line and line <= end_line then
      if line == start_line and line == end_line then
        -- 1行内で収まっている
        return col >= start_col and col <= end_col
      elseif line == start_line then
        -- 複数行で、最初の行にカーソルがある
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
end

local clear_highlight = function()
  if not in_highlight_range() then
    lsp_buf.clear_references()
  end
end

local document_highlight_handler = function(_, _, result, _, bufnr, _)
  if not result then return end
  util.buf_highlight_references(bufnr, result)

  -- 範囲を保存する
  buf_highlights[bufnr] = {}
  for _, reference in ipairs(result) do
    table.insert(buf_highlights[bufnr], {
      start_pos = {
        line = reference['range']['start']['line'],
        col = reference['range']['start']['character']
      },
      end_pos = {
        line = reference['range']['end']['line'],
        col = reference['range']['end']['character'],
      },
    })
  end
end

local document_highlight = function()
  clear_highlight()

  local params = util.make_position_params()
  lsp.buf_request(0, 'textDocument/documentHighlight', params, document_highlight_handler)
end


local timer = nil

M._on_timer = function()
  local delay = 400

  -- delayミリ秒後に、show_signature_help() を実行する。
  -- もし、delay ミリ秒内に再度、_on_timer() が呼ばれたら、もう一回、delayミリ秒数える
  if timer ~= nil then
    timer:stop()
    timer:close()
  end
  timer = vim.loop.new_timer()

  -- vim.schedule_wrap() を使うことで、 vim.~()を使える
  -- start(timeout, repeat, callback)
  timer:start(delay, 0, vim.schedule_wrap(document_highlight))
end

M._clear = function(bufnr)
  clear_highlight()

  if timer ~= nil then
    timer:stop()
  end
end

-- on_attach() で呼び出す想定
M.setup_autocmds = function(bufnr)
  local hi_events = table.concat({ 'CursorHold' }, ',')
  local clear_events = table.concat({ 'InsertEnter', 'CursorMoved', 'CursorMovedI', 'BufLeave', 'WinLeave' }, ',')
  vim.cmd( [[augroup xlsp_document_highlight]])
  vim.cmd( [[  autocmd!]])
  vim.cmd(([[  autocmd %s <buffer=%d> lua require'xlsp.document_highlight'._on_timer()]]):format(hi_events, bufnr))
  vim.cmd(([[  autocmd %s <buffer=%d> lua require'xlsp.document_highlight'._clear(%d)]]):format(clear_events, bufnr, bufnr))
  vim.cmd( [[augroup END]])
end


return M
