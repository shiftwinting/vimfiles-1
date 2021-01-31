local actions = require 'telescope.actions'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local finders = require 'telescope.finders'

-----------------------------
-- Private
-----------------------------



-----------------------------
-- Export
-----------------------------
local list = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = 'plug names',
    finder = finders.new_table {
      results = vim.tbl_keys(vim.g.plugs),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    },
    -- previewer = nil,
    sorter = sorters.get_fzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.goto_file_selection_edit:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.fn.setreg(vim.v.register, entry.value)
        print('Yank: ' .. entry.value)
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

