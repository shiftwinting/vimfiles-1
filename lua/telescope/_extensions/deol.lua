local actions = require 'telescope.actions'
local action_set = require 'telescope.actions.set'
local action_state = require 'telescope.actions.state'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local finders = require 'telescope.finders'
local entry_display = require 'telescope.pickers.entry_display'

local a = vim.api

local gen_from_deol = function(opts)
  opts = opts or {}
  local new_text = '[New]'

  local displayer = entry_display.create {
    separator = ' ',
    items = {
      { width = 5 },
      { width = 3 },
      { width = 35 },
      { remaining = true },
    }
  }

  local make_display = function(entry)
    return displayer {
      -- deol がないなら、new
      (entry.is_deol and '') or new_text,
      entry.tabnr,
      entry.cwd,
      entry.command,
    }
  end

  local added_cwd_list = {}

  return function(entry)
    return {
      valid = true,
      value = entry.cwd,
      display = make_display,
      ordinal = entry.cwd,

      -- ここ、どーしよ
      command = entry.command,
      tabnr = entry.tabnr,
      cwd = entry.cwd,
      is_deol = entry.is_deol
    }
  end
end

local list = function(opts)
  opts = opts or {}

  local results = {}

  for tabnr = 1, vim.fn.tabpagenr('$') do
    local deol = vim.F.npcall(a.nvim_tabpage_get_var, tabnr, 'deol') or {}
    table.insert(results, {
      command = deol.command,
      tabnr = tabnr,
      cwd = (deol.cwd and deol.cwd) or vim.fn.getcwd(),
      is_deol = not vim.tbl_isempty(deol)
    })
  end

  pickers.new(opts, {
    prompt_title = 'Deol',
    finder = finders.new_table {
      results = results,
      entry_maker = gen_from_deol({results = results})
    },
    sorter = sorters.get_fzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        a.nvim_command(string.format('%dtabnext', entry.tabnr))
        vim.fn.DeolOpen()
      end)
      return true
    end
  }):find()
end



return require'telescope'.register_extension {
  exports = {
    list = list
  }
}
