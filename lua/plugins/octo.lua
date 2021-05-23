if vim.api.nvim_call_function('FindPlugin', {'octo.nvim'}) == 0 then do return end end

require'octo'.setup{}
