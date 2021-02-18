if vim.api.nvim_call_function('FindPlugin', {'FixCursorHold.nvim'}) == 0 then do return end end

vim.g.cursorhold_updatetime = 100
