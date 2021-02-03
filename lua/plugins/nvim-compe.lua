require'compe'.setup {
  enabled = true,
  min_length = 2,
  preselect = 'always',

  allow_prefix_unmatch = true,

  source = {
    path       = {ignored_filetypes = {'deoledit'}},
    buffer     = {ignored_filetypes = {'deoledit'}},
    nvim_lsp   = true,
    nvim_lua   = {filetypes = {'lua', 'teal'}},
    -- rust はなんか重くなる...
    -- tags = {ignored_filetypes = {'rust', 'markdown', 'md', 'deoledit', 'lua', 'vim'}},
    -- vsnip = true,
    neosnippet = {ignored_filetypes = {'deoledit'}},
    zsh        = {filetypes = {'deoledit'}},
    necosyntax = {filetypes = {'make', 'teal'}}
  }
}

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {silent = true, expr = true})
vim.api.nvim_set_keymap('i', '<CR>', [[compe#confirm(lexima#expand('<LT>CR>', 'i'))]], {silent = true, expr = true})
