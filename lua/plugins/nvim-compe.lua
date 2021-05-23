if vim.api.nvim_call_function('FindPlugin', {'nvim-compe'}) == 0 then do return end end

require'compe'.setup {
  enabled = true,
  min_length = 1,
  preselect = 'enable',

  -- allow_prefix_unmatch = false,

  source = {
    path = {ignored_filetypes = {'deoledit'}},
    buffer = {ignored_filetypes = {'deoledit'}},
    -- nvim_lsp = { sort = false },
    nvim_lsp = true,
    -- nvim_lua = {filetypes = {'lua', 'teal'}},
    -- rust はなんか重くなる...
    -- tags = {ignored_filetypes = {'rust', 'markdown', 'md', 'deoledit', 'vim', 'stpl'}},
    vsnip = true,
    -- neosnippet = {ignored_filetypes = {'deoledit'}},
    zsh = {filetypes = {'deoledit'}},
    necosyntax = {filetypes = {'make', 'teal', 'zig', 'i3config', 'ruby', 'sql'}},
    -- nvim_treesitter = {filetypes = {'lua'}},
    -- vim_lsp = true
    math = true,
  }
}

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()',                             {silent = true, expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<CR>',      "compe#confirm(lexima#expand('<LT>CR>', 'i'))", {silent = true, expr = true, noremap = true})
-- vim.api.nvim_set_keymap('i', '<C-e>',     "compe#close('<C-e>')",                         {silent = true, expr = true, noremap = true})

-- if vim.api.nvim_call_function('FindPlugin', {'echodoc.vim'}) == 1 then
--   vim.api.nvim_set_var('echodoc#type', 'floating')
-- end
