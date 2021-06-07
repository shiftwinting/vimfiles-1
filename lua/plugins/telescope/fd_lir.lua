local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')

return function()
  local cwd
  local is_lir = vim.bo.filetype == 'lir'
  if is_lir then
    cwd = vim.fn.expand('%:p')
  else
    cwd = vim.fn.getcwd()
  end
  pickers.new({}, {
    prompt_title = 'lir fd',
    finder = finders.new_oneshot_job(
      {'fd', '--color=never', '--type', 'directory', '--exclude', 'jdt.ls-java-project'},
      {
        cwd = cwd
      }
    ),
    sorter = conf.generic_sorter({}),
    previewer = conf.file_previewer({
      -- depth = 1
    }),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        if is_lir then
          vim.cmd('e ' .. cwd .. '/' .. entry.value)
          return
        else
        end
        require'lir.float'.init(cwd .. '/' .. entry.value)
      end)

      return true
    end,
  }):find()
end
