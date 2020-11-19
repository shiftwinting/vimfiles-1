local M = {}


local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
local api = vim.api

local icon = devicons.get_icon('default_icon')
local ICON_WIDTH = vim.fn.strlen(icon)

local get_ns = function ()
  return api.nvim_create_namespace('lir')
end

local icon_width = devicons.get_icon('default_icon')


-- from telescope.nvim
--[[

  params:
    filename: ファイル名
    is_dir:   ディレクトリか？
]]
if has_devicons then
  M.get_devicons = function(filename, is_dir)
    if is_dir then
      filename = 'folder_icon'
    end
    return devicons.get_icon(filename, string.match(filename, '%a+$'))
  end
else
  M.get_devicons = function(filename, is_dir)
    return ''
  end
end


M.update_highlights = function (files)
  local ns = get_ns()
  local col_start, col_end = #' ', ICON_WIDTH + #' '

  api.nvim_buf_clear_namespace(0, ns, 0, -1)
  for i, file in ipairs(files) do
    api.nvim_buf_add_highlight(0, ns, file.devicons.highlight_name, i-1, col_start, col_end)
  end
end


return M
