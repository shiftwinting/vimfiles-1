local popup = require 'popup'
local window = require 'plenary.window'
local utils = require 'vimrc.utils'

local fn = vim.fn
local api = vim.api

local default_state = {
  height = 30,
  save_updatetime = 0,
  winid = nil,
  auto_preview = true,
}

local state = {}

local qfpreview = {}


--- qfpreview.cleanup
function qfpreview.cleanup()
  vim.o.updatetime = state.save_updatetime
end


--- open
local function open(idx)
  if vim.bo.buftype ~= 'quickfix' then
    return
  end

  local qflist = fn.getqflist()
  if #qflist == 0 then
    return
  end

  local qfitem = qflist[idx]
  -- if not qfitem.valid or qfitem.bufnr == 0 then
  --   return
  -- end

  local wininfo = fn.getwininfo(fn.win_getid())[1]
  local line = wininfo.winrow - 1
  local col = wininfo.wincol
  local width = wininfo.width

  -- local title = string.format('%s (%d/%d)',
  --                             fn.fnamemodify(fn.bufname(qfitem.bufnr), ':~:.'),
  --                             idx, #qflist)

  local firstline = qfitem.lnum

  if not api.nvim_buf_is_loaded(qfitem.bufnr) then
    vim.fn.bufload(qfitem.bufnr)
  end

  local lines = api.nvim_buf_get_lines(qfitem.bufnr, 0, -1, false)
  if not state.winid or not api.nvim_win_is_valid(state.winid) then
    qfpreview.close()
    winid, info = popup.create(qfitem.bufnr, {
      pos = 'botleft',
      col = col,
      line = line,
      -- padding のため
      minwidth = width - 2,
      maxwidth = width - 2,
      maxheight = state.height,
      minheight = state.height,
      -- title = title,
      -- firstline = firstline
      padding = {0, 1, 0, 1},
      enter = false,
    })

    -- XXX: なぜか、 focusable = false を先にやらないと、cursorline とか設定できなかった
    -- api.nvim_win_set_config(winid, {focusable = false})
  else
    api.nvim_win_set_buf(winid, qfitem.bufnr)
  end

  -- vim.t.qfpreview_bufnr = api.nvim_win_get_buf(winid)

  -- vim.bo.modifiable = true

  -- api.nvim_buf_set_lines(vim.t.qfpreview_bufnr, 0, -1, false, lines)
  api.nvim_win_set_cursor(winid, {qfitem.lnum, qfitem.col - 1})
  api.nvim_win_set_option(winid, 'cursorline', true)
  api.nvim_win_set_option(winid, 'number', true)
  api.nvim_win_set_option(winid, 'signcolumn', 'no')
  api.nvim_win_set_option(winid, 'signcolumn', 'no')

  api.nvim_buf_set_option(qfitem.bufnr, 'bufhidden', 'hide')

  -- vim.bo.modified = false
  -- vim.bo.modifiable = false

  state.winid = winid
end

--- qfpreview.show
function qfpreview.show()
  qfpreview.cleanup()
  open(vim.fn.line('.'))
end


--- qfpreview.close
function qfpreview.close()
  if state.winid then
    window.try_close(state.winid)
  end
  state.winid = nil
end


--- CursorMoved
function qfpreview.OnCursorMoved()
  vim.o.updatetime = 50

  if not state.auto_preview then
    if state.winid then
      window.try_close(state.winid)
    end
    state.winid = nil
  end
end

-- CursorHold
function qfpreview.OnCursorHold()
  if state.auto_preview then
    qfpreview.show()
  end
end

function qfpreview.edit()
  local cur_line = api.nvim_get_current_line()
  local fname = string.gsub(cur_line, '|.*', '')
  local line = string.match(cur_line, '^.*|(%d+)')
  local col = string.match(cur_line, '^.*|%d+ col (%d+)')

  if not fname then
    return
  end

  qfpreview.close()
  vim.cmd('wincmd p')
  if line then
    vim.cmd(string.format('edit +%d %s', line, fn.fnameescape(fname)))
  else
    vim.cmd(string.format('edit %s', fn.fnameescape(fname)))
  end
  -- ファイルタイプの再検出
  vim.cmd('filetype detect')
end


--- qfpreview.setup_autocommands
function setup_autocommands()
  local autocommands = {
    {'CursorHold',         '<buffer>', [[lua require'vimrc.qfpreview'.OnCursorHold()]]},
    {'CursorMoved',        '<buffer>', [[lua require'vimrc.qfpreview'.OnCursorMoved()]]},
    {'BufLeave',           '<buffer>', [[lua require'vimrc.qfpreview'.cleanup()]]},
    {'WinClosed,WinLeave,BufWinLeave', '<buffer>', [[lua require'vimrc.qfpreview'.close()]]},
    -- {'WinLeave', '<buffer>', [[lua require'vimrc.qfpreview'.close()]]},
  }

  utils.create_augroups({['my-qfpreview'] = autocommands})
end


function qfpreview.init(bufnr)
  qfpreview.close()
  state = vim.tbl_extend("force", default_state, {
    save_updatetime = vim.o.updatetime
  })

  setup_autocommands()
end


function qfpreview.toggle_auto_preview()
  state.auto_preview = not state.auto_preview
  vim.cmd(string.format([[echo '[qf-preview.nvim] auto preview %s']], (state.auto_preview and 'on' or 'off')))
end



function qfpreview.setup()
  vim.cmd([[augroup my-ft-qf-preview]])
  vim.cmd([[  autocmd!]])
  vim.cmd([[  autocmd FileType qf lua require'vimrc.qfpreview'.init(vim.fn.expand('<abuf>'))]])
  vim.cmd([[augroup END]])
end


return qfpreview
