-- If there is a code_action on the current line, set the virtual text
-- original idea: https://github.com/kosayoda/nvim-lightbulb

local a = vim.api
local lsp_util = vim.lsp.util

-----------------------------
-- Private
-----------------------------
local ns = a.nvim_create_namespace('mini_lightbulb')


-----------------------------
-- Export
-----------------------------
local M = {}


M.set_virtual_text = function(bufnr)
  M.clear_virtual_text(bufnr)

  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local params = lsp_util.make_range_params()
  params.context = context

  local handler = function(err, _, actions)
    if err then
      -- print('Error "textDocument/codeAction"')
      return
    end
    if actions and not vim.tbl_isempty(actions) then
      a.nvim_buf_set_virtual_text(bufnr, ns, params.range.start.line, {{'  󿯦', 'Yellow'}}, {})
      -- from vim/lsp/util.lua
      vim.cmd (
        (
          [[autocmd CursorMoved,CursorMovedI,BufHidden,BufLeave <buffer=%d> ++once lua require'xlsp.mini_lightbulb'.clear_virtual_text(%d)]]
        ):format(
          bufnr, bufnr
        )
      )
    end
  end

  vim.lsp.buf_request(bufnr, 'textDocument/codeAction', params, handler)
end

M.clear_virtual_text = function(bufnr)
  a.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
end

-- on_attach() で呼び出す想定
-- From: nvim-treesitter/nvim-treesitter-refactor
M.setup_autocmds = function(bufnr)
  vim.cmd( [[augroup mini_lightbulb]])
  vim.cmd( [[  autocmd!]])
  vim.cmd(([[  autocmd CursorHold <buffer=%d> lua require'xlsp.mini_lightbulb'.set_virtual_text(%d)]]):format(bufnr, bufnr))
  vim.cmd( [[augroup END]])
end

return M

