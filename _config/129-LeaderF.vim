scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf.vim'))
    finish
endif

" ! をつけるとノーマルモードから始まる
nnoremap <silent> <Space>ff :<C-u>Leaderf file          --popup<CR>
nnoremap <silent> <Space>fl :<C-u>Leaderf line          --popup<CR>
nnoremap <silent> <Space>fh :<C-u>Leaderf help          --popup<CR>
nnoremap <silent> <Space>fj :<C-u>Leaderf buffer        --popup<CR>
nnoremap <silent> <Space>fk :<C-u>Leaderf mru           --popup<CR>
nnoremap <silent> <Space>f; :<C-u>Leaderf cmdHistory    --popup<CR>
nnoremap          <Space>fg :<C-u>Leaderf! --popup rg -e ""<Left>
nnoremap <silent> <Space>fr :<C-u>Leaderf! rg           --recall<CR>
nnoremap <silent> 9         :<C-u>Leaderf rg            --previous<CR>
nnoremap <silent> 0         :<C-u>Leaderf rg            --next<CR>
nnoremap <silent> <Space>ft :<C-u>Leaderf filetype      --popup<CR>
" yoink.vim 側で定義している
" nnoremap <silent> <C-p>     :<C-u>Leaderf command       --popup<CR>
nnoremap <silent> <Space>ml :<C-u>Leaderf ~/memo        --popup<CR>

" デフォルト
let g:Lf_DefaultMode = 'NameOnly'

" カーソルの点滅をなくす
let g:Lf_CursorBlink = 0

" ステータスラインのカラースキーム
" TODO: solarized がない！！
let g:Lf_StlColorscheme = ''

" 検索に使う外部ツール
let g:Lf_DefaultExternalTool = 'rg'

" カレントバッファの名前を結果に表示しない
let g:Lf_IgnoreCurrentBufferName = 1

" XXX: キャンセルしたら、位置を戻すようにしてほしい...

" let g:Lf_WindowPosition = 'popup'

" ---------------
" キーマッピング

" <C-r> : 検索切り替え: fuzzy / regex 
" <C-f> : 検索切り替え: fullpath / name only
" <Tab> : モード切替: Normal / Insert
" <C-v> : クリップボードから貼り付け
" <C-u> : <C-u>
" <C-j> <C-k> : 上下移動
" <Up> <Down> : 履歴操作
" <CR>  : 開く
" <C-x> : horizonal split で開く
" <C-]> : vertical split で開く
" <C-t> : タブ で開く
" <F5>  : キャッシュ更新
" <C-s> : 複数ファイル選択
" <C-a> : 全ファイル選択
" <C-l> : 全ファイル選択の解除
" <BS>, <C-h>  : 前の文字削除
" <Del> : 後ろの文字削除
" <Home> : 先頭へカーソル移動
" <End>  : 末尾にカーソル移動
" <Left> : 左にカーソル移動
" <Right> : 右にカーソル移動
" <C-p> : プレビュー表示

" cmdHistory/searchHistory/command
" <C-o> : 編集

" ~/vimfiles/plugged/LeaderF/autoload/leaderf/python/leaderf/cli.py を見てね
" key <- value (value を key として解釈させる)
let g:Lf_CommandMap = {
\   '<Up>':     ['<C-p>'],
\   '<Down>':   ['<C-n>'],
\   '<C-v>':    ['<C-o>'],
\   '<C-x>':    ['<C-s>'],
\   '<C-]>':    ['<C-v>'],
\   '<C-p>':    ['<C-q>'],
\   '<C-o>':    ['<C-e>'],
\   '<Del>':    ['<C-d>'],
\}

" プレビューをポップアップで行う
let g:Lf_PreviewInPopup = 1

let g:Lf_StlSeparator = {
\   'left': "\ue0b0",
\   'right': "\ue0b2",
\}

" 検索結果は下線のみ
let g:Lf_PopupPalette = {
\   'light': {
\       'Lf_hl_cursorline': {
\           'gui': 'underline',
\           'font': 'NONE',
\           'guifg': '#4d4d4d',
\           'guibg': '#fafbff',
\           'cterm': 'NONE',
\           'ctermfg': 'NONE',
\           'ctermbg': 'NONE'
\       }
\   }
\}

let g:Lf_HistoryExclude = {
\   'cmd':  ['^wq?!?$', '^qa?!?$', '^.\s*$', '^\d+$'],
\   'search':  []
\}

let g:Lf_WildIgnore = {
\   'dir': ['.mypy_cache/*', 'node_modules/*'],
\   'file': ['tags']
\}

let g:Lf_MruWildIgnore = {}

" c: 基本的にカレントディレクトリ
" A: もし、上に RootMaker があれば、そのディレクトリから検索
let g:Lf_WorkingDirectoryMode = 'Ac'

" 履歴を3000
let g:Lf_HistoryNumber = 3000

" Leaderf rg --help
" --glob は .gitignore のような書き方
let g:Lf_RgConfig = [
\   '--smart-case',
\   '--glob=!.mypy_cache/*',
\   '--glob=!.node_modules/*',
\   '--glob=!tags',
\]
