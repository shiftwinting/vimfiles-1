
local mappings = {
  ['n<A-j>'] = {':<C-u>lua vim.lsp.diagnostic.goto_next()<CR>'},
  ['n<A-k>'] ={ ':<C-u>lua vim.lsp.diagnostic.goto_prev()<CR>'},
}
nvim_apply_mappings(mappings, {silent = true, noremap = true})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  -- :h vim.lsp.diagnostic.on_publish_diagnostics(l
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- :h vim.lsp.diagnostic.set_virtual_text()
    virtual_text = {
      prefix = '',
      spacing = 4
    },
    signs = true,
    update_in_insert = false,
  }
)
