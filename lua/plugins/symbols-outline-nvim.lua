if vim.api.nvim_call_function('FindPlugin', {'symbols-outline.nvim'}) == 0 then do return end end

require'symbols-outline'.setup {}
