local ok, _ = pcall(require, 'diagnostic')
if not ok then do return end end

local vimp = require('vimp')

vimp.nnoremap({'override'}, '<A-j>', ':<C-u>NextDiagnosticCycle<CR>')
vimp.nnoremap({'override'}, '<A-k>', ':<C-u>PrevDiagnosticCycle<CR>')

-- virtual text を使う
vim.g.diagnostic_enable_virtual_text = 1
