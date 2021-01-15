if vim.api.nvim_call_function('FindPlugin', {'nvim-scrollview'}) == 0 then do return end end

vim.g.scrollview_winblend = 80
vim.g.scrollview_column = 1
