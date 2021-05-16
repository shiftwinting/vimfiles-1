if vim.api.nvim_call_function('FindPlugin', {'nvim-bqf'}) == 0 then do return end end

require'bqf'.setup{
  preview = {
    border_chars = {'│', '│', '─', '─', '+', '+', '+', '+', '█'},
    func_map = {
      ['t'] = '',
      ['ctrl-t'] = 'tab'
    },
    win_height = 30
  }
}
