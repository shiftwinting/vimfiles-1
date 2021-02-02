local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local utils = require('telescope.utils')
local make_entry = require('telescope.make_entry')
local path = require('telescope.path')
local previewers = require('telescope.previewers')

local my_make_entry = require('vimrc.telescope.make_entry')

local format = string.format

-- -- from make_entry.lua
-- local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
-- local transform_devicons
-- if has_devicons then
--   transform_devicons = function(filename, display, disable_devicons)
--     if disable_devicons or not filename then
--       return display
--     end
--
--     local icon_display = (devicons.get_icon(filename, string.match(filename, '%a+$')) or ' ') .. ' ' .. display
--
--     return icon_display
--   end
-- else
--   transform_devicons = function(_, display, _)
--     return display
--   end
-- end


local a = vim.api


local M = {}


--[[
 sorters
  * sorters.get_fuzzy_file
  * sorters.get_generic_fuzzy_sorter
  * sorters.fuzzy_with_index_bias
      順序を変えずにフィルタできる
  * sorters.get_fzy_sorter
  * sorters.get_levenshtein_sorter
]]

--[[
 make_entry
  * make_entry.gen_from_string
      ただの文字列
  * make_entry.gen_from_file
      ファイルっぽいものをパースする (アイコンも簡単につけられる
  * make_entry.gen_from_vimgrep
  * make_entry.gen_from_quickfix
  * make_entry.gen_from_buffer
  * make_entry.gen_from_treesitter
  * make_entry.gen_from_tagfile
  * make_entry.gen_from_packages
  * make_entry.gen_from_apropos
  * make_entry.gen_from_marks
]]



--[[
  ======================
   mru
  ======================
]]
M.mru = function(opts)
  opts = opts or {}
  opts.shorten_path = opts.shorten_path or true

  local results = vim.api.nvim_eval('mr#mru#list()[:999]')

  pickers.new(opts, {
    prompt_title = 'mru',
    finder = finders.new_table {
      results = results,
      -- entry_maker = make_entry.gen_from_file(),
      entry_maker = my_make_entry.gen_from_mru_better({results = results}),
    },
    -- sortings.fuzzy_with_index_bias で順序が変らずに検索できる
    -- sorter = sorters.fuzzy_with_index_bias(),
    sorter = conf.file_sorter({}),
    -- previewer = previewers.cat.new({}),
  }):find()
end


--[[
  mrr
]]
M.mrr = function(opts)
  opts = opts or {}

  pickers.new(opts, {
    prompt_title = 'Most Recent git Repository',
    finder = finders.new_table {
      results = vim.api.nvim_eval([[mr#mrr#list()]]),
      entry_maker = make_entry.gen_from_string(opts),
    },
    sorter = sorters.get_fuzzy_file(),

    attach_mappings = function(prompt_bufnr, map)
      local tabedit = function()
        local selection = actions.get_selected_entry(prompt_bufnr)
        actions.close(prompt_bufnr)
        local val = selection.value

        a.nvim_command('tabnew')
        a.nvim_command(format('tcd %s', val))
      end

      map('i', '<CR>', tabedit)
      map('n', '<CR>', tabedit)

      return true
    end,
  }):find()
end

return M
