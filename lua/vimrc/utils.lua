local utils = {}

-- lua/rc/ 以下を読み込む
function utils.load_rc_files()
  local files = vim.api.nvim_eval(
                    [[glob(g:lua_plugin_config_dir .. '/**/*.lua', '', v:true)]])
  for _, file in ipairs(files) do
    -- local name = file:sub(#vim.g.lua_plugin_config_dir+2, file:len()-4)
    -- require('rc/' .. name)
    dofile(file)
  end
end


--- create_augroups
-- Source: https://teukka.tech/luanvim.html
function utils.create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup ' .. group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

return utils
