if vim.api.nvim_call_function('FindPlugin', {'nvim-compe'}) == 0 then do return end end

require'compe'.setup {
  enabled = true,
  min_length = 2,
  preselect = 'always',

  allow_prefix_unmatch = false,

  source = {
    path = {ignored_filetypes = {'deoledit'}},
    buffer = {ignored_filetypes = {'deoledit'}},
    nvim_lsp = true,
    nvim_lua = {filetypes = {'lua', 'teal'}},
    -- rust はなんか重くなる...
    tags = {ignored_filetypes = {'rust', 'markdown', 'md', 'deoledit', 'vim'}},
    -- vsnip = true,
    neosnippet = {ignored_filetypes = {'deoledit'}},
    -- zsh = {filetypes = {'deoledit'}},
    -- necosyntax = {filetypes = {'make', 'teal'}},
    -- nvim_treesitter = {filetypes = {'lua'}},
  }
}

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {silent = true, expr = true})
vim.api.nvim_set_keymap('i', '<CR>', [[compe#confirm(lexima#expand('<LT>CR>', 'i'))]], {silent = true, expr = true})
