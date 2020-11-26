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
  fname = string.gsub(name, '%.nvim$', '_nvim')
  if not string.match(fname, '%.vim') then
    fname = fname .. '.vim'
  end
  path = vim.g.vim_plugin_config_dir .. '/' .. fname
  vim.api.nvim_call_function('vimrc#drop_or_tabedit', {path})
end)


map_command('PackGet', function(name)
  local url, plug_name, dist
  if string.match(name, '^http') then
    url = name
  else
    url = 'https://github.com/' .. name
  end

  plug_name = string.match(name, '[^/]+$')
  dist = vim.g.vimfiles_path .. '/pack/plugs/opt' .. '/' .. plug_name
  if vim.fn.isdirectory(dist) == 1 then
    print(" [PackGet] Already exists. '" .. plug_name .. "'")
    return
  end

  require'plenary.run'.with_displayed_output( {'packget...'}, string.format('git clone %s %s', url, dist))
end)
