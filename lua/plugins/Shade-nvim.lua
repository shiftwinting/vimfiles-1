if vim.api.nvim_call_function('FindPlugin', {'Shade.nvim'}) == 0 then do return end end

-- require'shade'.setup {
--   overlay_opacity = 75,
--   opacity_step = 1,
--   keys = {
--     brightness_up = '<C-up>',
--     brightness_down = '<C-down>',
--     toggle = '<Space>ss',
--   },
--   -- debug = true,
-- }
