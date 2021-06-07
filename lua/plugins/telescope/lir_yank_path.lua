local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local lir = require'lir'

local find_git_ancestor = require'lspconfig.util'.find_git_ancestor


local fnamemods = {
  ':p:t',
  ':p',
  ':p:h',
  ':p:h:h',

  ---@param path string
  ---@return string
  function(path)
    local root = find_git_ancestor(path)
    if root == nil then
      return nil
    end

    return path:sub(#root+2)
  end

}


return function()
  local ctx = lir.get_context()
  local cur_path = ctx:current().fullpath
  local results = {}
  for _, mod in ipairs(fnamemods) do
    if type(mod) == 'string' then
      table.insert(results, vim.fn.fnamemodify(cur_path, mod))

    elseif type(mod) == 'function' then
      local res = mod(cur_path)
      if res then
        table.insert(results, res)
      end
    end

  end

  pickers.new({}, {
    prompt_title = 'Paths',
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
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)

        vim.fn.setreg(vim.v.register, entry.value)
      end)

      return true
    end
  }):find()
end
