if vim.api.nvim_call_function('FindPlugin', {'nvim-treesitter'}) == 0 then do return end end

require('nvim-treesitter.configs').setup{
  ensure_installed = {
    'lua',
    'python',
    'json',
    'c',
    -- 'query',
    'javascript',
  },
  highlight = {
    enable = true,
  },
  -- indent = {
  --   enable = true,
  -- }
  rainbow = {
    enable = true
  },
  playground = {
    enable = true
  }
}
