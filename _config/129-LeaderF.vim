scriptencoding utf-8

" スタックトレースを表示
let g:Lf_Exception = 1

" ! をつけるとノーマルモードから始まる
nnoremap          <Space>fg        :<C-u><C-r>=printf('Leaderf! rg --popup-width=%d --match-path -e ""', <SID>nice_width(200))<CR><Left>
nnoremap <silent> 0                 :<C-u>Leaderf  rg --next<CR>
nnoremap <silent> 9                 :<C-u>Leaderf  rg --previous<CR>
nnoremap <silent> <Space>fr        :<C-u><C-r>=printf('Leaderf! rg --recall --popup-width=%d', <SID>nice_width(200))<CR><CR>
" nnoremap <silent> <Space>f;        :<C-u>Leaderf  cmdHistory<CR>
" nnoremap <silent> <Space>fc        :<C-u>Leaderf  cdnjs<CR>
nnoremap <silent> <Space>ff        :<C-u>Leaderf  file<CR>
nnoremap <silent> <Space>fh        :<C-u>Leaderf  help<CR>
nnoremap <silent> <Space>j         :<C-u>Leaderf  buffer --nowrap<CR>
nnoremap <silent> <Space>fj        :<C-u>Leaderf  buffer --nowrap<CR>
nnoremap <silent> <Space>fk        :<C-u>Leaderf  mru --nowrap<CR>
nnoremap <silent> <Space>fo        :<C-u>Leaderf  openbrowser<CR>
nnoremap <silent> <Space>fq        :<C-u>Leaderf  ghq<CR>
nnoremap <silent> <Space>ft        :<C-u>Leaderf  filetype<CR>
" nnoremap <silent> <Space>fw        :<C-u>Leaderf  window<CR>
nnoremap <silent> <Space>fm        :<C-u><C-r>=printf('Leaderf  file --file %s', g:vimrc#mrw#cache_path)<CR><CR>
nnoremap <silent> <Space>fl        :<C-u><C-r>=printf('Leaderf  line --regexMode --popup-width=%d', <SID>nice_width(200))<CR><CR>
nnoremap <silent> <Space>fs        :<C-u>Leaderf  bufTag<CR>
nnoremap <silent> <Space>fv        :<C-u><C-r>=printf("Leaderf file %s", g:vimfiles_path)<CR><CR>
nnoremap <silent> <Space>fb        :<C-u>Leaderf  bookmark --nowrap<CR>

nnoremap <silent> <Space><Space>    :<C-u>Leaderf command --run-immediately<CR>
nnoremap <silent> <C-e>             :<C-u><C-r>=printf("Leaderf filer '%s'", substitute(expand('%:p:h'), '\\', '/', 'g'))<CR><CR>
nnoremap <silent> <Space>;t         :<C-u>Leaderf sonictemplate<CR>
nnoremap <silent> <Space>ml         :<C-u>Leaderf filer ~/memo<CR>
nnoremap <silent> <Space>fc        :<C-u>Leaderf switch<CR>
nnoremap <silent> <Space>fd        :<C-u>Leaderf dirty<CR>
nnoremap <silent> <Space>fn        :<C-u>Leaderf neosnippet<CR>
nnoremap <silent> <Space>;h         :<C-u>Leaderf favhelp<CR>
nnoremap <silent> <Space>fp        :<C-u>Leaderf menu<CR>

" nnoremap <silent> /                 :<C-u><C-r>=printf('Leaderf  line --regexMode --popup-width=%d', <SID>nice_width(200))<CR><CR>

cnoremap <silent> <C-l> <C-c>\|:Leaderf cmdHistory<CR>

function! s:nice_width(maxwidth) abort
    return min([&columns - 10, a:maxwidth - 10])
endfunction

" leaderf#Rg#getPattern()
"   0: <cword>
"   1: <cWORD>
"   2: leaderf#Rg#visual()

" Reference
nnoremap <silent> gr                :<C-u><C-r>=printf('Leaderf! rg --popup-width=%d --match-path --regexMode -e "%s" -w -F', <SID>nice_width(200), leaderf#Rg#getPattern(0))<CR><CR>
vnoremap <silent> gr                :<C-u><C-r>=printf('Leaderf! rg --popup-width=%d --match-path --regexMode -e %s -w -F', <SID>nice_width(200), leaderf#Rg#getPattern(2))<CR><CR>
" buftag で検索
nnoremap <silent> <C-g><C-r>        :<C-u><C-r>=printf('Leaderf bufTag --regexMode --input %s', leaderf#Rg#getPattern(0))<CR><CR>
vnoremap <silent> <C-g><C-r>        :<C-u><C-r>=printf('Leaderf bufTag --regexMode --input %s', leaderf#Rg#getPattern(2)[1:-2])<CR><CR>


function! s:leaderf_settings() abort
    silent! setlocal signcolumn=no
    silent! setlocal scrolloff=0
endfunction


" function! s:leaderf_python_settings() abort
"     nnoremap <buffer> <silent> <Space>fi :<C-u>Leaderf nayvy<CR>
" endfunction


augroup MyLeaderf
    autocmd!
    autocmd Filetype leaderf call <SID>leaderf_settings()
    " autocmd Filetype python  call <SID>leaderf_python_settings()
augroup END


" デフォルト
let g:Lf_DefaultMode = 'Regex'

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
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewHorizontalPosition = 'right'
let g:Lf_PopupPreviewPosition = 'top'

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
" let g:Lf_WindowPosition = 'bottom'
let g:Lf_WindowPosition = 'popup'


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

let g:Lf_MruWildIgnore = {
\   'file': ['*.dbout']
\}

" Leaderf rg --help
" --glob は .gitignore のような書き方
let g:Lf_RgConfig = [
\   '--smart-case',
\   '--glob=!*/.mypy_cache/*',
\   '--glob=!.node_modules/*',
\   '--glob=!tags*',
\]

let g:Lf_StlSeparator = { 'left': '', 'right': '' }

" https://bit.ly/2VzuoUO
" https://bit.ly/2yZYwAX
" 
" let g:Lf_NormalMap = get(g:, 'Lf_NormalMap', {})
let g:Lf_NormalMap = {
\   '_': [
\      ['<C-j>', 'j'],
\      ['<C-k>', 'k'],
\      ['K',     '<Nop>'],
\      ['M',     '<Nop>'],
\   ],
\   'Rg': [
\      ['Q', ':exec g:Lf_py "rgExplManager.outputToQflist()" \| :exec g:Lf_py "rgExplManager.quit()" <bar> :Qfreplace<CR>'],
\   ],
\   'Filer': [
\      ['B', ':exec g:Lf_py "filerExplManager.quit()" <bar> :LeaderfBookmark<CR>'],
\   ],
\}

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
\   '<C-o>':    ['<C-l>'],
\   '<Del>':    ['<C-d>'],
\   '<C-s>':    ['<C-x>'],
\   '<Left>':   ['<C-b>'],
\   '<Right>':  ['<C-f>'],
\   '<End>':    ['<C-e>'],
\   '<Home>':   ['<C-a>'],
\   '<C-f>':    ['<C-g>'],
\}


" =============================
" status line
" =============================
let s:stlPalette = {}
let s:popupPalette = {}

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
    let s:nord0_gui        = '#2E3440'
    let s:nord1_gui        = '#3B4252'
    let s:nord2_gui        = '#434C5E'
    let s:nord3_gui        = '#4C566A'
    let s:nord3_gui_bright = '#616E88'
    let s:nord4_gui        = '#D8DEE9'
    let s:nord5_gui        = '#E5E9F0'
    let s:nord6_gui        = '#ECEFF4'
    let s:nord7_gui        = '#8FBCBB'
    let s:nord8_gui        = '#88C0D0'
    let s:nord9_gui        = '#81A1C1'
    let s:nord10_gui       = '#5E81AC'
    let s:nord11_gui       = '#BF616A'
    let s:nord12_gui       = '#D08770'
    let s:nord13_gui       = '#EBCB8B'
    let s:nord14_gui       = '#A3BE8C'
    let s:nord15_gui       = '#B48EAD'

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
    \   'stlBlank':        { 'guifg': 'NONE',      'guibg': s:nord3_gui  },
    \}

    let s:popupPalette.nord = {
    \   'Lf_hl_popup_inputText':    { 'guifg': s:nord4_gui,  'guibg': s:nord1_gui  },
    \   'Lf_hl_popup_window':       { 'guifg': s:nord4_gui,  'guibg': '#353b4b'  },
    \   'Lf_hl_popup_blank':        { 'guifg': s:nord4_gui,  'guibg': s:nord1_gui  },
    \   'Lf_hl_popup_prompt':       { 'guifg': s:nord13_gui, 'guibg': s:nord1_gui  },
    \   'Lf_hl_popup_spin':         { 'guifg': s:nord13_gui, 'guibg': s:nord1_gui  },
    \   'Lf_hl_popup_normalMode':   { 'guifg': s:nord2_gui,  'guibg': s:nord8_gui  },
    \   'Lf_hl_popup_inputMode':    { 'guifg': s:nord2_gui,  'guibg': s:nord5_gui  },
    \   'Lf_hl_popup_category':     { 'guifg': s:nord5_gui,  'guibg': s:nord1_gui  },
    \   'Lf_hl_popup_nameOnlyMode': { 'guifg': s:nord2_gui,  'guibg': s:nord7_gui  },
    \   'Lf_hl_popup_fullPathMode': { 'guifg': s:nord2_gui,  'guibg': s:nord7_gui  },
    \   'Lf_hl_popup_fuzzyMode':    { 'guifg': s:nord2_gui,  'guibg': s:nord7_gui  },
    \   'Lf_hl_popup_regexMode':    { 'guifg': s:nord2_gui,  'guibg': s:nord7_gui  },
    \   'Lf_hl_popup_cwd':          { 'guifg': s:nord6_gui,  'guibg': s:nord3_gui  },
    \   'Lf_hl_popup_lineInfo':     { 'guifg': s:nord5_gui,  'guibg': s:nord0_gui  },
    \   'Lf_hl_popup_total':        { 'guifg': s:nord6_gui,  'guibg': s:nord10_gui },
    \   'Lf_hl_selection':          { 'guifg': s:nord2_gui,  'guibg': s:nord14_gui},
    \   'Lf_hl_cursorline':         { 'guifg': s:nord4_gui,  'guibg': s:nord2_gui, 'gui': 'bold'},
    \   'Lf_hl_match':              { 'guifg': s:nord6_gui,  'guibg': s:nord10_gui},
    \   'Lf_hl_match0':             { 'guifg': s:nord6_gui,  'guibg': s:nord10_gui},
    \   'Lf_hl_match1':             { 'guifg': s:nord6_gui,  'guibg': s:nord10_gui},
    \   'Lf_hl_match2':             { 'guifg': s:nord6_gui,  'guibg': s:nord10_gui},
    \   'Lf_hl_match3':             { 'guifg': s:nord6_gui,  'guibg': s:nord10_gui},
    \   'Lf_hl_match4':             { 'guifg': s:nord6_gui,  'guibg': s:nord10_gui},
    \   'Lf_hl_matchRefine':        { 'guifg': s:nord1_gui,  'guibg': s:nord8_gui },
    \   'Lf_hl_rgHighlight':        { 'guifg': s:nord1_gui,  'guibg': s:nord8_gui, 'gui': 'bold'},
    \   'Lf_hl_gtagsHighlight':     { 'guifg': s:nord1_gui,  'guibg': s:nord8_gui, 'gui': 'bold'},
    \}
    " ポップアップのカーソル
    " \   'Lf_hl_popup_cursor':       { 'guifg': 'NONE',  'guibg': 'NONE' },

endif

if has_key(s:stlPalette, g:colors_name)
    let g:Lf_StlPalette = get(s:stlPalette, g:colors_name, {})
endif

let g:Lf_PopupPalette = {}
if has_key(s:popupPalette, g:colors_name)
    let g:Lf_PopupPalette[&background] = get(s:popupPalette, g:colors_name, {})
endif


" function! s:gui2term() abort
"     for [l:name, l:dict] in items(s:popupPalette)
"         let l:res = l:name
"         for [l:key, l:val] in items(l:dict)
"             let l:res .= ' ' . l:key . '=' . l:val
"         endfor
"         for [l:key, l:val] in items(l:dict)
"             let [l:r, l:l] = ['', '']
"             if l:val =~# '^#'
"                 let l:r = 'cterm' . l:key[3:]
"                 let l:l = gui2cterm#rgb(l:val[1:])
"             elseif l:key ==# 'gui'
"                 let l:r = 'cterm'
"                 let l:l = l:val
"             else
"                 let l:r = 'cterm' . l:key[3:]
"                 let l:l = 'NONE'
"             endif
"             let l:res .= ' ' . l:r . '=' . l:l
"         endfor
"         echo l:res
"     endfor
" endfunction
"
" call s:gui2term()


let g:Lf_PreviewResult = {
\   'File': 0,
\   'Buffer': 0,
\   'Mru': 0,
\   'Tag': 0,
\   'BufTag': 1,
\   'Function': 0,
\   'Line': 1,
\   'Colorscheme': 1,
\   'Rg': 0,
\   'Gtags': 0,
\   'neosnippet': 1,
\   'dirty': 1,
\}


let g:Lf_DevIconsExactSymbols = {
\   'vimrc':  '',
\   'gvimrc': '',
\   'tags':   '󿧸',
\   '.gitconfig':   '',
\}

let g:Lf_DevIconsExtensionSymbols = {
\   'lock': '󿫺',
\   'vue':  ''
\}

let g:Lf_DevIconsPalette = get(g:, 'Lf_DevIconsPalette', {})
let g:Lf_DevIconsPalette.dark = {
\   'vim': { 'guifg': s:nord14_gui },
\   'vimrc': { 'guifg': s:nord14_gui },
\   'gvimrc': { 'guifg': s:nord14_gui },
\}
