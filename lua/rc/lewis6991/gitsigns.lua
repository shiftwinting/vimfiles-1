local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then do return end end

gitsigns.setup{
  signs = {
    add = {hl = 'DiffAdd', text = '+'},
    change = {hl = 'DiffChange', text = '~'},
    delete = {hl = 'DiffDelete', text = '_'},
    topdelete = {hl = 'DiffDelete', text = '_'},
    changedelete = {hl = 'DiffChange', text = '~'},
  }
}
