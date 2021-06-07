local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')


-- @Summary sonictemplate
-- @Description
return function()
  local opts = {}
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
        local selection = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.fn['sonictemplate#apply'](selection.value, 'n')
      end)

      return true
    end,
  }):find()
end

