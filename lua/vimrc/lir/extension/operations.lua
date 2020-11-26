local operations = {}
local buffer = require 'lir.buffer'


operations.gomi_rm = function ()
  vim.api.nvim_feedkeys(':!gomi ' .. vim.fn.shellescape(buffer.current(), true), 'n', true)
end


operations.gomi_rm_rf = function ()
  vim.api.nvim_feedkeys(':!gomi ' .. vim.fn.shellescape(buffer.current(), true), 'n', true)
end

return operations
