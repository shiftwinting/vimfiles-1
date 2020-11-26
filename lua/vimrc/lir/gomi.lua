local gomi = {}
local buffer = require 'lir.buffer'


function gomi.rm()
  local dir, file = buffer.curdir(), buffer.current()
  vim.api.nvim_feedkeys(':!gomi ' .. vim.fn.shellescape(vim.fn.fnamemodify(dir .. file, ':p'), true), 'n', true)
end


return gomi
