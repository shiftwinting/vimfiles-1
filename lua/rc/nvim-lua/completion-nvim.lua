local ok, completion = pcall(require, 'completion')
if not ok then do return end end

-- snippet は neosnippet を使う
vim.g.completion_enable_snippet = 'Neosnippet'

-- 候補がなければ、sourceを切り替える
vim.g.completion_auto_change_source = 1

-- <C-Space> で補完開始
vimp.imap({'override', 'silent'}, '<C-Space>', '<Plug>(completion_trigger)')

vim.api.nvim_command([[augroup my-completion-nvim]])
vim.api.nvim_command([[  autocmd!]])
vim.api.nvim_command([[  autocmd BufEnter * lua require'completion'.on_attach()]])
vim.api.nvim_command([[augroup END]])

local chain_complete_list = {
  default = {
    {complete_items = {'lsp', 'snippet'}},
    {complete_items = {'path'}, triggered_only = {'/'}},
    {complete_items = {'buffers'}},
  },
  string = {
    {complete_items = {'path'}, triggered_only = {'/'}},
    {complete_items = {'buffers'}},
  },
  comment = {},
  vim = {
    {complete_items = {'lsp', 'snippet'}},
    {mode = '<c-n>'},
    {mode = '<c-p>'},
    {mode = 'omni'}
  }
}

vim.g.completion_chain_complete_list = chain_complete_list

-- local on_attach = function()
--   require'completion'.on_attach({
--     chain_complete_list = chain_complete_list,
--   })
-- end
-- on_attach()
