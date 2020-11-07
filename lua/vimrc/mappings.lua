require('vimp')

-- Tips
--  * <C-r> と <C-r><C-r> をマッピングしたいときには、{'chord'} をつける
--  * silent や expr もoptionsに入れられる

-- リセット (これしないと、毎回 {'override'} って書かないといけなくなる)
vimp.unmap_all()

local nnoremap = vimp.nnoremap
local inoremap = vimp.inoremap
local xnoremap = vimp.xnoremap
local cnoremap = vimp.cnoremap
local tnoremap = vimp.tnoremap

nnoremap('ZZ', '<Nop>')
nnoremap('ZQ', '<Nop>')
nnoremap('<C-z>', '<Nop>')

-- insert mode で細かく undo できるようにする
inoremap('<CR>', '<C-g>u<CR>')
inoremap('<C-h>', '<C-g>u<CR>')
inoremap('<BS>' , '<C-g>u<BS>')
inoremap('<Del>', '<C-g>u<Del>')
inoremap('<C-w>', '<C-g>u<C-w>')
inoremap('<C-u>', '<C-g>u<C-u>')

-- like emacs
inoremap('<C-a>', '<C-o>_')
inoremap('<C-e>', '<END>')
inoremap('<C-f>', '<Right>')
inoremap('<C-b>', '<Left>')

-- 選択範囲で . を実行
xnoremap('.', [[:normal! .<CR>]])

-- シンボリックリンクの先に移動する
nnoremap({'silent'}, 'cd', [[:<C-u>exec 'lcd ' .. resolve(expand('%:p:h')) | pwd<CR>]])

nnoremap('<Space>vs.', function()
  if vim.bo.ft == 'lua' then
    vim.api.nvim_command[[luafile %]]
  else
    vim.api.nvim_command[[source %]]
  end
end)

-- update は変更があったときのみ保存するコマンド
nnoremap('<Space>w', [[:<C-u>update<CR>]])
nnoremap('<Space>W', [[:<C-u>update!<CR>]])
nnoremap('<Space>q', [[:<C-u>quit<CR>]])
nnoremap('<Space>Q', [[:<C-u>quit!<CR>]])


-- window 操作
nnoremap('sh', '<C-w>h')
nnoremap('sj', '<C-w>j')
nnoremap('sk', '<C-w>k')
nnoremap('sl', '<C-w>l')

nnoremap('sH', '<C-w>H')
nnoremap('sJ', '<C-w>J')
nnoremap('sK', '<C-w>K')
nnoremap('sL', '<C-w>L')

-- 分割ウィンドウを開く
nnoremap('sn', [[:<C-u>new<CR>]])

-- カレントウィンドウを新規タブで開く
nnoremap('st', '<C-w>T')

-- 新規タブ
nnoremap('so', ':<C-u>tabedit<CR>')

-- タブ間の移動
nnoremap('tg', '<Nop>')
nnoremap('gt', '<Nop>')
nnoremap('<C-l>', 'gt')
nnoremap('<C-h>', 'gT')

nnoremap('<Space>h', '^')
xnoremap('<Space>h', '^')
nnoremap('<Space>l', '$')
xnoremap('<Space>l', '$h')

-- 上下の空白に移動
-- https://twitter.com/Linda_pp/status/1108692192837533696
nnoremap('<C-j>', '}')
nnoremap('<C-k>', '{')
xnoremap('<C-j>', '}')
xnoremap('<C-k>', '{')

-- 見た目通りに移動
nnoremap('j', 'gj')
nnoremap('k', 'gk')

nnoremap('G', 'Gzz')


-- カーソル位置から行末までコピー
nnoremap('Y', 'y$')
-- 全行コピー
nnoremap('<Space>ay', [[:<C-u>%y<CR>]])
-- 最後にコピーしたテキストを貼り付ける
nnoremap('<Space>p', [["0p]])
xnoremap('<Space>p', [["0p]])


-- 直前に実行したマクロを実行する
nnoremap('Q', '@@')


-- terminal
tnoremap('<C-r>', '')
-- <C-]> で Job mode に移行
tnoremap('<Esc>', [[<C-\><C-n>]])


-- ハイライトの消去
nnoremap('<Esc><Esc>', [[:<C-u>noh<CR>]])


-- cmdline コマンドライン
cnoremap('<C-a>', '<Home>')
cnoremap('<C-f>', '<Right>')
cnoremap('<C-b>', '<Left>')
cnoremap('<C-d>', '<Del>')
cnoremap('<C-p>', '<Up>')
cnoremap('<C-n>', '<Down>')

-- / -> \/ にする
cnoremap({'expr'}, '/', [[getcmdtype() ==# '/' ? '\/' : '/']])

-- :h magic
nnoremap('/', [[/\v]])

nnoremap('<Space>/', [[/\V<C-r>+<CR>]])

-- 置換
nnoremap('<Space>s<Space>', [[:%s///g<Left><Left>]])


-- 選択文字列を指定の文字で置換
--  1. `"hy`で選択した範囲の文字列を`h`レジスタに格納
--  2. `:%s/\V<C-R>h//g`で`h`レジスタにある文字列を検索文字として挿入
--  3. `<left><left>`で置換後の文字列を入力しやすいようにしている
xnoremap({'chord'}, '<C-r>',      [["hy:%s/\v(<C-r>h)//g<Left><Left>]])
xnoremap({'chord'}, '<C-r><C-r>', [["hy:%s/\V(<C-r>h)//g<Left><Left>]])

-- diff
nnoremap('<Space>dt', [[:<C-u>windo diffthis<CR>]])
nnoremap('<Space>do', [[:<C-u>windo diffoff<CR>]])
nnoremap('<Space>dp', [[:diffput<CR>]])
xnoremap('<Space>dp', [[:diffput<CR>]])
nnoremap('<Space>dg', [[:diffget<CR>]])
xnoremap('<Space>dg', [[:diffget<CR>]])

-- toggle options
local map_option_toggle = function(key, opt)
  nnoremap({'silent'}, key, function()
    vim.api.nvim_command(string.format('setlocal %s!', opt))
    vim.api.nvim_command(string.format('echo "toggle %s"', opt))
  end)
end
map_option_toggle('<F2>', 'wrap')
map_option_toggle('<F3>', 'readonly')

-- help
xnoremap('<A-h>', [["hy:help <C-r>h<CR>]])
nnoremap('<A-h>', ':h ')
xnoremap('K', '')

-- クリップボードの貼り付け
inoremap('<C-r><C-r>', '<C-r>+')
cnoremap('<C-o>',      '<C-r>+')


-- tyru さんのマッピング
-- https://github.com/tyru/config/blob/master/home/volt/rc/vimrc-only/vimrc.vim#L618
inoremap('<C-l><C-l>', '<C-x><C-l>')
inoremap('<C-l><C-n>', '<C-x><C-n>')
inoremap('<C-l><C-k>', '<C-x><C-k>')
inoremap('<C-l><C-t>', '<C-x><C-t>')
inoremap('<C-l><C-i>', '<C-x><C-i>')
inoremap('<C-l><C-]>', '<C-x><C-]>')
inoremap('<C-l><C-f>', '<C-x><C-f>')
inoremap('<C-l><C-d>', '<C-x><C-d>')
inoremap('<C-l><C-v>', '<C-x><C-v>')
inoremap('<C-l><C-u>', '<C-x><C-u>')
inoremap('<C-l><C-o>', '<C-x><C-o>')
inoremap('<C-l><C-s>', '<C-x><C-s>')
inoremap('<C-l><C-p>', '<C-x><C-p>')


-- from https://github.com/wass88/dotfiles/blob/62ad8bca0a494c45294164fb9df27ee440b23e87/.vimrc#L876
xnoremap('<C-a>', '<C-a>gv')
xnoremap('<C-x>', '<C-x>gv')

nnoremap('<Space>i', 'i_<Esc>r')

nnoremap('<Space>v.', ':<C-u>call vimrc#drop_or_tabedit($MYVIMRC)<CR>')
nnoremap('<Space>v,', ':<C-u>call vimrc#drop_or_tabedit(g:plug_script)<CR>')

nnoremap('sf', function()
  local ft = vim.api.nvim_eval([[input('FileType: ', '', 'filetype')]])
  -- もし空ならそのバッファを使う
  if vim.fn.line('$') == 1 and vim.fn.getline(1) then
    vim.api.nvim_command('e ' .. os.tmpname())
  else
    vim.api.nvim_command('new ' .. os.tmpname())
  end
  vim.bo.filetype = ft
end)

