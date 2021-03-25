local M = {}

M.format = function(start_row, end_row)
  start_row = start_row or 0
  end_row = end_row or vim.fn.line("$")
  vim.lsp.buf.range_formatting({},{start_row, 0},{end_row , 0 })
end

return M
