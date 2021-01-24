if vim.api.nvim_call_function('FindPlugin', {'nvim-compe'}) == 0 then do return end end

require'compe'.setup {
  enabled = true,
  min_length = 1,
  auto_preselect = 'disable',

  allow_prefix_unmatch = false,

  source = {
    path = {ignored_filetypes = {'deoledit'}},
    buffer = {ignored_filetypes = {'deoledit'}},
    nvim_lsp = true,
    nvim_lua = {filetypes = {'lua', 'teal'}},
    -- rust はなんか重くなる...
    tags = {ignored_filetypes = {'rust', 'markdown', 'md', 'deoledit'}},
    -- vsnip = true,
    neosnippet = {ignored_filetypes = {'deoledit'}},
    zsh = {filetypes = {'deoledit'}},
    necosyntax = {filetypes = {'make', 'teal'}}
  }
}

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {silent = true, expr = true})
