if vim.api.nvim_call_function('FindPlugin', {'nvim-compe'}) == 0 then do return end end

local g = vim.g
local a = vim.api

g.compe_enabled = true
g.compe_min_length = 1
g.compe_auto_preselect = false
-- g.compe_source_timeout = 200
-- g.compe_incomplete_delay = 400


-- a.nvim_set_keymap('i', '<CR>', [[compe#confirm(lexima#expand('<LT>CR>', 'i'))]], {'expr', 'noremap'})
-- a.nvim_set_keymap('i', '<C-e>', [[compe#close('<C-e>')]], {'expr', 'noremap'})


require'compe_nvim_lsp'.attach()
require'compe':register_lua_source('nvim_lua', require'compe_nvim_lua')
require'compe':register_lua_source('buffer', require'compe_buffer')
vim.cmd([[call compe#source#vim_bridge#register('path', compe_path#source#create())]])
-- vim.cmd([[call compe#source#vim_bridge#register('tags', compe_tags#source#create())]])
-- vim.cmd([[call compe#source#vim_bridge#register('vsnip', compe_vsnip#source#create())]])
