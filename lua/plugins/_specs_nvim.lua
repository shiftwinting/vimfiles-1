if vim.api.nvim_call_function('FindPlugin', {'specs.nvim'}) == 0 then do return end end

require('specs').setup{
  show_jumps  = true,
  min_jump = 30,
  popup = {
    delay_ms = 0,
    inc_ms = 10,
    blend = 30,
    width = 30,
    fader = require('specs').linear_fader,
    resizer = require('specs').slide_resizer
  }
}
