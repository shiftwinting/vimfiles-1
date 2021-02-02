-- ハイライトを少し遅らせる (hjkl の移動がスムーズになる？)
vim.g.matchup_matchparen_deferred = 1

-- 指定のモードではハイライトさせない
vim.g.matchup_matchparen_nomode = 'i'

-- popup で表示する
vim.g.matchup_matchparen_offscreen = {method = 'popup'}

-- retrun にマッチしないようにする
vim.g.matchup_delim_noskips = 1
