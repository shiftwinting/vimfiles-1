local ok, _ = pcall(require, 'telescope')
if not ok then do return end end

local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local utils = require('telescope.utils')
local make_entry = require('telescope.make_entry')

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

  pickers.new(opts, {
    prompt_title = 'mru',
    finder = finders.new_table {
      results = vim.api.nvim_eval([[mr#mru#list()]]),
      entry_maker = make_entry.gen_from_file(opts),
    },
    -- sortings.fuzzy_with_index_bias で順序が変らずに検索できる
    sorter = sorters.fuzzy_with_index_bias(),
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
      make_entry = make_entry.gen_from_string(opts),
    },
    sorter = sorters.get_fuzzy_file(),

    attach_mappings = function(prompt_bufnr, map)
      local tabedit = function()
        local selection = actions.get_selected_entry(prompt_bufnr)
        actions.close(prompt_bufnr)
        local val = selection.value

        a.nvim_command('tabnew')
        a.nvim_command(string.format('tcd %s', val))
      end

      map('i', '<CR>', tabedit)
      map('n', '<CR>', tabedit)

      return true
    end,
  }):find()
end

--[[
  filetypes
]]
M.filetypes = function(opts)
  opts = opts or {}

  local files = vim.api.nvim_eval([[split(globpath(&rtp, 'syntax/*.vim'), '\n')]])
  local filetypes = vim.tbl_map(function(item)
    return vim.fn.fnamemodify(item, ':t:r')
  end, files)

  pickers.new(opts, {
    prompt_title = 'filetype',
    finder = finders.new_table {
      results = filetypes,
      entry_maker = make_entry.gen_from_string(opts),
    },
    sorter = sorters.get_levenshtein_sorter(),
  }):find()
end


--[[
  ghq
    from telescope/make_entry.lua の make_entry.gen_from_buffer() からもらった
]]
M.ghq = function(opts)
  local ghq_root = vim.env.GHQ_ROOT
  pickers.new(opts, {
    prompt_title = 'ghq',
    finder = finders.new_oneshot_job(
      {'ghq', 'list', '--full-path'}, {
        entry_maker = function(line)
          return {
            value = line,
            ordinal = line,
            display = string.sub(line, #ghq_root + #'/github.com/' + 1),
          }
        end
      }
    ),
    sorter = sorters.get_fzy_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      local tabedit = function()
        local val = actions.get_selected_entry(prompt_bufnr).value
        actions.close(prompt_bufnr)
        a.nvim_command('tabnew')
        a.nvim_command(string.format('tcd %s', val))
      end

      map('i', '<CR>', tabedit)
      map('n', '<CR>', tabedit)

      -- true を返さないと、mapping が上書きされてしまう？
      return true
    end
  }):find()
end


return M
