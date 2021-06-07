local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')

local ext_utils = require'plugins/telescope/utils'

-- deol が表示されているか
local is_show_deol = function()
  if vim.fn.exists('t:deol') ~= 1 then
    return false
  end

  return not vim.tbl_isempty(vim.fn.win_findbuf(vim.t.deol.bufnr))
end

local reverse = function(t)
  local res = {}
  for i = #t, 1, -1 do
    table.insert(res, t[i])
  end
  return res
end


return function()
  local opts = {}
  -- local lnum = vim.fn.line('.')
  -- local text = vim.api.nvim_buf_get_lines(0, lnum-1, lnum, false)[1]

  local results = reverse(vim.fn['deol#_get_histories']())
  pickers.new(opts, {
    prompt_title = 'Deol',
    -- 最初から、入力するには？？
    -- default_text = text,
    finder = finders.new_table {
      results = results,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)

        -- もし、開いてなかったら、開く
        if not is_show_deol() then
          vim.fn.DeolOpen()
        end

        vim.fn['deol#send'](entry.value)
      end)

      local edit = function()
        local selection = actions.get_selected_entry()
        actions.close(prompt_bufnr)

        -- edit が開いていなければ、開く
        if not is_show_deol() then
          vim.fn.DeolOpen()
        end

        if vim.api.nvim_get_current_buf() ~= vim.t.deol.edit_bufnr then
          -- edit を開く
          vim.cmd [[DeolEdit]]
        end

        vim.api.nvim_buf_set_lines(0, vim.fn.line('.')-1, vim.fn.line('.')-1, false, {selection.value})

        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("k", true, false, true), 'n', true)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("A", true, false, true), 'n', true)
      end

      map('i', '<C-e>', edit)
      map('n', '<C-e>', edit)
      map('i', '<A-s>', actions.close)
      map('n', '<A-s>', actions.close)

      return true
    end
  }):find()
end

