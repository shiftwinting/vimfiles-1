local actions = require 'telescope.actions'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local finders = require 'telescope.finders'

local Path = require'plenary.path'

local a = vim.api

local list = function(opts)
  opts = opts or {}

  local results = vim.tbl_map(function(v)
    return Path:new(v):normalize()
  end, vim.api.nvim_eval('mr#mrr#list()[:3000]'))

  pickers.new(opts, {
    prompt_title = 'MRR',
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
      actions.select_default:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('edit ' .. entry.value)
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
