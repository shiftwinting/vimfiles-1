local actions = require 'telescope.actions'
local actions_state = require 'telescope.actions.state'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local finders = require 'telescope.finders'
local previewers = require 'telescope.previewers'

local conf = require'telescope.config'.values

local a = vim.api

local list = function(opts)
  opts = opts or {}

  local results = {}

  pickers.new(opts, {
    prompt_title = 'Template',
    finder = finders.new_table {
      results = vim.fn['sonictemplate#complete']('', '', ''),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(
      function()
        local selection = actions_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.fn['sonictemplate#apply'](selection.value, 'n')
      end)

      return true
    end,
  }):find()
end



return require'telescope'.register_extension {
  exports = {
    templates = list
  }
}
