if vim.api.nvim_call_function('FindPlugin', {'pears.nvim'}) == 0 then do return end end

do return end

require'pears'.setup(function(conf)
  conf.pars('"', '"')
  conf.pars("'", "'")
  conf.pars('(', ')')
  conf.pars('{', '}')
  conf.pars('<', '>')
end)

-- <C-h> でも消したかった

-- local remove_outer_chars = {
--   '<C-h>',
--   '<C-w>',
-- }
--
-- _G.my_pears_on_bufenter = function(bufnr)
--   for _, char in ipairs(remove_outer_chars) do
--     vim.api.nvim_buf_set_keymap(
--       bufnr,
--       "i",
--       char,
--       string.format([[<Cmd>lua require("pears").handle_backspace(%d)<CR>]], bufnr),
--       {silent = true})
--   end
-- end
--
-- do
--   vim.cmd [[augroup MyPears]]
--   vim.cmd [[   autocmd!]]
--   vim.cmd [[  autocmd BufEnter * lua my_pears_on_bufenter(vim.fn.expand('<abuf>'))]]
--   vim.cmd [[augroup END]]
-- end
