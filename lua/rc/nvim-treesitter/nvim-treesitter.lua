local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')
if not ok then do return end end

require('nvim-treesitter.configs').setup{
  ensure_installed = {
    'lua',
    'python',
    'json',
    'c',
  }
}
