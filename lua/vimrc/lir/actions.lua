local actions = {}

local uv = vim.loop
local api = vim.api

local lir = require'vimrc.lir'
local history = require'vimrc.lir.history'


local SPACE = ' '


local esc_current = function ()
  return vim.fn.fnameescape(lir.current())
end

actions.edit = function ()
  vim.cmd('edit ' .. vim.b.lir_dir .. esc_current())
end


actions.split = function ()
  local filename = esc_current()
  actions.quit()
  vim.cmd('new ' .. filename)
end


actions.vsplit = function ()
  local filename = esc_current()
  actions.quit()
  vim.cmd('vnew ' .. filename)
end


actions.up = function ()
  local cur_file, path, name, dir

  cur_file = lir.current()
  path = string.gsub(vim.b.lir_dir, '/$', '')
  name = vim.fn.fnamemodify(path, ':t')
  if name == '' then
    return
  end
  dir = vim.fn.fnamemodify(path, ':p:h:h')
  vim.cmd('edit ' .. dir)
  lir.set_cursor(lir.indexof(name))

  history.add(path, cur_file)
end


actions.quit = function ()
  vim.cmd('edit ' .. vim.w.alf_file)
end


actions.mkdir = function ()
  local name = vim.fn.input('Create directory: ')
  if name == '' then
    return
  end

  if name == '.' or name == '..' or string.match(name, '[/\\]') then
    lir.error('Invalid directory name: ' .. name)
    return
  end

  if vim.fn.mkdir(lir.curdir() .. name) == 0 then
    lir.error('Create directory failed')
    return
  end

  actions.reload()
  vim.fn.search(string.format([[\v^%s]], name .. '/'), 'c')
end


actions.rename = function ()
  local old = string.gsub(lir.current(), '/$', '')
  local new = vim.fn.input('Rename: ', old)
  if new == '' or new == old then
    return
  end

  if new == '.' or new == '..' or string.match(new, '[/\\]') then
    lir.error('Invalid name: ' .. new)
    return
  end

  if not uv.fs_rename(lir.curdir() .. old, lir.curdir() .. new) then
    lir.error('Rename failed')
  end

  actions.reload()
end


actions.delete = function ()
  local name = lir.current()

  if vim.fn.confirm('Delete?: ' .. name, '&Yes\n&No\n&Force', 2) == 2 then
    return
  end

  local path = lir.curdir() .. name
  if vim.fn.isdirectory(path) == 1 then
    if not uv.fs_rmdir(path) then
      lir.error('Delete directory failed')
      return
    end
  else
    if not uv.fs_unlink(path) then
      lir.error('Delete file failed')
      return
    end
  end

  actions.reload()
end


actions.newfile = function()
  api.nvim_feedkeys(':edit ' .. lir.curdir(), 'n', true)
end


actions.cd = function ()
  vim.cmd(string.format([[silent execute (haslocaldir() ? 'lcd' : 'cd') '%s']], lir.curdir()))
  print('cd: ' .. lir.curdir())
end


actions.reload = function ()
  vim.cmd([[edit]])
end


actions.yank_path = function ()
  local path = lir.curdir() .. lir.current()
  vim.fn.setreg(vim.v.register, path)
  print('Yank path: ' .. path)
end


actions.toggle_show_hidden = function ()
  vim.b.lir_show_hidden = not (vim.b.lir_show_hidden or false)
  actions.reload()
end

return actions
