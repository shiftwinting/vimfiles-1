if vim.api.nvim_call_function('FindPlugin', {'gitsigns.nvim'}) == 0 then do return end end

-- http://www.shurey.com/js/works/unicode.html

require'gitsigns'.setup{
  signs = {
    -- add = {hl = 'GitSignAdd', text = '▏'},
    add = {hl = 'GitSignAdd', text = '▎'},
    change = {hl = 'GitSignChange', text = '▎'},
    delete = {hl = 'GitSignDelete', text = '_'},
    topdelete = {hl = 'GitSignDelete', text = '_'},
    changedelete = {hl = 'GitSignChange', text = '~'},
  },
  -- keymaps = {
  --   noremap = true,
  --
  --   ['n gh'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>'
  -- }
}

vim.cmd[[command! GitStageHank lua require"gitsigns".stage_hunk()]]
