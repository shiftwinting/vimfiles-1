if vim.api.nvim_call_function('FindPlugin', {'diagnostic-nvim'}) == 0 then do return end end

-- virtual text を使う
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_enable_underline = 0
