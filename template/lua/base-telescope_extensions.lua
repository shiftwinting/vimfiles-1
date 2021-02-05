local actions = require 'telescope.actions'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local finders = require 'telescope.finders'

local a = vim.api

-----------------------------
-- Private
-----------------------------



-----------------------------
-- Export
-----------------------------
local list = function(opts)
  opts = opts or {}

  local results = {}

  pickers.new(opts, {
    prompt_title = 'TODO: Title',
    finder = finders.new_table {
    results = results,
    entry_maker = function(entry)
      return {
        value = entry,
        display = entry,
        ordinal = entry,
      }
    end
    },
    sorter = opts.sorter or sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.goto_file_selection_edit:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)

        print(entry.value)
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

