if vim.api.nvim_call_function('FindPlugin', {'telescope.nvim'}) == 0 then do return end end

local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local utils = require('telescope.utils')
local make_entry = require('telescope.make_entry')
local path = require('telescope.path')
local previewers = require('telescope.previewers')

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

  pickers.new(opts, {
    prompt_title = 'mru',
    finder = finders.new_table {
      results = vim.api.nvim_eval('mr#mru#list()[:100]'),
      entry_maker = make_entry.gen_from_file()
    },
    -- sortings.fuzzy_with_index_bias で順序が変らずに検索できる
    -- sorter = sorters.fuzzy_with_index_bias(),
    sorter = conf.file_sorter({}),
    -- previewer = previewers.cat.new({}),
    previewer = false,
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
        -- a.nvim_command(format('tcd %s | edit .', val))
        a.nvim_command(format([[tcd %s | lua require'lir.float'.toggle()]], val))
      end

      map('i', '<CR>', tabedit)
      map('n', '<CR>', tabedit)

      -- true を返さないと、mapping が上書きされてしまう？
      return true
    end
  }):find()
end


--[[
  plug names
]]
M.plug_names = function(opts)
  pickers.new(opts, {
    prompt_title = 'plugin names',
    finder = finders.new_table(vim.tbl_keys(vim.g.plugs)),
    sorter = sorters.get_fzy_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      local function set_buf_line()
        local val = actions.get_selected_entry(prompt_bufnr).value
        actions.close(prompt_bufnr)
        local lines = {}
        if vim.bo.ft == 'lua' then
          table.insert(lines, format([[if vim.api.nvim_call_function('FindPlugin', {'%s'}) == 0 then do return end end]], val))
        else
          table.insert(lines, format([[UsePlugin '%s']], val))
          table.insert(lines, format([[scriptencoding utf-8]], val))
          vim.api.nvim_command([[normal! G]])
        end
        a.nvim_buf_set_lines(0, 1, 1, 1, lines)
        a.nvim_command([[:1delete _]])
      end

      local function ghq_get()
        local val = actions.get_selected_entry(prompt_bufnr).value
        local uri = vim.g.plugs[val].uri
        actions.close(prompt_bufnr)
        vim.cmd('botright 10new')
        vim.fn.termopen('ghq get ' .. uri, {
          on_exit = function (...)
            vim.defer_fn(function ()
              vim.cmd('quit')
            end, 1000)
          end
        })
      end

      map('i', '<CR>', set_buf_line)
      map('n', '<CR>', set_buf_line)

      map('n', 'P', ghq_get)

      -- true を返さないと、mapping が上書きされてしまう？
      return true
    end

  }):find()
end


M.openbrowser = function(opts)
  local results = vim.tbl_extend('keep', vim.g.openbrowser_search_engines or {}, {})
  pickers.new(opts, {
    prompt_title = 'Openbrowser',
    finder = finders.new_table {
      results = results,
      entry_maker = function(line)
        return {
          value = line,
          ordinal = line,
          display = pprint(line),
        }
      end
    },
  }):find()
end


return M
