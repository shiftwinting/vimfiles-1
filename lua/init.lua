require('vimrc.mappings')
require('vimrc.commands')
require('vimrc.lsp.diagnostic')

local utils = require('vimrc.utils')

utils.load_rc_files()


-- https://github.com/tjdevries/config_manager/blob/49fe3dc80f077b051f3bfb958413ff6e74920f83/xdg_config/nvim/lua/init.lua
-- 1回のみ実行する
if false then
  local neorocks = require('plenary.neorocks')

  -- package-name, lua-name
  neorocks.install('penlight', 'pl')
  neorocks.install('microlight', 'ml')

  -- local pl = require'pl' で使える！
end
