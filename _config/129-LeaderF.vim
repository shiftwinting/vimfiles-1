scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf.vim'))
    finish
endif

nnoremap <silent> <Space>ff :<C-u>LeaderfFile<CR>
nnoremap <silent> <Space>fl :<C-u>LeaderfLine<CR>
nnoremap <silent> <Space>fh :<C-u>LeaderfHelp<CR>
nnoremap <silent> <Space>fj :<C-u>LeaderfBuffer<CR>
nnoremap <silent> <Space>fk :<C-u>LeaderfMru<CR>
nnoremap <silent> ;         :<C-u>LeaderfHistoryCmd<CR>
nnoremap <silent> <Space>fr :<C-u>Leaderf rg --recall<CR>
nnoremap <silent> 9         :<C-u>Leaderf rg --previous<CR>
nnoremap <silent> 0         :<C-u>Leaderf rg --next<CR>
nnoremap <silent> <Space>ft :<C-u>LeaderfFiletype<CR>

function! MyLeaderfRgPrompt() abort
    let l:pattern = input('LeaderfRg: ')
    execute 'Leaderf rg -e '.l:pattern
endfunction
nnoremap <Space>fg :<C-u>call MyLeaderfRgPrompt()<CR>

" デフォルト
let g:Lf_DefaultMode = 'NameOnly'

" カーソルの点滅をなくす
let g:Lf_CursorBlink = 0

" ステータスラインのカラースキーム
" TODO: solarized がない！！
let g:Lf_StlColorscheme = ''

" g:Lf_StlPalette でステータスラインの色の設定ができる
" stlName
" stlCategory
" stlNameOnlyMode
" stlFullPathMode
" stlFuzzyMode
" stlRegexMode
" stlCwd
" stlBlank
" stlLineInfo
" stlTotal

" 検索に使う外部ツール
let g:Lf_DefaultExternalTool = 'rg'

" カレントバッファの名前を結果に表示しない
let g:Lf_IgnoreCurrentBufferName = 1

" XXX: キャンセルしたら、位置を戻すようにしてほしい...
"
" let g:Lf_PreviewResult = {
" \   'File': 0,
" \   'Buffer': 0,
" \   'Mru': 0,
" \   'Tag': 0,
" \   'BufTag': 1,
" \   'Function': 1,
" \   'Line': 1,
" \   'Colorscheme': 0,
" \   'Rg': 0,
" \   'Gtags': 0
" \}

let g:Lf_WindowPosition = 'popup'

" ポップアップのカラースキーマ
" let g:Lf_PopupColorscheme = 'default'
" XXX: solarized がない！！

" let g:Lf_PopupPalette = {}

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

" ~/vimfiles/plugged/LeaderF/autoload/leaderf/python/leaderf/cli.py を見てね
" key <- value (value を key として解釈させる)
let g:Lf_CommandMap = {
\   '<Up>':     ['<C-p>'],
\   '<Down>':   ['<C-n>'],
\   '<C-v>':    ['<C-o>'],
\   '<C-x>':    ['<C-s>'],
\   '<C-]>':    ['<C-v>'],
\   '<Esc>':    ['<C-q>'],
\   '<C-o>':    ['<C-e>'],
\}
" \   '<C-p>':    ['<A-k>'],

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
\   'cmd':  ['^wq?!?', '^qa?!?', '^.\s*$', '^\d+$'],
\   'search':  []
\}

let g:Lf_WildIgnore = {
\   'dir': ['.mypy_cache/*'],
\   'file': ['tags']
\}
let g:Lf_MruWildIgnore = {}

" c: 基本的にカレントディレクトリ
" A: もし、上に RootMaker があれば、そのディレクトリから検索
let g:Lf_WorkingDirectoryMode = 'Ac'

" 履歴を3000
let g:Lf_HistoryNumber = 3000


