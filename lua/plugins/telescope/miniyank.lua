local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')

local make_entry = function()
  return function(entry)
    local content = table.concat(entry[1], [[\n]])
    return {
      valid = true,
      value = entry[1],
      ordinal = content,
      display = content,
    }
  end
end

return function()
  pickers.new({}, {
    prompt_title = 'miniyank',
    finder = finders.new_table {
      results = vim.fn['miniyank#read'](),
      entry_maker = make_entry(),
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)

      local put = function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.fn['miniyank#drop'](entry.value, 'p')
      end

      -- local Put = function()
      --   local entry = actions.get_selected_entry()
      --   actions.close()
      --   vim.fn['miniyank#drop'](entry.value, 'P')
      -- end

      local yank = function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.fn.setreg(vim.v.register, entry.value)
      end

      actions.select_default:replace(yank)

      map('n', '<C-l>', put)
      map('i', '<C-l>', put)

      return true
    end,
  }):find()
end
