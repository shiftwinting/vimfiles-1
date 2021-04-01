if vim.api.nvim_call_function('FindPlugin', {'nvim-biscuits'}) == 0 then do return end end

require('nvim-biscuits').setup ({
  default_config = {
    min_distance = 10,
    max_length = 80,
    prefix_string = "   ▋ "
  }
})
