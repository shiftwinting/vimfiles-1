scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf.vim'))
    finish
endif

" ! をつけるとノーマルモードから始まる
nnoremap <silent> <Space>ff         :<C-u>Leaderf file<CR>
nnoremap <silent> <Space>fl         :<C-u>Leaderf line<CR>
nnoremap <silent> <Space>fh         :<C-u>Leaderf help<CR>
nnoremap <silent> <Space>fj         :<C-u>Leaderf buffer<CR>
nnoremap <silent> <Space>fk         :<C-u>Leaderf mru<CR>
nnoremap <silent> <Space>f;         :<C-u>Leaderf cmdHistory<CR>
nnoremap          <Space>fg         :<C-u>Leaderf! rg -e ""<Left>
nnoremap <silent> <Space>fr         :<C-u>Leaderf! rg --recall<CR>
nnoremap <silent> 9                 :<C-u>Leaderf rg --previous<CR>
nnoremap <silent> 0                 :<C-u>Leaderf rg --next<CR>
nnoremap <silent> <Space>ft         :<C-u>Leaderf filetype<CR>
" yoink.vim 側で定義している
" nnoremap <silent> <C-p>     :<C-u>Leaderf command       --popup<CR>
nnoremap <silent> <Space>ml         :<C-u>Leaderf file ~/memo<CR>
nnoremap <silent> <Space><Space>    :<C-u>Leaderf command --run-immediately<CR>

" デフォルト
let g:Lf_DefaultMode = 'NameOnly'

" カーソルの点滅をなくす
let g:Lf_CursorBlink = 0

" ステータスラインのカラースキーム
let g:Lf_StlColorscheme = 'default'

" 検索に使う外部ツール
let g:Lf_DefaultExternalTool = 'rg'

" カレントバッファの名前を結果に表示しない (Leaderf file のみに有効)
let g:Lf_IgnoreCurrentBufferName = 1

" プレビューをポップアップで行う
let g:Lf_PreviewInPopup = 1

let g:Lf_MruMaxFiles = 1000

" ヘルプを非表示
let g:Lf_HideHelp = 0

" c: 基本的にカレントディレクトリ
" A: もし、上に RootMaker があれば、そのディレクトリから検索
let g:Lf_WorkingDirectoryMode = 'Ac'

" 履歴を3000
let g:Lf_HistoryNumber = 3000

let g:Lf_StlSeparator = {
\   'left': "\ue0b0",
\   'right': "\ue0b2",
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

" Leaderf rg --help
" --glob は .gitignore のような書き方
let g:Lf_RgConfig = [
\   '--smart-case',
\   '--glob=!.mypy_cache/*',
\   '--glob=!.node_modules/*',
\   '--glob=!tags',
\]

function! DefineMyLeaderFHighlishts() abort
    hi Lf_hl_cursorline  gui=underline guifg=fg guibg=bg
endfunction

augroup MyLeaderFHighlight
    autocmd!
    autocmd ColorScheme * call DefineMyLeaderFHighlishts()
augroup END

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

let g:Lf_StlPalette = {
\   'stlName': {
\       'gui': 'bold',
\       'font': 'NONE',
\       'guifg': '#2F5C00',
\       'guibg': '#baf2a3',
\       'cterm': 'bold',
\       'ctermfg': 'NONE',
\       'ctermbg': 'NONE'
\   },
\   'stlCategory': {
\       'guifg': '#4d4d4d',
\       'guibg': '#c7dac3',
\       'gui': 'NONE',
\       'font': 'NONE',
\       'ctermfg': '239',
\       'ctermbg': '151',
\       'cterm': 'NONE',
\   },
\   'stlNameOnlyMode': {
\       'guifg': '#4d4d4d',
\       'guibg': '#c9d473',
\       'gui': 'NONE',
\       'font': 'NONE',
\       'ctermfg': '239',
\       'ctermbg': '186',
\       'cterm': 'NONE',
\   },
\   'stlFullPathMode': {
\       'guifg': '#4d4d4d',
\       'guibg': '#dbe8cf',
\       'gui': 'NONE',
\       'font': 'NONE',
\       'ctermfg': '239',
\       'ctermbg': '187',
\       'cterm': 'NONE',
\   },
\   'stlFuzzyMode': {
\       'guifg': '#4d4d4d',
\       'guibg': '#dbe8cf',
\       'gui': 'NONE',
\       'font': 'NONE',
\       'ctermfg': '239',
\       'ctermbg': '187',
\       'cterm': 'NONE',
\   },
\   'stlRegexMode': {
\       'guifg': '#4d4d4d',
\       'guibg': '#acbf97',
\       'gui': 'NONE',
\       'font': 'NONE',
\       'ctermfg': '239',
\       'ctermbg': '144',
\       'cterm': 'NONE',
\   },
\   'stlCwd': {
\       'guifg': '#595959',
\       'guibg': '#e9f7e9',
\       'gui': 'NONE',
\       'font': 'NONE',
\       'ctermfg': '240',
\       'ctermbg': '195',
\       'cterm': 'NONE',
\   },
\   'stlBlank': {
\       'gui': 'NONE',
\       'font': 'NONE',
\       'guifg': '#073642',
\       'guibg': '#eee8d5',
\       'cterm': 'NONE',
\       'ctermfg': 'NONE',
\       'ctermbg': 'NONE'
\   },
\   'stlLineInfo': {
\       'guifg': '#595959',
\       'guibg': '#e9f7e9',
\       'gui': 'NONE',
\       'font': 'NONE',
\       'ctermfg': '240',
\       'ctermbg': '195',
\       'cterm': 'NONE',
\   },
\   'stlTotal': {
\       'guifg': '#4d4d4d',
\       'guibg': '#c7dac3',
\       'gui': 'NONE',
\       'font': 'NONE',
\       'ctermfg': '239',
\       'ctermbg': '151',
\       'cterm': 'NONE',
\   }
\ }

" popup 検索結果は下線のみ
let g:Lf_PopupPalette = {
\   'light': {
\       'Lf_hl_cursorline': {
\           'gui': 'underline',
\           'font': 'NONE',
\           'guifg': 'fg',
\           'guibg': 'bg',
\           'cterm': 'NONE',
\           'ctermfg': 'NONE',
\           'ctermbg': 'NONE'
\       }
\   }
\}

