vim.api.nvim_set_keymap('n', 'g<', '<Plug>(swap-prev)', {})
vim.api.nvim_set_keymap('n', 'g>', '<Plug>(swap-next)', {})
vim.api.nvim_set_keymap('n', 'gs', '<Plug>(swap-interactive)', {})

-- なんか、警告が出る...
vim.api.nvim_set_keymap('o', 'i,', '<Plug>(swap-textobject-i)', {})
vim.api.nvim_set_keymap('x', 'i,', '<Plug>(swap-textobject-i)', {})
vim.api.nvim_set_keymap('o', 'a,', '<Plug>(swap-textobject-a)', {})
vim.api.nvim_set_keymap('x', 'a,', '<Plug>(swap-textobject-a)', {})
