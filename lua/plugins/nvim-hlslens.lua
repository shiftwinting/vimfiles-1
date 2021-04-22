if vim.api.nvim_call_function('FindPlugin', {'nvim-hlslens'}) == 0 then do return end end

require'hlslens'.setup()

vim.cmd [[map * <Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]]
vim.cmd [[map g* <Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]]
vim.cmd [[noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]]
vim.cmd [[noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]]
