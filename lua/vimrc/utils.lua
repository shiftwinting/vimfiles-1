local M = {}

-- lua/rc/ 以下を読み込む
M.load_rc_files = function()
  local files = vim.api.nvim_eval(
                    [[glob(g:lua_plugin_config_dir .. '/**/*.lua', '', v:true)]])
  for _, file in ipairs(files) do
    -- local name = file:sub(#vim.g.lua_plugin_config_dir+2, file:len()-4)
    -- require('rc/' .. name)
    dofile(file)
  end
end

return M
