if vim.api.nvim_call_function('FindPlugin', {'nvim-compe'}) == 0 then do return end end

require'compe'.setup {
  enabled = true,
  min_length = 1,
  auto_preselect = 'disable',

  allow_prefix_unmatch = false,

  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
    -- rust はなんか重くなる...
    tags = {ignored_filetypes = {'rust', 'markdown', 'md'}},
    vsnip = true,
    neosnippet = true,
  }
}
