if vim.api.nvim_call_function('FindPlugin', {'diagnostic-nvim'}) == 0 then do return end end

require('vimp')

vimp.nnoremap({'override'}, '<A-j>', ':<C-u>NextDiagnosticCycle<CR>')
vimp.nnoremap({'override'}, '<A-k>', ':<C-u>PrevDiagnosticCycle<CR>')

-- virtual text を使う
vim.g.diagnostic_enable_virtual_text = 1
