if vim.api.nvim_call_function('FindPlugin', {'which-key.nvim'}) == 0 then do return end end

require'which-key'.setup()
