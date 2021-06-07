if vim.api.nvim_call_function('FindPlugin', {'null-ls.nvim'}) == 0 then do return end end

--[[

# stylua
cargo install stylua

]]

local null_ls = require'null-ls'

-- setup に一気に渡すため、
local sources = {
  -- これ、すげー
  null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.formatting.stylua,
}


local M = {}

M.setup = function(on_attach)
  null_ls.setup {
    on_attach = on_attach,
    sources = sources
  }
end

return M
