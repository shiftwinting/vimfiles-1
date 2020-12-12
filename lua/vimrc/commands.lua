--- TouchPlugLua
function _G._TouchPlugLua(name)
  local fname, path
  fname = string.gsub(name, '%.(n?vim)$', '_%1') .. '.lua'
  path = vim.g.lua_plugin_config_dir .. '/' .. fname
  vim.api.nvim_call_function('vimrc#drop_or_tabedit', {path})
end
vim.cmd([[command! -nargs=1 TouchPlugLua lua _TouchPlugLua(<f-args>)]])


--- TouchPlugVim
function _G._TouchPlugVim(name)
  local fname, path
  fname = string.gsub(name, '%.nvim$', '_nvim')
  if not string.match(fname, '%.vim') then
    fname = fname .. '.vim'
  end
  path = vim.g.vim_plugin_config_dir .. '/' .. fname
  vim.api.nvim_call_function('vimrc#drop_or_tabedit', {path})
end
vim.cmd([[command! -nargs=1 TouchPlugVim lua _TouchPlugVim(<f-args>)]])


--- PackGet
function _G._PackGet(name)
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

  vim.cmd('botright 10new')
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':quit!<CR>', { silent = true })
  vim.fn.termopen({'git', 'clone', url, dist})
end
vim.cmd([[command! -nargs=1 PackGet lua _PackGet(<f-args>)]])


--- GhqGet
function _G._GhqGet(url)
  vim.cmd('botright 10new')
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':quit!<CR>', { silent = true })
  vim.fn.termopen({'ghq', 'get', url})
end
vim.cmd([[command! -nargs=1 GhqGet lua _G._GhqGet(<f-args>)]])
