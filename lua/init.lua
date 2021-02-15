require'nvim_mappings'

vim.cmd [[packadd packer.nvim]]

function load_rc_files()
  local files = vim.api.nvim_eval([[sort(glob(g:lua_plugin_config_dir .. '/**/*.lua', '', v:true))]])
  for _, file in ipairs(files) do
    -- local name = file:sub(#vim.g.lua_plugin_config_dir+2, file:len()-4)
    -- require('rc/' .. name)
    dofile(file)
  end
end
load_rc_files()

function _G.pprint(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end
