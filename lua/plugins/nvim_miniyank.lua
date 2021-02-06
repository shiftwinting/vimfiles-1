if vim.api.nvim_call_function('FindPlugin', {'nvim-miniyank'}) == 0 then do return end end

map = vim.api.nvim_set_keymap

map('n', 'p',     '<Plug>(miniyank-autoput)',  {})
map('n', 'P',     '<Plug>(miniyank-autoPut)',  {})
map('n', '<C-p>', '<Plug>(miniyank-cycle)',     {})
map('n', '<C-n>', '<Plug>(miniyank-cycleback)', {})
