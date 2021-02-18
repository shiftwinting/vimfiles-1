if vim.api.nvim_call_function('FindPlugin', {'dial.nvim'}) == 0 then do return end end

local dial = require'dial'

-- dial.config.searchlist.normal = {
--   'number#decimal',
--   'number#hex',
--   'number#octal',
--   'number#binary',
--   'number#decimal_integer',
--   'number#decimal_fixeddigit_zero',
--   'number#decimal_fixeddigit_space',
--   'number#decimal_fixeddigit_space',
--   'date["%Y/%m/%d"]',
--   'date["%m/%d"]',
--   'date["%-m/%-d"]',
--   'date["%Y-%m-%d"]',
--   'date["%Y年%-m月%-d日"]',
--   'date["%Y年%-m月%-d日(%ja)"]',
--   'date["%H:%M:%S"]',
--   'date["%H:%M"]',
--   'date["%ja"]',
--   'date["%jA"]',
--   'markup#markdown_header',
-- }

vim.api.nvim_set_keymap('n', '<C-a>', '<Plug>(dial-increment)', {nowait = true})
vim.api.nvim_set_keymap('n', '<C-x>', '<Plug>(dial-decrement)', {nowait = true})
