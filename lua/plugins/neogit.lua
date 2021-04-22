if vim.api.nvim_call_function('FindPlugin', {'neogit'}) == 0 then do return end end

-- require'neogit'.setup()
--
--
-- local map = function(mode, lhs, rhs, opts)
--   vim.api.nvim_set_keymap(mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, { silent = true, noremap = true }))
-- end
--
-- map('n', '<Space>gs', '<Cmd>Neogit<CR>')
