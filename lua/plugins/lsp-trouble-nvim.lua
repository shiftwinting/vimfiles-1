if vim.api.nvim_call_function('FindPlugin', {'lsp-trouble.nvim'}) == 0 then do return end end

require'trouble'.setup {
  height = 20,
  icons = true,
  fold_open = ' ',
  fold_close = ' ',
  signs = {
    error = ' ',
    warning = ' ',
    hint = ' ',
    information = '󿯦 ',
  }
}

vim.api.nvim_set_keymap("n", "<A-d>", "<cmd>LspTroubleDocumentToggle<cr>",
  {silent = true, noremap = true}
)
