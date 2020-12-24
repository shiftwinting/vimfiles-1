local devicons = require'nvim-web-devicons'
local entry_display = require('telescope.pickers.entry_display')
local path = require('telescope.path')
local utils = require('telescope.utils')

local filter = vim.tbl_filter
local map = vim.tbl_map

local make_entry = {}


function make_entry.gen_from_openbrowser(opts)
  opts = opts or {}

  return function(entry)
    return {
      value = entry.url,
      ordinal = entry.name .. ' ' .. entry.url,
      display = entry.name .. ' ' .. entry.url,
    }
  end
end


local extend = function(a, b)
  for i = 1, #b do
    table.insert(a, b[i])
  end
  return a
end


function make_entry.gen_from_buffer_like_leaderf(opts)
  opts = opts or {}
  local default_icons, _ = devicons.get_icon('file', '', {default = true})

  local bufnrs = filter(function(b)
    return 1 == vim.fn.buflisted(b)
  end, vim.api.nvim_list_bufs())

  local max_bufnr_len = math.max(
    unpack(
      map(function(bufnr)
        return vim.fn.strdisplaywidth(bufnr)
      end, bufnrs)
    )
  )

  local max_bufname = math.max(
    unpack(
      map(function(bufnr)
        return vim.fn.strdisplaywidth(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':p:t'))
      end, bufnrs)
    )
  )

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = max_bufnr_len },
      { width = 4 },
      { width = vim.fn.strwidth(default_icons) },
      { width = max_bufname },
      { remaining = true },
    },
  }

  -- local cwd = vim.fn.expand(opts.cwd or vim.fn.getcwd())

  -- リストの場合、ハイライトする
  local make_display = function(entry)
    return displayer {
      {entry.bufnr, "TelescopeResultsNumber"},
      {entry.indicator, "TelescopeResultsComment"},
      {entry.devicons, entry.devicons_highlight},
      entry.file_name,
      {entry.dir_name, "Comment"}
      }
  end

  return function(entry)
    local bufname = entry.info.name ~= "" and entry.info.name or '[No Name]'
    -- bufname = path.normalize(bufname, cwd)

    local hidden = entry.info.hidden == 1 and 'h' or 'a'
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, 'readonly') and '=' or ' '
    local changed = entry.info.changed == 1 and '+' or ' '
    local indicator = entry.flag .. hidden .. readonly .. changed

    local dir_name = vim.fn.fnamemodify(bufname, ':p:h')
    local file_name = vim.fn.fnamemodify(bufname, ':p:t')

    local icons, highlight = devicons.get_icon(bufname, string.match(bufname, '%a+$'), { default = true })

    return {
      valid = true,

      value = bufname,
      ordinal = entry.bufnr .. " : " .. bufname,
      display = make_display,

      bufnr = entry.bufnr,

      lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
      indicator = indicator,
      devicons = icons,
      devicons_highlight = highlight,

      file_name = file_name,
      dir_name = dir_name,
    }
  end
end



return make_entry
