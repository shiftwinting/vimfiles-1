if vim.api.nvim_call_function('FindPlugin', {'nvim-lspconfig'}) == 0 then do return end end

local neorocks = require'plenary.neorocks'


local on_attach = function(client)
  vimp.nnoremap({'buffer'}, '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
end

local lspconfig = require'lspconfig'

--[[
  lua

  cmd のデフォルト値はないため、:LspInstallInfo で確認する
]]

-- -- 参考になる
-- --    https://github.com/7415963987456321/dotfiles/blob/76685865c9ed6d7bb42dda926f21b8cc56201e1e/.config/nvim/lua/init.lua#L71
-- --    https://github.com/tami5/nvim/blob/664e43360cc47e0db8ef9b497ea0dd9381bfa8cb/fnl/module/nvim_lsp.fnl
-- lspconfig.sumneko_lua.setup{
--   on_attach = on_attach,
--   cmd = {
--     "/home/tamago324/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
--     "-E",
--     "/home/tamago324/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua"
--   },
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         enable = true,
--         globals = {'vim', 'describe', 'it', 'before_earch', 'after_each', 'vimp', '_vimp'},
--         disable = {"unused-local", "unused-vararg", "lowercase-global"}
--       },
--       workspace = {
--         -- library = {
--         --   [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--         --   [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
--         -- }
--         library = {
--           [vim.fn.expand("$VIMRUNTIME")] = true,
--           [vim.fn.stdpath("config")] = true,
--           -- ["/home/tamago324/.cache/nvim/plenary_hererocks/2.1.0-beta3"] = true,
--           -- neorocks のライブラリを追加
--           [neorocks._hererocks_install_location.filename .. '/share/lua/' .. neorocks._lua_version.lua] = true
--         }
--       }
--     }
--   }
-- }

-- see https://github.com/tjdevries/nlua.nvim/blob/master/lua/nlua/lsp/nvim.lua
require('nlua.lsp.nvim').setup(lspconfig, {
  on_attach = on_attach,
  disabled_diagnostics = {"unused-local", "unused-vararg", "lowercase-global"},
  globals = {'vimp', '_vimp'},
  library = {
    -- 再帰的に検索される
    [vim.fn.stdpath("config")] = true,
    [vim.fn.expand("$VIMRUNTIME")] = true,
    -- neorocks のライブラリを追加
    -- ["/home/tamago324/.cache/nvim/plenary_hererocks/2.1.0-beta3"] = true,
    [neorocks._hererocks_install_location.filename .. '/share/lua/' .. neorocks._lua_version.lua] = true
  }
})


--[[
  Vim
]]
lspconfig.vimls.setup{}
