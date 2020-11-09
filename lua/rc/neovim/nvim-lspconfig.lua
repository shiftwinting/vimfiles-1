local ok, nvim_lsp = pcall(require, 'nvim_lsp')
if not ok then do return end end

local on_attach = function(client)
  require "diagnostic".on_attach(client)
end

--[[
  lua

  cmd のデフォルト値はないため、:LspInstallInfo で確認する
]]

-- 参考になる https://github.com/7415963987456321/dotfiles/blob/76685865c9ed6d7bb42dda926f21b8cc56201e1e/.config/nvim/lua/init.lua#L71
nvim_lsp.sumneko_lua.setup{
  on_attach = on_attach,
  cmd = {
    "/home/tamago324/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
    "-E",
    "/home/tamago324/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua"
  },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = {
        enable = true,
        globals = {'vim', 'describe', 'it', 'before_earch', 'after_each', 'vimp'}
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        }
      }
    }
  }
}


--[[
  Vim
]]
nvim_lsp.vimls.setup{on_attach = on_attach}
