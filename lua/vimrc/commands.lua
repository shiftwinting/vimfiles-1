require('vimp')

local map_command = require'vimrc.utils'.map_command

map_command('TouchPlugLua', function(name)
  local fname, path
  fname = string.gsub(name, '%.(n?vim)$', '_%1') .. '.lua'
  path = vim.g.lua_plugin_config_dir .. '/' .. fname
  vim.api.nvim_call_function('vimrc#drop_or_tabedit', {path})
end)

map_command('TouchPlugVim', function(name)
  local fname, path
  fname = string.gsub(name, '%.(nvim)$', '_%1') .. '.vim'
  path = vim.g.vim_plugin_config_dir .. '/' .. fname
  vim.api.nvim_call_function('vimrc#drop_or_tabedit', {path})
end)
