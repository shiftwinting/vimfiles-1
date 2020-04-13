scriptencoding utf-8

" スタックトレースを表示
let g:Lf_Exception = 1
" set background=dark
" set lines=30 columns=100

nnoremap [Leaderf] <Nop>
nmap     <Space>f [Leaderf]

" ! をつけるとノーマルモードから始まる
nnoremap          [Leaderf]g        :<C-u>Leaderf! rg --match-path -e ""<Left>
nnoremap <silent> 0                 :<C-u>Leaderf  rg --next<CR>
nnoremap <silent> 9                 :<C-u>Leaderf  rg --previous<CR>
nnoremap <silent> [Leaderf]r        :<C-u>Leaderf! rg --recall<CR>
nnoremap <silent> [Leaderf];        :<C-u>Leaderf  cmdHistory<CR>
nnoremap <silent> [Leaderf]c        :<C-u>Leaderf  cdnjs<CR>
nnoremap <silent> [Leaderf]f        :<C-u>Leaderf  file<CR>
nnoremap <silent> [Leaderf]h        :<C-u>Leaderf  help<CR>
nnoremap <silent> [Leaderf]j        :<C-u>Leaderf  buffer<CR>
nnoremap <silent> [Leaderf]k        :<C-u>Leaderf  mru --nowrap<CR>
nnoremap <silent> [Leaderf]o        :<C-u>Leaderf  openbrowser<CR>
nnoremap <silent> [Leaderf]q        :<C-u>Leaderf  ghq<CR>
nnoremap <silent> [Leaderf]t        :<C-u>Leaderf  filetype<CR>
nnoremap <silent> [Leaderf]w        :<C-u>Leaderf  window<CR>
nnoremap <silent> [Leaderf]m        :<C-u>Leaderf  mrw --nowrap<CR>
nnoremap <silent> [Leaderf]l        :<C-u>Leaderf  line<CR>
nnoremap <silent> [Leaderf]s        :<C-u>Leaderf  bufTag<CR>
nnoremap <silent> [Leaderf]v        :<C-u><C-r>=printf("Leaderf file %s", g:vimfiles_path)<CR><CR>

nnoremap <silent> <Space><Space>    :<C-u>Leaderf command --run-immediately<CR>
nnoremap <silent> <C-e>             :<C-u><C-r>=printf('Leaderf filer %s', expand('%:p:h'))<CR><CR>
nnoremap <silent> <Space>;t         :<C-u>Leaderf sonictemplate<CR>
nnoremap <silent> <Space>ml         :<C-u>Leaderf filer ~/memo<CR>

" Reference
nnoremap <silent> gr                :<C-u><C-r>=printf('Leaderf! rg --match-path -e "%s" -w -F', expand('<cword>'))<CR><CR>
vnoremap <silent> gr                :<C-u><C-r>=printf('Leaderf! rg --match-path -e %s -w -F', leaderf#Rg#visual())<CR><CR>


function! s:leaderf_settings() abort
    silent! setlocal signcolumn=no
    silent! setlocal scrolloff=0
endfunction


function! s:leaderf_python_settings() abort
    nnoremap <buffer> <silent> [Leaderf]i :<C-u>Leaderf nayvy<CR>
endfunction


augroup MyLeaderf
    autocmd!
    autocmd Filetype leaderf call <SID>leaderf_settings()
    autocmd Filetype python  call <SID>leaderf_python_settings()
augroup END


" デフォルト
let g:Lf_DefaultMode = 'NameOnly'

" カーソルの点滅をなくす
let g:Lf_CursorBlink = 0

" ステータスラインのカラースキーム
if g:colors_name ==# 'one'
    let g:Lf_StlColorscheme = 'one'
else
    let g:Lf_StlColorscheme = 'default'
endif


" 検索に使う外部ツール
let g:Lf_DefaultExternalTool = 'rg'

" カレントバッファの名前を結果に表示しない (Leaderf file のみに有効)
let g:Lf_IgnoreCurrentBufferName = 1

" プレビューをポップアップで行う
" let g:Lf_PreviewInPopup = 1
" let g:Lf_PreviewHorizontalPosition = 'top'
" let g:Lf_PreviewPopupHeight = 30

" 横幅
" let g:Lf_PreviewPopupWidth = 0.5

let g:Lf_MruMaxFiles = 1000

" ヘルプを非表示
let g:Lf_HideHelp = 1

" カレントディレクトリよりも上に `g:Lf_RootMakers` があれば、そのディレクトリから検索
" なければ、カレントディレクトリから検索
let g:Lf_WorkingDirectoryMode = 'A'

" 履歴を3000
let g:Lf_HistoryNumber = 3000

let g:Lf_ReverseOrder = 1

let g:Lf_WindowHeight = 0.4

" 下に表示
let g:Lf_WindowPosition = 'bottom'
" 上にプレビュー表示
" let g:Lf_PreviewHorizontalPosition = 'above'
" プレビューの高さ
" let g:Lf_PreviewPopupHeight = 30

" ----------
" popup
" ----------
" ポップアップの位置
" let g:Lf_PopupPosition = [10, 0]

" let g:Lf_StlSeparator = {
" \   'left': "\ue0b0",
" \   'right': "\ue0b2",
" \}

let g:Lf_HistoryExclude = {
\   'cmd':  ['^wq?!?$', '^qa?!?$', '^.\s*$', '^\d+$'],
\   'search':  []
\}

let g:Lf_WildIgnore = {
\   'dir': ['**/.mypy_cache/*', 'node_modules/*', '*.pyc'],
\   'file': ['tags']
\}

let g:Lf_MruWildIgnore = {}

" Leaderf rg --help
" --glob は .gitignore のような書き方
let g:Lf_RgConfig = [
\   '--smart-case',
\   '--glob=!*/.mypy_cache/*',
\   '--glob=!.node_modules/*',
\   '--glob=!tags*',
\]

let g:Lf_StlSeparator = { 'left': '', 'right': '' }

function! DefineMyLeaderFHighlishts() abort
    hi Lf_hl_cursorline  gui=underline guifg=fg guibg=bg
endfunction

" augroup MyLeaderFHighlight
"     autocmd!
"     autocmd ColorScheme * call DefineMyLeaderFHighlishts()
" augroup END

let g:Lf_NormalMap = get(g:, 'Lf_NormalMap', {})

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
\   '<C-s>':    ['<C-x>'],
\}


" =============================
" status line
" =============================
let s:stlPalette = {}

if &background ==# 'light'

    let s:stlPalette.solarized = {
    \   'stlName':         { 'guifg': '#2F5C00', 'guibg': '#baf2a3' },
    \   'stlCategory':     { 'guifg': '#4d4d4d', 'guibg': '#c7dac3' },
    \   'stlNameOnlyMode': { 'guifg': '#4d4d4d', 'guibg': '#c9d473' },
    \   'stlFullPathMode': { 'guifg': '#4d4d4d', 'guibg': '#dbe8cf' },
    \   'stlFuzzyMode':    { 'guifg': '#4d4d4d', 'guibg': '#dbe8cf' },
    \   'stlRegexMode':    { 'guifg': '#4d4d4d', 'guibg': '#acbf97' },
    \   'stlCwd':          { 'guifg': '#595959', 'guibg': '#e9f7e9' },
    \   'stlLineInfo':     { 'guifg': '#595959', 'guibg': '#e9f7e9' },
    \   'stlTotal':        { 'guifg': '#4d4d4d', 'guibg': '#c7dac3' },
    \   'stlBlank':        { 'guifg': '#073642', 'guibg': '#eee8d5' },
    \}

    let s:stlPalette.one = {
    \   'stlName':         { 'guifg': '#2F5C00', 'guibg': '#baf2a3' },
    \   'stlCategory':     { 'guifg': '#4d4d4d', 'guibg': '#c7dac3' },
    \   'stlNameOnlyMode': { 'guifg': '#4d4d4d', 'guibg': '#c9d473' },
    \   'stlFullPathMode': { 'guifg': '#4d4d4d', 'guibg': '#dbe8cf' },
    \   'stlFuzzyMode':    { 'guifg': '#4d4d4d', 'guibg': '#dbe8cf' },
    \   'stlRegexMode':    { 'guifg': '#4d4d4d', 'guibg': '#acbf97' },
    \   'stlCwd':          { 'guifg': '#595959', 'guibg': '#e9f7e9' },
    \   'stlLineInfo':     { 'guifg': '#595959', 'guibg': '#e9f7e9' },
    \   'stlTotal':        { 'guifg': '#4d4d4d', 'guibg': '#c7dac3' },
    \   'stlBlank':        { 'guifg': '#494b53', 'guibg': '#e1e1e1' },
    \}

else
    " dark

    " from nord
    let s:nord0_gui        = '#2E3440' " #2E3440
    let s:nord1_gui        = '#3B4252' " #3B4252
    let s:nord2_gui        = '#434C5E' " #434C5E
    let s:nord3_gui        = '#4C566A' " #4C566A
    let s:nord3_gui_bright = '#616E88' " #616E88
    let s:nord4_gui        = '#D8DEE9' " #D8DEE9
    let s:nord5_gui        = '#E5E9F0' " #E5E9F0
    let s:nord6_gui        = '#ECEFF4' " #ECEFF4
    let s:nord7_gui        = '#8FBCBB' " #8FBCBB
    let s:nord8_gui        = '#88C0D0' " #88C0D0
    let s:nord9_gui        = '#81A1C1' " #81A1C1
    let s:nord10_gui       = '#5E81AC' " #5E81AC
    let s:nord11_gui       = '#BF616A' " #BF616A
    let s:nord12_gui       = '#D08770' " #D08770
    let s:nord13_gui       = '#EBCB8B' " #EBCB8B
    let s:nord14_gui       = '#A3BE8C' " #A3BE8C
    let s:nord15_gui       = '#B48EAD' " #B48EAD

    let s:stlPalette.nord = {
    \   'stlName':         { 'guifg': s:nord3_gui, 'guibg': s:nord8_gui },
    \   'stlCategory':     { 'guifg': s:nord5_gui, 'guibg': s:nord1_gui  },
    \   'stlNameOnlyMode': { 'guifg': s:nord2_gui, 'guibg': s:nord13_gui },
    \   'stlFullPathMode': { 'guifg': s:nord2_gui, 'guibg': s:nord13_gui },
    \   'stlFuzzyMode':    { 'guifg': s:nord2_gui, 'guibg': s:nord14_gui },
    \   'stlRegexMode':    { 'guifg': s:nord2_gui, 'guibg': s:nord7_gui  },
    \   'stlCwd':          { 'guifg': s:nord6_gui, 'guibg': s:nord3_gui  },
    \   'stlLineInfo':     { 'guifg': s:nord5_gui, 'guibg': s:nord0_gui  },
    \   'stlTotal':        { 'guifg': s:nord6_gui, 'guibg': s:nord10_gui },
    \   'stlBlank':        { 'guifg': 'NONE',      'guibg': 'NONE'       },
    \}

endif

if has_key(s:stlPalette, g:colors_name)
    let g:Lf_StlPalette = s:stlPalette[g:colors_name]
endif



let g:Lf_PreviewResult = {
\   'File': 0,
\   'Buffer': 0,
\   'Mru': 0,
\   'Tag': 0,
\   'BufTag': 0,
\   'Function': 0,
\   'Line': 1,
\   'Colorscheme': 1,
\   'Rg': 0,
\   'Gtags': 0
\}


let g:Lf_DevIconsExactSymbols = {
\   'vimrc':  '',
\   'gvimrc': '',
\   'tags':   '󿧸',
\}

let g:Lf_DevIconsExtensionSymbols = {
\   'lock': '󿫺',
\   'vue':  ''
\}

let g:Lf_DevIconsPalette = get(g:, 'Lf_DevIconsPalette', {})
let g:Lf_DevIconsPalette.dark = {
\   'vim': { 'guifg': s:nord14_gui }
\}
