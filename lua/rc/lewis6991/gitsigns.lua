if vim.api.nvim_call_function('FindPlugin', {'gitsigns.nvim'}) == 0 then do return end end

require'gitsigns'.setup{
  signs = {
    add = {hl = 'DiffAdd', text = '+'},
    change = {hl = 'DiffChange', text = '~'},
    delete = {hl = 'DiffDelete', text = '_'},
    topdelete = {hl = 'DiffDelete', text = '_'},
    changedelete = {hl = 'DiffChange', text = '~'},
  }
}
