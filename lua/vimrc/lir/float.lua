local win_float = require'plenary.window.float'
local History = require'lir.history'
local Buffer = require'lir.buffer'
local Actions = require'lir.actions'

local M = {}


local function close_win()
  vim.api.nvim_win_close(0, true)
end
M.quit = close_win


local function current_path()
  return vim.fn.fnameescape(Buffer.curdir() .. Buffer.current())
end


local function open(cmd)
  local filename = current_path()
  close_win()
  vim.cmd(cmd .. ' ' .. filename)
end


M.init = function()
  local dir = vim.fn.expand('%:p:h')
  win_float.centered({
    percentage = 0.4
  })
  vim.cmd('edit ' .. vim.fn.fnameescape(dir))
  vim.w.lir_float = true
end


M.edit = function()
  local dir, file = Buffer.curdir(), Buffer.current()
  if vim.w.lir_float and not Buffer.is_dir_current() then
    -- もし、float window で ファイルを開く場合、flowt window を閉じる
    close_win()
  end
  -- 代替フ ァイルを変更しないで開く (<C-^)
  vim.cmd('keepalt edit ' .. vim.fn.fnameescape(dir .. file))
  History.add(dir, file)
end


M.split = function()
  open('new')
end


M.vsplit = function()
  open('vnew')
end


M.tabopen = function()
  open('tabe')
end


M.newfile = function()
  vim.api.nvim_feedkeys(':close | :new ' .. Buffer.curdir(), 'n', true)
end

return M
