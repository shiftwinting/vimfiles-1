--[[
  vim-molder を Lua で書く
]]
local uv = vim.loop
local api = vim.api

local devicons = require'vimrc.lir.devicons'
local history = require'vimrc.lir.history'

local lir = {}

local ml = require'ml'

local get_value = function(lnum)
  return vim.b.lir_files[lnum].value
end


function lir.current ()
  return get_value(vim.fn.line('.'))
end


function lir.curdir()
  return vim.b.lir_dir
end


function lir.indexof(value)
  return ml.indexof(vim.b.lir_files, value, function (file, v)
    return file.value == v
  end)
end


function lir.set_cursor(lnum, col)
  -- なぜか、defer_fn が必要
  vim.defer_fn(function ()
    vim.fn.cursor(lnum, 1)
  end, 3)
end


function lir.error(msg)
  vim.cmd([[redraw]])
  vim.cmd([[echohl Error]])
  vim.cmd(string.format([[echomsg '%s']],msg))
  vim.cmd([[echohl None]])
end


local readdir = function(path)
  local files = {}
  local handle = uv.fs_scandir(path)
  if handle == nil then
    return {}
  end

  while true do
    local name, typ = uv.fs_scandir_next(handle)
    if name == nil then
      break
    end
    local is_dir = false
    if typ == 'directory' or typ == 'link' or typ == 'linked' then
      is_dir = true
    end

    local icon, highlight_name = devicons.get_devicons(name, is_dir)

    table.insert(files, {
      value = name,
      display = ' ' .. icon .. ' ' .. name,
      devicons = {
        icon = icon,
        highlight_name = highlight_name,
      },
      is_dir = is_dir,
    })
  end
  return files
end


local sort = function(lhs, rhs)
  local l_val, r_val = lhs.value, rhs.value
  if lhs.is_dir and not rhs.is_dir then
    -- lhs がディレクトリなら そのまま
    return true
  elseif not lhs.is_dir and rhs.is_dir then
    -- rhs がディレクトリなら入れ替える
    return false
  end

  -- 単純に比較
  return lhs.value < rhs.value
end



lir.init = function ()
  local path = vim.fn.resolve(vim.fn.expand('%:p'))

  local stat = uv.fs_stat(path)
  if path == '' or not stat or stat.type ~= 'directory' then
    return
  end

  -- 代替バッファを保持
  local alt_file_path = vim.fn.expand('#')
  if alt_file_path ~= '' then
    vim.w.alf_file = alt_file_path
  end

  local dir = path
  if not vim.endswith(path, '/') then
    dir = path .. '/'
  end

  vim.b.lir_dir = dir

  -- nvim_buf_set_lines() するため
  vim.bo.modifiable = true

  vim.bo.filetype  = 'lir'
  vim.bo.buftype   = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.buflisted = false
  vim.bo.swapfile  = false

  vim.cmd([[setlocal nowrap]])

  local files = readdir(path)
  table.sort(files, sort)
  if not vim.b.lir_show_hidden then
    files = vim.tbl_filter(function (val)
      return string.match(val.value, '^[^.]') ~= nil
    end, files)
  end
  api.nvim_buf_set_lines(0, 0, -1, true, vim.tbl_map(function(item)
    return item.display
  end, files))

  vim.b.lir_files = files
  vim.bo.modified = false
  vim.bo.modifiable = false

  local lnum = 1
  if history.exists(dir) then
    lnum = lir.indexof(history.get(dir))
  end

  local alt_dir = vim.fn.fnamemodify(vim.fn.expand('#'), ':p:h')
  local alt_file = vim.fn.fnamemodify(vim.fn.expand('#'), ':p:t')

  if alt_file and string.gsub(dir, '/$', '') == alt_dir then
    lnum = lir.indexof(alt_file)
  end

  lir.set_cursor(lnum, 1)
  devicons.update_highlights(files)

  vim.cmd([[setlocal cursorline]])
end


return lir
