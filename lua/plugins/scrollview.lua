if vim.api.nvim_call_function('FindPlugin', {'nvim-scrollview'}) == 0 then do return end end

vim.g.scrollview_winblend = 80
vim.g.scrollview_column = 1

vim.g.scrollview_excluded_filetypes = {'deol'}
vim.g.scrollview_current_only = 1
