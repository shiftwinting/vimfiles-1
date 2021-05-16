if vim.api.nvim_call_function('FindPlugin', {'NoCLC.nvim'}) == 0 then do return end end


local no_clc = require("no-clc")

no_clc.setup({
  load_at_startup = true,
  cursorline = true,
  cursorcolumn = false
})
