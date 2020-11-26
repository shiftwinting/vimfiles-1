local M = {}

-- lua/rc/ 以下を読み込む
M.load_rc_files = function()
  local files = vim.api.nvim_eval([[glob(g:lua_plugin_config_dir .. '/**/*.lua', '', v:true)]])
  for _, file in ipairs(files) do
    local name = file:sub(#vim.g.lua_plugin_config_dir+2, file:len()-4)
    require('rc/' .. name)
  end
end


--[[
  command! のように動作させる
  _vimp._command_maps_by_id のなかで管理されているため、そこから消す
]]
M.map_command = function(name, handler)
  for _, id in ipairs(vim.tbl_keys(_vimp._command_maps_by_id)) do
    local map = _vimp._command_maps_by_id[id]
    if map.name == name and (vim.fn.exists(':' .. name) == 2) then
      map:remove_from_vim()
      _vimp._command_maps_by_id[id] = nil
    end
  end

  vimp.map_command(name, handler)
end


return M
