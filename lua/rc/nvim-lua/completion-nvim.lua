local ok, completion = pcall(require, 'completion')
if not ok then do return end end

-- snippet は neosnippet を使う
vim.g.completion_enable_snippet = 'Neosnippet'

-- 候補がなければ、sourceを切り替える
vim.g.completion_auto_change_source = 1

-- 自動で括弧を挿入する
vim.g.completion_enable_auto_paren = 1

vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

-- ソート
vim.g.completion_sorting = 'length'

-- <C-Space> で補完開始
vimp.imap({'override', 'silent'}, '<C-Space>', '<Plug>(completion_trigger)')

vim.g.completion_enable_auto_popup = 0
-- vimp.imap({'override'}, ' <tab>', ' <Plug>(completion_smart_tab)')
-- vimp.imap({'override'}, '<s-tab>', '<Plug>(completion_smart_s_tab)')

vim.api.nvim_command([[augroup my-completion-nvim]])
vim.api.nvim_command([[  autocmd!]])
vim.api.nvim_command([[  autocmd BufEnter * lua require'completion'.on_attach()]])
vim.api.nvim_command([[augroup END]])

local chain_complete_list = {
  defalt ={
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
  },
  vim = {
    default = {
      {mode = 'omni'},
      {mode = '<c-n>'},
      {mode = '<c-p>'},
      {complete_items = {'snippet'}},
      {complete_items = {'buffers'}},
    },
    string = {
      {complete_items = {'path'}, triggered_only = {'/'}},
      {mode = '<c-n>'},
      {mode = '<c-p>'},
      {mode = 'buffers'},
    },
    comment = {},
  },
  lua = {
    default = {
      {complete_items = {'lsp'}},
      {complete_items = {'buffers'}},
      {complete_items = {'snippet'}},
    },
    string = {
      {complete_items = {'path'}, triggered_only = {'/'}},
      {mode = '<c-n>'},
      {mode = '<c-p>'},
      {complete_items = {'buffers'}},
    },
    comment = {
      {mode = '<c-n>'},
      {mode = '<c-p>'},
    },
  }
}

vim.g.completion_chain_complete_list = chain_complete_list

-- local on_attach = function()
--   require'completion'.on_attach({
--     chain_complete_list = chain_complete_list,
--   })
-- end
-- on_attach()
