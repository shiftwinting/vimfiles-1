local a = vim.api
local hover = require'lspsaga.hover'

local M = {}



M.render_or_into_hover_doc = function()
  if hover.has_saga_hover() then
    a.nvim_command [[noautocmd wincmd p]]
  else
    hover.render_hover_doc()
  end
end



return M
