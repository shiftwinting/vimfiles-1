if vim.api.nvim_call_function('FindPlugin', {'nvim-tree.lua'}) == 0 then do return end end

local g = vim.g
-- vimp.nnoremap({'override'}, '<C-e>', ':LuaTreeToggle<CR>')

g.lua_tree_show_icons = {
  git = 0,
  folders = 1,
  icons = 1,
}

vim.g.lua_tree_icons = {
  default = '',
  symlink = '',
  folder = {
    default = '',
    open = '',
  }
}

-- ファイルの位置にカーソルを移動する
g.lua_tree_follow = 1

-- indent の可視化
g.lua_tree_indent_markers = 1

g.lua_tree_disable_keybindings = 0

-- g.lua_tree_bindings = {
--   edit        = { 'l', '<CR>', 'o' },
--   edit_vsplit = { '<C-v>' },
--   edit_split  = { '<C-s>' },
--   edit_tab    = { '<C-t>' },
--   cd          = { '@' },
--   preview     = { 'go' },
--   create      = { 'N' },
--   remove      = { 'D' },
--   rename      = { 'R' },
--   cur         = { 'M' },
--   copy        = { 'C' },
--   paste       = { 'P' },
-- }
