if vim.api.nvim_call_function('FindPlugin', {'nvim-treesitter'}) == 0 then do return end end

require('nvim-treesitter.configs').setup{
  ensure_installed = {
    'lua',
    'python',
    'json',
    'c',
  },
  -- highlight = {
  --   enable = true,
  -- },
  -- indent = {
  --   enable = true,
  -- }
  -- rainbow = {
  --   enable = true
  -- }
}
