vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>(neosnippet_expand_or_jump)', {})
vim.api.nvim_set_keymap('s', '<C-k>', '<Plug>(neosnippet_expand_or_jump)', {})

vim.api.nvim_set_var('neosnippet#snippets_directory', vim.fn.expand('$MYVIMFILES/snippets'))
