
local eft_highlight = {
  ['1'] = {
    highlight = 'EftChar',
    allow_space = true,
    allow_operator = true,
  },
  ['2'] = {
    highlight = 'EftSubChar',
    allow_space = false,
    allow_operator = false,
  },
  ['n'] = {
    highlight = 'EftSubChar',
    allow_space = false,
    allow_operator = false,
  }
}
vim.api.nvim_set_var('eft_highlight', eft_highlight)

vim.api.nvim_set_keymap('n', 'f', '<Plug>(eft-f-repeatable)', {})
vim.api.nvim_set_keymap('x', 'f', '<Plug>(eft-f-repeatable)', {})
vim.api.nvim_set_keymap('o', 'f', '<Plug>(eft-f-repeatable)', {})
vim.api.nvim_set_keymap('n', 'F', '<Plug>(eft-F-repeatable)', {})
vim.api.nvim_set_keymap('x', 'F', '<Plug>(eft-F-repeatable)', {})
vim.api.nvim_set_keymap('o', 'F', '<Plug>(eft-F-repeatable)', {})

vim.api.nvim_set_keymap('n', 't', '<Plug>(eft-t-repeatable)', {})
vim.api.nvim_set_keymap('x', 't', '<Plug>(eft-t-repeatable)', {})
vim.api.nvim_set_keymap('o', 't', '<Plug>(eft-t-repeatable)', {})
vim.api.nvim_set_keymap('n', 'T', '<Plug>(eft-T-repeatable)', {})
vim.api.nvim_set_keymap('x', 'T', '<Plug>(eft-T-repeatable)', {})
vim.api.nvim_set_keymap('o', 'T', '<Plug>(eft-T-repeatable)', {})

