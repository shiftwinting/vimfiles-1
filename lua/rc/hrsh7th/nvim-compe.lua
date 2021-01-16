if vim.api.nvim_call_function('FindPlugin', {'nvim-compe'}) == 0 then do return end end

require'compe'.setup {
  enabled = true,
  min_length = 1,
  auto_preselect = 'disable',

  allow_prefix_unmatch = false,

  source = {
    path = {ignored_filetypes = {'zsh'}},
    buffer = {ignored_filetypes = {'zsh'}},
    nvim_lsp = true,
    nvim_lua = true,
    -- rust はなんか重くなる...
    tags = {ignored_filetypes = {'rust', 'markdown', 'md', 'zsh'}},
    -- vsnip = true,
    neosnippet = {ignored_filetypes = {'zsh'}},
    zsh = {filetypes = {'zsh'}},
    necosyntax = {filetypes = {'make'}}
  }
}

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {silent = true, expr = true})
