if vim.api.nvim_call_function('FindPlugin', {'LuaSnip'}) == 0 then do return end end

vim.cmd([[imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>']])
vim.cmd([[smap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>']])
vim.cmd([[imap <silent><expr> <C-j> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-j>']])
vim.cmd([[smap <silent><expr> <C-j> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-j>']])

vim.cmd([[imap <silent><expr> <C-q> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-q>']])
vim.cmd([[smap <silent><expr> <C-q> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-q>']])

local files = vim.api.nvim_eval([[sort(glob(g:lua_plugin_config_dir .. '/luasnip/*.lua', '', v:true))]])
for _, file in ipairs(files) do
  dofile(file)
end

function _G.LuaSnipOpen()
  local ft = vim.bo.filetype
  local file = string.format('%s/luasnip/%s.lua', vim.g.lua_plugin_config_dir, ft)
  vim.cmd('split ' .. file)
end

vim.cmd [[command! LuaSnipOpen lua LuaSnipOpen()]]




  -- -- s() の第2引数は必ず i(0) が入っていないといけない
  -- s({trig = 'sample'}, {
  --   i(0)
  -- }),
  --
  -- -- t : text mode
  -- s({trig = 'trigger'}, {
  --   -- そのまま挿入される
  --   t({"hello !"}),
  --   i(0)
  -- }),
  --
  -- s({trig = 'trigger2'}, {
  --   -- 複数行もできる
  --   t({"hello !", "world"}),
  --   i(0)
  -- }),
  --
  -- -- i : insert mode
  -- -- i(num) でジャンプできる
  -- s({trig = 'itrigger'}, {
  --   t({"Hello ->"}), i(2),
  --   t({"", "World ->"}), i(1),
  --   t({"", "Dayo! ->"}), i(0)
  -- }),
  --
  -- -- デフォルトのテキストを選択した状態で展開
  -- -- i の第2引数にリストを渡す
  -- s({trig = 'isel'}, {
  --   i(1, {"Hello!"}),
  --   t({''}),
  --   i(2, {"world!"}), i(0),
  -- }),
  --
  -- -- 複数行もできる
  -- s({trig = 'isel2'}, {
  --   i(1, {"hoge", "fuga"}), i(0),
  -- }),
  --
  -- s({trig = 'ftrigger'}, {
  --   i(1),
  --   f(
  --     function(args, user_arg_1)
  --       return {
  --         args[1][1] .. user_arg_1
  --       }
  --     end,
  --     {1}
  --   ),
  --   i(0)
  -- }),
  --
  -- s({trig = 'b(%d)', regTrig = true, wordTrig = true}, {
  --   f(function (args)
  --     return {
  --       "Captured Text: " .. args[1].captures[1] .. '.'
  --     }
  --   end, {}),
  --   i(0)
  -- }),
  --
  -- s({trig = "ctrig"}, {
  --   c(1, {
  --     -- ただのテキスト
  --     t({"Ugh boring, a text node"}),
  --     -- プレースホルダーを持ったテキスト
  --     i(nil, {"At least I can edit something now..."}),
  --     f(function(args) return {"Still only counts as text!!"} end, {})
  --   }),
  --   i(0)
  -- }),
  --
  -- s({trig = 'strig'}, {
  --   sn(1, {
  --     t({"basically just text "}),
  --     i(1, {"And an insertNode."})
  --   }),
  --   i(0)
  -- })
