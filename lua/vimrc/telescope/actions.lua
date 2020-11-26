local actions = require('telescope.actions')

local M = {}

local a = vim.api

-- function M.goto_file_selection_drop(prompt_bufnr)
--   local selection = actions.get_selected_entry(prompt_bufnr)
--   actions.close(prompt_bufnr)
--   local val = selection.value
--   a.nvim_command(string.format('drop %s', val))
-- end

return M
