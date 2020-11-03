--[[
  options
--]]

vim.o.encoding = 'utf-8'

-- 改行コードの設定
vim.o.fileformats = 'unix,dos,mac'

-- https://github.com/vim-jp/issues/issues/1186
vim.o.fileencodings = 'utf-8,iso-2022-jp,euc-jp,cp932'


-- vim.o  グローバル
-- vim.bo  バッファローカル

-- 改行時に前の行のインデントを維持する
vim.o.autoindent = true

-- インデント幅を必ず shiftwidth の倍数にする
vim.o.shiftround = true

-- 検索文字列をハイライトする
vim.o.hlsearch = true

-- 文字を入力されるたびに検索を実行する
vim.o.incsearch = true

-- 5行開けてスクロールできるようにする
vim.o.scrolloff = 5

-- ビープ音ではなく、画面フラッシュ
vim.o.visualbell = true

-- フラッシュもしない
-- vim.o.t_vb = nil
vim.api.nvim_set_option('t_vb', '')

-- 検索、置換、コマンド... の履歴を300にする(default: 50)
vim.o.history = 3000

-- 常にタブを表示
vim.o.showtabline = 2

-- 検索のとき、大文字小文字を区別しない
vim.o.ignorecase = true

-- 大文字が入らない限り、大文字小文字は区別しない
vim.o.smartcase = true

-- 2 で慣れてしまったため
vim.o.cmdheight = 2

-- 記号を正しく表示
vim.o.ambiwidth = 'double'
-- vim.o.ambiwidth = 'single'

-- マッピングの待機時間
vim.o.timeoutlen = 480

-- 常に表示 (幅を2にする)
vim.o.signcolumn  = 'yes:2'
vim.wo.signcolumn = 'yes:2'

-- <C-v>で選択しているときに、上下移動しても、行頭に行かないようにする
vim.o.startofline = false

-- Vim の外でファイルを変更した時、自動で読み込む
vim.o.autoread = true

-- 縦分割した時、カレントウィンドウの右に作成する
vim.o.splitright = true

-- 横分割した時、カレントウィンドウの上に作成する
vim.o.splitbelow = false

-- menuone:  候補が1つでも表示
-- popup:    info を popup で表示
-- noselect: 自動で候補を表示しない
-- noinsert: 自動で候補を挿入しない
vim.o.completeopt = 'menuone,noselect,noinsert'

-- 補完ウィンドウの高さ
vim.o.pumheight = 15

vim.o.expandtab = true
vim.o.tabstop     = 4
vim.o.shiftwidth  = 4
vim.o.softtabstop = 4

--[[
  syntax enable と syntax on の違いを理解する (:help :syntax-on)
    on: 既存の色の設定を上書きする
    enable: まだ、設定されていない色の設定のみ適用する
--]]
-- :syntax enable
vim.api.nvim_command('syntax enable')


--[[
  ファイルタイプの自動検出
    plugin ファイルタイプ別プラグインを有効化
    indent ファイルタイプごとのインデントを有効化

  see :filetype-overview
--]]
-- :filetype plugin indent on
vim.api.nvim_command('filetype plugin indent on')

--[[
  <BS>, <Del>, <CTRL-W>, <CTRL-U> で削除できるものを設定
    indent  : 行頭の空白
    eol     : 改行(行の連結が可能)
    start   : 挿入モード開始位置より手前の文字
--]]
vim.o.backspace = 'indent,eol,start'

-- clipboard [https://pocke.hatenablog.com/entry/2014/10/26/145646]
-- :set clipboard&
vim.api.nvim_command('set clipboard&')
vim.api.nvim_command('set clipboard^=unnamedplus')

--[[
  余白文字を指定
    vert: 垂直分割の区切り文字
    fold: 折畳の余白
    diff: diffの余白
--]]
vim.o.fillchars = 'vert: ,fold: ,diff: '

-- バックアップファイル(~)を作成しない(defaut: off)
vim.o.backup = false
vim.o.writebackup = false

-- スワップファイル(.swp)を作成しない
vim.o.swapfile = false
vim.o.updatecount = 0

-- cmdline の補完設定
-- ステータスラインに候補を表示
vim.o.wildmenu = true

-- Tab 1回目:  共通部分まで補完し、候補リストを表示
-- Tab 2回目~: 候補を完全に補完
vim.o.wildmode = 'longest:full,list:full'

-- cmdline から cmdline-window へ移動
vim.o.cedit = '<C-k>'


-- -- vim.fn.{func_name} で vim の関数を呼び出せる
-- if vim.fn.has('gui_running') == 0 then
--   vim.o.termguicolors = true
-- end

