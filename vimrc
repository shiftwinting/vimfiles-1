" Encoding {{{

set encoding=utf-8
scriptencoding utf-8

" 変更可能なら、設定(エラーになるため)
if &modifiable
    set fileencoding=utf-8
endif

" " 改行コードの設定
set fileformats=unix,dos,mac

" https://github.com/vim-jp/issues/issues/1186
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932

" " 内部エンコーディング
" set encoding=utf-8
" " スクリプトの文字コード (encodingを設定した後に設定する必要がある)
" scriptencoding utf-8


" Plug {{{

" ダウンロード先ディレクトリを指定
call plug#begin('~/vimfiles/plugged')

Plug 'junegunn/vim-plug'
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-jp/vital.vim'
Plug 'vim-jp/syntax-vim-ex' " VimL のハイライト拡張

Plug 'LeafCage/yankround.vim'
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
Plug 'dhruvasagar/vim-table-mode'
Plug 'glidenote/memolist.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'jremmen/vim-ripgrep'
Plug 'kana/vim-repeat'
Plug 'ludovicchabant/vim-gutentags' " tags 生成
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'markonm/traces.vim' " :s の可視化
Plug 'mattn/emmet-vim'
Plug 'mattn/sonictemplate-vim'
Plug 'mechatroner/rainbow_csv'
Plug 'rhysd/clever-f.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'simeji/winresizer' " ウィンドウ操作
Plug 'skanehira/translate.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 't9md/vim-quickhl'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-surround'
Plug 'tyru/capture.vim' " Exコマンドをバッファへ出力
Plug 'tyru/open-browser.vim'
Plug 'itchyny/calendar.vim'
Plug 'previm/previm'
Plug 'tpope/vim-endwise'
Plug 'kana/vim-tabpagecd'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'dbeniamine/todo.txt-vim'
Plug 'tomtom/tcomment_vim'

" ==============================================================================

" == python
" Plug 'davidhalter/jedi-vim'     " from xxx<Space> import のために使っているけど、どうにかできないかな
Plug 'ambv/black'

" == php
Plug 'jwalton512/vim-blade'

" == nim
Plug 'zah/nim.vim'

" == frontend
" https://www.davidosomething.com/blog/vim-for-javascript/
" Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
" Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx', 'html', 'vue'] }
" Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html', 'vue'] }
Plug 'othree/html5.vim'
" Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx', 'html', 'vue'] }
" Plug 'posva/vim-vue', { 'for': 'javascript' }

" syntax
Plug 'yuezk/vim-js'
" Plug 'maxmellon/vim-jsx-pretty'

" == lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-neosnippet'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" == complete vim
Plug 'machakann/vim-Verdin'

" " == textobj
Plug 'kana/vim-textobj-user'
Plug 'osyo-manga/vim-textobj-multiblock'
" Plug 'kana/vim-textobj-entire'
" Plug 'kana/vim-textobj-line'
" Plug 'coderifous/textobj-word-column.vim'
" Plug 'kana/vim-textobj-fold'

" == ctrlp
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-ghq'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'zeero/vim-ctrlp-help'
Plug 'mattn/ctrlp-launcher'

" == dark power
Plug 'Shougo/defx.nvim'
Plug 'kristijanhusak/defx-icons'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neopairs.vim'
Plug 'Shougo/deol.nvim'

" denite
Plug 'Shougo/denite.nvim'
Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
" Plug 'Jagua/vim-denite-ghq'

" == lightline
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

" ==============================================================================

" == colorscheme
Plug 'lifepillar/vim-solarized8'

Plug '~/ghq/github.com/tamago324/gignores.vim'
" Plug '~/ghq/github.com/tamago324/ale'

call plug#end()



" options {{{1

augroup MyAutoCmd
    autocmd!
augroup END

let $XDG_CACHE_HOME = $LOCALAPPDATA

" TODO: shellslash とは
"set shellslash

set autoindent          " 改行時に前の行のインデントを維持する
set smartindent         " 改行時に入力された行の末尾に合わせて次の行のインデントを増減
set shiftround          " インデント幅を必ず shiftwidth の倍数にする
set hlsearch            " 検索文字列をハイライトする
set incsearch           " 文字を入力されるたびに検索を実行する
set scrolloff=5         " 5行開けてスクロールできるようにする
set visualbell t_vb=    " ビープ音すべてを無効にする
set noerrorbells        " エラーメッセージの表示時にビープ音を鳴らさない
set history=300         " 検索、置換、コマンド... の履歴を300にする(default: 50)
set showtabline=2       " 常にタブを表示
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 大文字が入らない限り、大文字小文字は区別しない
set cmdheight=2         " 2 で慣れてしまったため
set ambiwidth=double    " 記号を正しく表示
set timeoutlen=480      " マッピングの待機時間
set nrformats-=octal    " 07 で CTRL-A しても、010 にならないようにする
set signcolumn=yes      " 常に表示
set completeslash=slash " 補完時に使用する slash

" menuone:  候補が1つでも表示
" popup:    info を popup で表示
" noselect: 自動で候補を表示しない
set completeopt=menuone,noselect,noinsert

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" syntax highlight
" TODO: syntax enable と syntax on の違いを理解する
syntax enable

" plugin ファイルタイプ別プラグインを有効化
" indent ファイルタイプごとのインデントを有効化
" ファイルタイプの自動検出
filetype plugin indent on

" <BS>, <Del>, <CTRL-W>, <CTRL-U> で削除できるものを設定
"   indent  : 行頭の空白
"   eol     : 改行(行の連結が可能)
"   start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

" Windows の場合、 @* と @+ は同じになる
set clipboard=unnamed

" 余白文字を指定
"   vert: 垂直分割の区切り文字
"   fold: 折畳の余白
"   diff: diffの余白
set fillchars=vert:\ ,fold:\ ,diff:\ 

" バックアップファイル(~)を作成しない(defaut: off)
set nobackup
set nowritebackup

" スワップファイル(.swp)を作成しない
set noswapfile
set updatecount=0

" Leader
" <Leader>, <LocalLeader> を置き換える文字列
let mapleader      = '\<Space>'
let maplocalleader = ';'

" 自動でコメント開始文字を挿入しないようにする
autocmd MyAutoCmd FileType * setlocal formatoptions-=r formatoptions-=o

" 折返しのインデント
let g:vim_indent_cont = 0

" cmdline の補完設定
" ステータスラインに候補を表示
set wildmenu

" Tab 1回目:  共通部分まで補完し、候補リストを表示
" Tab 2回目~: 候補を完全に補完
set wildmode=longest:full,list:full

" cmdline から cmdline-window へ移動
set cedit=\<C-l>

" listchars (不可視文字を表示する) " {{{
set list
set listchars=
" 改行記号
set listchars+=eol:↲
" タブ
set listchars+=tab:»-
" 右が省略されている
set listchars+=extends:»
" 行をまたいでいる
set listchars+=precedes:«
" 行末のスペース
set listchars+=trail:\ 

" ハイライトを定義
function! MyHighlight() abort
    highlight Tab guifg=#999999
    highlight Eol guifg=#999999
endfunction

augroup MyHighlightListchars
    autocmd!
    autocmd ColorScheme * :call MyHighlight()
augroup END

augroup MyMatchAdd
    autocmd!
    autocmd VimEnter,WinEnter * call matchadd('Tab', '\t')
    autocmd VimEnter,WinEnter * call matchadd('Eol', '$')
augroup END


" diff の設定
" https://qiita.com/takaakikasai/items/3d4f8a4867364a46dfa3
" internal: 内部diffライブラリを設定する
" filler: 片方にしか無い行を埋める
" algorithm:histogram: histogram差分アルゴリズム を使用する
" indent-heuristic: 内部 diff のインデントヒューリスティック？を使う
set diffopt=internal,filler,algorithm:histogram,indent-heuristic

" undo {{{

" ファイル閉じても、undoできるようにする
if has('persistent_undo')
    " mkdir($LOCALAPPDATA.'/vim', 'p')
    " 存在していない場合、作成する
    if !isdirectory($LOCALAPPDATA.'/vim')
        call mkdir($LOCALAPPDATA.'/vim')
    endif
    set undodir=$LOCALAPPDATA\vim
    augroup MyAutoCmdUndofile
        autocmd!
        autocmd BufReadPre ~/* setlocal undofile
    augroup END
endif



" filetype ごとの <Tab> 設定 {{{

"   expandtab   タブ入力を複数の空白入力に置き換える
"   tabstop     実際に挿入されるスペースの数
"   shiftwidth  (auto)indent、<<,>> で使われるスペースの数
"   softtabstop <Tab> <BS> を押したときのカーソル移動の幅
autocmd MyAutoCmd FileType css          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType ctp          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType html         setlocal sw=2 sts=2 ts=4 et
autocmd MyAutoCmd FileType htmldjango   setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType javascript   setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType js           setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType json         setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType org          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType php          setlocal sw=4 sts=4 ts=4 et
autocmd MyAutoCmd FileType python       setlocal sw=4 sts=4 ts=4 et
autocmd MyAutoCmd FileType scss         setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType typescript   setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType vim          setlocal sw=4 sts=4 ts=4 et
autocmd MyAutoCmd FileType yaml         setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType markdown     setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType nim          setlocal sw=2 sts=2 ts=2 et


"
" fold 折畳 {{{
function! MyFoldText() abort " {{{
    let marker_start = strpart(&foldmarker, 0, 3)
    let line = getline(v:foldstart)
    let lcnt = v:foldend - v:foldstart

    " TODO: 4桁固定ではなく、レベルごとに設定とかできないのかな...
    let lcnt =  printf('%4d', lcnt)

    let l:foldtext = ''
    let l:foldtext.= lcnt.'L'
    let l:foldtext.= ' '
    let l:foldtext.= line
    return l:foldtext
endfunction



set foldtext=MyFoldText()
" autocmd MyAutoCmd FileType vim setlocal foldmethod=marker



" 拡張子をもとにファイルタイプを設定 {{{

autocmd MyAutoCmd BufRead,BufWinEnter *.ini set filetype=dosini
autocmd MyAutoCmd BufRead,BufWinEnter *.csv set filetype=csv
autocmd MyAutoCmd BufRead,BufWinEnter *.jsx set filetype=javascript.jsx



" from kaoriya's vimrc {{{

" マルチバイト文字の間でも改行できるようにする(autoindentが有効の場合いる)
set formatoptions+=m
" マルチバイト文字の間で行連結した時、空白を入れない
set formatoptions+=M

" $PATH に $VIM が入っていない場合、先頭に追加する
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
    let $PATH = $VIM . ';' . $PATH
endif



autocmd MyAutoCmd BufRead,BufWinEnter * setlocal nonumber

" omnifunc
" https://github.com/vim/vim/tree/master/runtime/autoload
autocmd MyAutoCmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"
" terminal settigns 
" 0  black
" 1  dark red
" 2  dark green
" 3  brown
" 4  dark blue
" 6  dark magenta
" 7  dark cyan
" 8  light grey
" 9  dark grey
" 10 red
" 11 green
" 12 yellow
" 13 blue
" 14 magenta
" 15 cyan
" 16 white

" https://github.com/shanselman/cmd-colors-solarized
" Black	    #002b36
" DarkRed	    #cb4b16
" DarkGreen	#586e75
" DarkYellow	#657b83
" DarkBlue	#839496
" DarkMagenta	#6c71c4
" DarkCyan	#93a1a1
" Gray	    #eee8d5
" DarkGray	#073642
" Red	        #dc322f
" Green	    #859900
" Yellow	    #b58900
" Blue	    #268bd2
" Magenta	    #d33682
" Cyan	    #2aa198
" White	    #fdf6e3

" https://qiita.com/yami_beta/items/97480d5e88f0d867176b
let g:terminal_ansi_colors = [
\   '#002b36',
\   '#cb4b16',
\   '#586e75',
\   '#657b83',
\   '#839496',
\   '#6c71c4',
\   '#93a1a1',
\   '#eee8d5',
\   '#073642',
\   '#dc322f',
\   '#859900',
\   '#b58900',
\   '#268bd2',
\   '#d33682',
\   '#2aa198',
\   '#fdf6e3',
\]

" すぐに quickfixwidow を開く
autocmd MyAutoCmd QuickFixCmdPost *grep* botright cwindow

function! TerminalSettings() abort
    setlocal nolist
    setlocal signcolumn=no
    setlocal cursorline
endfunction
autocmd MyAutoCmd TerminalWinOpen * call TerminalSettings()


" mapping {{{1

noremap ZZ <Nop>
noremap ZQ <Nop>
noremap <C-z> <Nop>
nnoremap ; <Nop>
" nnoremap : ;

" insert mode で細かく undo できるようにする
inoremap <CR> <C-g>u<CR>
inoremap <C-h> <Nop>
inoremap <C-h> <C-g>u<C-h>
inoremap <BS> <C-g>u<BS>
inoremap <Del> <C-g>u<Del>
inoremap <C-d> <C-g>u<Del>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>

" emacs 風
inoremap <C-a> <C-o>_
inoremap <C-e> <Nop>
inoremap <C-e> <END>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" 空行を作成する
nnoremap <Space>j o<ESC>k
nnoremap <Space>k O<ESC>j

vnoremap <silent> . :normal! .<CR>

" シンボリックリンクの先に移動する
nnoremap cd :<C-u>exec 'lcd '.resolve(expand('%:p:h'))<CR>

" 全行フォーマット
nnoremap <Space>af ggVG=

" 前にいたバッファを表示. めっちゃ好きこれ
nnoremap <C-i> 

" vimrc {{{
nnoremap <Space>vs. :<C-u>source $MYVIMRC<CR>
nnoremap <Space>v. :<C-u> call tmg#DropOrTabedit($MYVIMRC)<CR>


" 保存、終了 {{{
" 変更があったときのみ、保存される
nnoremap <silent> <Space>w :<C-u>update<CR>
nnoremap <silent> <Space>W :<C-u>update!<CR>
nnoremap <silent> <Space>q :<C-u>quit<CR>
nnoremap <silent> <Space>Q :<C-u>quit!<CR>


" window ウィンドウ操作 {{{
" s の無効化
nnoremap s <Nop>
vnoremap s <Nop>

nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L

" カレントウィンドウを新規タブで開く
nnoremap st <C-w>T
" 新規ウィンドウ
nnoremap sn :<C-u>new<CR>
nnoremap sv :<C-u>vnew<CR>

" <C-w>n,v 無効化 {{{

nnoremap <C-w><C-n> <Nop>
nnoremap <C-w>n <Nop>
nnoremap <C-w><C-v> <Nop>
nnoremap <C-w>v <Nop>



" 新規タブ
nnoremap so :<C-u>tabedit<CR>

function! NewTmpFile() abort " {{{
    let s:_ft = input('FileType: ', '', 'filetype')
    let s:tmp = tempname()
    exec 'new '.s:tmp
    exec 'set ft='.s:_ft
endfunction

" 一時ファイルの作成
nnoremap sf :<C-u>call NewTmpFile()<CR>


" 移動 {{{

" 見た目通りに移動
nnoremap j gj
nnoremap k gk

" 上下の空白に移動
" https://twitter.com/Linda_pp/status/1108692192837533696
nnoremap <C-j> }
nnoremap <C-k> {
vnoremap <C-j> }
vnoremap <C-k> {

" 行頭、行末
noremap <Space>h ^
noremap <Space>l $

nnoremap G Gzz

vnoremap <Space>l $h


" cmdline コマンドライン {{{
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>


function! s:save_global_options(...) abort
    let s:save_opts = {}
    let l:opt_names = a:000

    for l:name in l:opt_names
        execute 'let s:save_opts[l:name] = &'.l:name
    endfor
endfunction

function! s:restore_global_options() abort
    " global じゃないときはどうしよっかって感じだけど
    for [l:key, l:val] in items(s:save_opts)
        execute 'set '.l:key.'='.l:val
    endfor
endfunction

" cmdline-window コマンドラインウィンドウ {{{
function! CmdlineEnterSettings() abort
    " いらない
    nnoremap <buffer> <C-l> <Nop>
    nnoremap <buffer> <C-i> <Nop>

    " <C-p> 行補完
    inoremap <buffer> <expr> <C-p> 
    \ col('.') == 1 ?
    \ '<Esc>k' :
    \ '<C-x><C-l>'

    " 移動
    inoremap <buffer> <C-j> <Esc>j
    inoremap <buffer> <C-k> <Esc>k
    nnoremap <buffer> <C-j> j
    nnoremap <buffer> <C-k> k

    " 終了
    nnoremap <buffer> q     :<C-u>quit<CR>
    inoremap <buffer> <C-q> <Esc>:<C-u>quit<CR>
    nnoremap <buffer> <C-q> :<C-u>quit<CR>

    " cmdline に持っていく
    inoremap <buffer> <C-l> <C-c>
    nnoremap <buffer> <C-l> <C-c>
    inoremap <buffer> <CR>  <C-c><CR>

    " <C-c><C-e> でcmdline-win から抜ける
    nnoremap <buffer> <C-o> <C-c><C-e><C-u>Denite command_history<CR>
    inoremap <buffer> <C-o> <C-c><C-e><C-u>Denite command_history<CR>

    " global options
    call s:save_global_options(
    \ 'backspace',
    \ 'completeopt'
    \)
    " insertモード開始位置より左を削除できるようにする
    set backspace=start
    set completeopt=menu

    " local options
    setlocal signcolumn=no
    setlocal nonumber

    " insertモードで開始
    startinsert!
endfunction

function! CmdlineLeaveSettings() abort
    call s:restore_global_options()
endfunction

autocmd MyAutoCmd CmdwinEnter * call CmdlineEnterSettings()
autocmd MyAutoCmd CmdwinLeave * call CmdlineLeaveSettings()

" すぐに cmdline-window に入る
nnoremap : q:



" yank コピー {{{

" カーソルから行末までコピー
nnoremap Y y$

" 全行コピー
nnoremap <Space>ay :<C-u>%y<CR>



" paste 貼り付け {{{

" 最後にコピーしたテキストを貼り付ける
" 選択し、貼り付けると、 "* が更新されてしまうため
nnoremap <Space>p "0p
vnoremap <Space>p "0p



" delete 削除 {{{

" 1文字削除の場合、無名レジスタを汚さないようにする
nnoremap x "_x



" マクロ {{{

" Q でマクロを再実行
nnoremap Q @@

" 選択範囲で マクロ繰り返し
vnoremap <silent> @q :normal! @q<CR>


" タブ {{{

nnoremap tg <Nop>
nnoremap gt <Nop>
nnoremap <C-l> gt
nnoremap <C-h> gT



" set filetype {{{
function! s:set_filetype(ft) abort
    exec 'set ft='.a:ft
endfunction
command! -nargs=1 -complete=filetype FileType call s:set_filetype(<f-args>)
nnoremap <Space>ft :<C-u>FileType 


" terminal {{{
" prefix
set termwinkey=<C-w>

tnoremap <C-r> <Nop>
execute 'tnoremap <C-r><C-r> ' . &termwinkey . '"*'
execute 'tnoremap ' . '&termwinkey' . 'p <Nop>'
" C-[ でTerminal Job モードへ移行
tnoremap <Esc> <C-\><C-n>



" search 検索 {{{

" ハイライトを消去
nnoremap <silent> <Esc><Esc> :noh<CR>

" / => \/ とする
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

" :help magic を参照
nnoremap / /\v
vnoremap / /\v

" " @*(クリップボード)に入っている文字列で検索
" nnoremap <Space>/ /<C-R>*<CR>

" 選択範囲内の検索
" 選択しているところで、一旦抜けて(<Esc>)、/%Vで(gvで直前に選択した範囲を検索している)
" :help \%V に詳細がある
vnoremap / <Esc>/\%V

" クリップボード内の内容で検索
" TODO エスケープ必要なものはエスケープする '\' => '\\' みたいな
nnoremap <Space>/ /\V<C-R>*<CR>
" 選択文字列を検索
vnoremap <Space>/ "hy/\V<C-R>h<CR>

" 中央にせずに、検索
" :let-@{レジスタ名} でレジスタに値を代入できる
"   @/ は検索レジスタということ
" b と <bs> 単語の後ろに戻る
" 検索結果レジスタに入っている文字で検索する(/だけだと、@/の値が参照されるため)
nnoremap <silent> * :<C-u>let @/ = '\<' . expand('<cword>') . '\>'<cr>b<bs>/<cr>


" substitute replace 置換 {{{

nnoremap s/ :<C-u>%s///g<Left><Left>
vnoremap <Space>s/ :s///g<Left><Left>

" 選択文字列を指定の文字で置換
" 1. `"hy`で選択した範囲の文字列を`h`レジスタに格納
" 2. `:%s/\V<C-R>h//g`で`h`レジスタにある文字列を検索文字として挿入
" 3. `<left><left>`で置換後の文字列を入力しやすいようにしている
" vnoremap <C-R>s "hy:%s/\v(<C-R>h)//g<left><left>
vnoremap <C-R>      "hy:%s/\v(<C-R>h)//g<left><left>
vnoremap <C-R><C-d> "hy:%s/\V\(<C-R>h\)//g<left><left>
nnoremap <C-R><C-d> v"hy:%s/\V\(<C-R>h\)//g<left><left>



" diff {{{
nnoremap          <Space>dt :<C-u>windo diffthis<CR>
nnoremap          <Space>do :<C-u>windo diffoff<CR>
nnoremap <silent> <Space>dp :diffput<CR>
vnoremap <silent> <Space>dp :diffput<CR>
nnoremap <silent> <Space>dg :diffget<CR>
vnoremap <silent> <Space>dg :diffget<CR>
" 更新
" nnoremap <Space>du diffupdate


" toggle option {{{
function! MapToggleOption(key, opt) abort
    exec 'nnoremap <silent> '.a:key.' :<C-u>setlocal '.a:opt.'!<CR> :echo "toggle '.a:opt.'"<CR>'
endfunction
" :help set-!
call MapToggleOption('<F2>', 'wrap')
call MapToggleOption('<F3>', 'readonly')


" help {{{

" nnoremap <A-h> :<C-u>help 
" helpをqで閉じる
autocmd MyAutoCmd FileType help nnoremap <buffer> q <C-w>c

" 選択している文字列をhelpで引く
vnoremap <A-h> "hy:help <C-R>h<CR>

nnoremap <A-h> :<C-u>h 

" 無効化
vnoremap K <Nop>


" commands {{{1

" terminal {{{

function! TermStartClose(...) abort
    exec 'botright term ++close ++rows=30' join(a:000)
endfunction

command! -nargs=* Term call TermStartClose(<f-args>)
if has('win32')
    command! -nargs=* Cmd call TermStartClose(<f-args>)
endif

" bash.exeの起動
command! Bash call TermStartClose('bash.exe')

" nyagos
if !executable('nyagos')
    let $PATH = $PATH.';'.expand('~/app/nyagos')
endif
command! Nyagos call TermStartClose('nyagos.exe')

" クリップボード貼り付け
inoremap <C-r><C-r> <C-r>*
cnoremap <C-r><C-r> <C-r>*


" quickfix
function! QfSettings() abort
    nnoremap <buffer>         p         <CR>zz<C-w>p
    nnoremap <buffer><silent> q         :<C-u>quit<CR>
    nnoremap <buffer><silent> <C-q>     :<C-u>quit<CR>
    setlocal winheight=20

    nnoremap <buffer><silent> j  j
    nnoremap <buffer><silent> k  k
    nnoremap <buffer><silent> gj gj
    nnoremap <buffer><silent> gk gk
endfunction

autocmd! MyAutoCmd FileType qf call QfSettings()




" ==============================================================================
" 便利なコマンドたち

nnoremap <Space>;h :<C-u>FavoriteHelps<CR>
nnoremap <Space>;f :<C-u>FnamemodsPopup<CR>

command! HereOpen call execute('!start %:p:h', "silent")

if executable('js-sqlformat')
  command! -range=% SQLFmt <line1>,<line2>!js-sqlformat
endif

if executable('jq')
    command -range=% Jq <line1>,<line2>!jq
endif


function! s:get_maxlen(list) abort " 
    let maxlen = 0
    for val in a:list
        let length = len(val)
        if maxlen < length
            let maxlen = length
        endif
    endfor
    return maxlen
endfunction


" ------------------------------------------------------------------------------
" カレントファイルのパスをいろんな形式で yank 
command! FnamemodsPopup call s:yank_fnamemods_popup()

" TODO: コマンドでパスの変換できるようにする
" wsl wslpath -a 'xxxxx/xxxxx/xxx'

let s:modifiers = []

" %s がファイルパスに置き換わる
let s:fmod_fmts = {
\   'mods': [
\      ':p:h',
\      ':p:~',
\      ':p',
\      ':p:r',
\      ':t:r',
\      ':p:t',
\      ':e',
\   ],
\   'cmds': [
\       ['wslpath', 'wsl wslpath -a "%s"'],
\   ]
\}


" 形式を設定
" let s:modifiers = [
"     \ ':p',
"     \ ':p:.',
"     \ ':p:~',
"     \ ':h',
"     \ ':p:h',
"     \ ':p:h:h',
"     \ ':t',
"     \ ':p:t',
"     \ ':r',
"     \ ':p:r',
"     \ ':t:r',
"     \ ':e',
"     \]
let s:modifiers = [
    \ ':p:h',
    \ ':p:~',
    \ ':p',
    \ ':p:r',
    \ ':t:r',
    \ ':p:t',
    \ ':e',
    \]

function! s:yank_fnamemods_popup() abort " 
    let fnmods = s:create_fnmods_list(expand('%:p'), s:modifiers)

    let c_fnmods = deepcopy(fnmods)
    let disp_list = map(c_fnmods, {key, val -> val.mods.' '.val.path })

    let popctx = {
        \ 'fnmods': fnmods
        \}

    let opts = {
        \ 'callback': function('s:fnmods_handler', [popctx]),
        \ 'title': 'File modifiers to yank',
        \ 'padding': [0, 1, 0, 1],
        \}

    " popup_menu: リストから選択する popup window
    "             callback の第2引数に選択行のindexを渡す(1始まり)
    let popctx.id = popup_menu(disp_list, opts)

endfunction
"}}}

function! s:fnmods_handler(popctx, winid, idx) abort " 
    " キャンセル時、-1が渡されるため
    if a:idx != -1
        " idx は 1 始まりのため -1 する
        let fname = a:popctx.fnmods[a:idx-1].path
        call setreg('+', trim(fname))
        echo 'yanked'
    endif
endfunction


function! s:create_fnmods_list(fullpath, fnmods) abort " 
    let maxlen = s:get_maxlen(a:fnmods)

    let fnmods_list = []

    for mods in a:fnmods
        let path = expand('%'.mods)

        " パスの位置を合わせる
        if mods ==# ':e'
            " :e
            let space_num = strridx(a:fullpath, path)
        elseif stridx(mods, '~') != -1
            " :~
            let space_num = len($HOME) -1
        else
            let space_num = stridx(a:fullpath, path)
        endif

        " mods, path の調整
        let just_mods = printf('%-'.maxlen.'s', mods)
        let just_path = repeat(' ', space_num).' '.path

        call add(fnmods_list, {
            \ 'mods': just_mods,
            \ 'path': just_path,
            \})
    endfor

    return fnmods_list
endfunction
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" よく使う help へのジャンプ 
command! FavoriteHelps call <SID>favorite_helps()

" 順序を保持するため、リスト
let s:fav_helps = []

call add(s:fav_helps, ['function-list', '関数一覧'])
call add(s:fav_helps, ['user-commands', 'command の書き方'])
call add(s:fav_helps, ['autocmd-events', 'autocmd 一覧'])
call add(s:fav_helps, ['E500', '<cword> とか <afile> とか'])
call add(s:fav_helps, ['usr_41', 'Vim script 基本'])
call add(s:fav_helps, ['pattern-overview', '正規表現'])
call add(s:fav_helps, ['eval', 'Vim script [tips]'])
call add(s:fav_helps, ['ex-cmd-index', '":"のコマンド'])
call add(s:fav_helps, ['filename-modifiers', ':p とか :h とか'])
" call add(s:fav_helps, ['doc-file-list', 'home'])
" call add(s:fav_helps, ['functions', ''])
" call add(s:fav_helps, ['help-summary', ''])
" call add(s:fav_helps, ['index', '各モードのマッピング'])
" call add(s:fav_helps, ['quickref', ''])

" TODO: よくアクセスする順に変更したい
" let s:fav_help_history_path = expand('~/_fav_help_history')

" help menus 作成 
function! s:help_create_text_list(list) abort
    let help_items = []
    " 最大桁数を取得
    let max_len = s:get_maxlen(map(deepcopy(a:list), 'v:val[0]'))
    for [k, v] in a:list
        " 左揃えにする
        call add(help_items, printf('%-'.max_len.'s', k).' '.v)
    endfor
    return help_items
endfunction


function! s:help_favorite_handler(winid, idx) abort " 
    " キャンセル時、-1が渡されるため
    if a:idx != -1
        " ウィンドウ関数から取得
        let l:items = getwinvar(a:winid, 'items', [])
        " idx は 1 始まりのため -1 する
        exec 'help '.l:items[a:idx-1][0]
    endif
endfunction


function! s:favorite_helps() abort " 
    let l:winid = popup_menu(s:help_create_text_list(s:fav_helps), {
    \   'callback': function('s:help_favorite_handler'),
    \   'title': 'Favorite helps',
    \   'padding': [0, 1, 0, 1],
    \})
    " window変数を使う
    call setwinvar(l:winid, 'items', map(s:fav_helps, 'v:val'))
endfunction
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" カーソル下の highlight 情報を取得 (name のみ) 
command! SyntaxInfo call GetSynInfo()

" http://cohama.hateblo.jp/entry/2013/08/11/020849
function! s:get_syn_id(transparent) abort
    " synID() で 構文ID が取得できる
    " XXX: 構文ID とは?
    " trans に1を渡しているため、実際に表示されている文字が評価対象
    let synid = synID(line('.'), col('.'), 1)
    if a:transparent
        " 数値が返される
        " XXX: なんの数値なのかはわからない...
        " :hi link の参照先の情報を取得？
        return synIDtrans(synid)
    else
        return synid
    endif
endfunction

function! s:get_syn_attr(synid) abort
    let name = synIDattr(a:synid, 'name')
    return { 'name': name }
endfunction

function! GetSynInfo() abort
    let base_syn = s:get_syn_attr(s:get_syn_id(0))
    echo 'name: ' . base_syn.name

    let linked_syn = s:get_syn_attr(s:get_syn_id(1))
    echo 'link to'
    echo 'name: ' . linked_syn.name
endfunction
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" packages 機能
command! -nargs=+ PackGet call s:packget(<f-args>)
command! -nargs=1 -complete=packadd PackAdd call s:packadd(<f-args>)
command! -nargs=1 -complete=packadd PackHelptags call s:packhelptags(<f-args>)

" 末尾の '/' を取り除くため、 :p:h とする
let s:pack_base_dir = tr(fnamemodify('~/vimfiles/pack/plugs/opt', ':p'), "\\", '/')
let s:sep = has('win32') ? "\\" : '/'

function! s:packadd(plugin_name) abort
    if index(s:packages(), a:plugin_name) ==# -1
        " echomsg に ErrorMsg ハイライトをつける
        echohl ErrorMsg
        echomsg 'Not found plugin. '.a:plugin_name
        echohl None
        return
    endif
    execute 'packadd '.a:plugin_name
endfunction

function! s:packages() abort
    let l:result = []
    for path in split(globpath(&packpath, '/pack/*/opt/*'))
        if isdirectory(path)
            let dirname = path[strridx(path, s:sep)+1:]
            call add(l:result, dirname)
        endif
    endfor
    return l:result
endfunction

function! s:packget_cb(job, status) abort
    echomsg job_status(a:job)
endfunction

function! s:add_end_slash(path) abort
    if a:path =~# '/$'
        let l:result = a:path
    else
        let l:result = a:path.'/'
    endif
    return l:result
endfunction

function! s:fix_url(url) abort
    return a:url =~# '^http' ?
    \   a:url :
    \   'https://github.com/'.a:url
endfunction

function! s:packget(url, ...) abort
    let l:base = s:add_end_slash(s:pack_base_dir)

    " 引数指定されていたら、その名前のディレクトリに作成する
    let l:plug_name = a:0 ==# 0 ?
    \   fnamemodify(a:url, ':t:r') :
    \   a:1

    let l:dst = l:base . l:plug_name

    if isdirectory(l:dst)
        echohl ErrorMsg
        echomsg "Already exists. '".l:plug_name."'"
        echohl None
        return
    endif

    let l:cmd = 'git clone ' . s:fix_url(a:url) . ' '  . l:dst

    execute 'botright term ++rows=15 '.l:cmd
endfunction

" これやっても意味ない？
" :help で検索聞いてなさそう?
function! s:packhelptags(plugin_name) abort
    let l:base = s:add_end_slash(s:pack_base_dir)
    if !isdirectory(l:base . a:plugin_name)
        echohl ErrorMsg
        echomsg 'Not found plugin. '.a:plugin_name
        echohl None
        return
    endif
    execute 'helptags ' . l:base. a:plugin_name . '/doc'
endfunction

" pack/plugs/opt の中の help を検索
" runtimepath 内の doc/ も help で引ける
"  -> packadd したもののhelpを引くには、runtimepath に含める必要がある？
" command! -nargs=1 PackHelp -complete=customlist,func call s:packhelp(<f-args>)
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" fileformat を変換
" https://qiita.com/gillax/items/3dad7318662d29b3f6d1
command! FFDosUnix call FFDosUnix()
function! FFDosUnix() abort
    edit ++ff=unix
    normal! :<C-u>%s/\r//g
endfunction
" ------------------------------------------------------------------------------


" ==============================================================================
" ******************************************************************************
" plugins
" ******************************************************************************
" ==============================================================================


" ==============================================================================
" thinca/quickrun 

let g:quickrun_config = {}

" Windows の場合、コマンドの出力は cp932 のため
" (vimとかは内部で実行しているため、utf-8にする必要がある)
" hook/output_encode/encoding で encoding の from:to を指定できる
let g:quickrun_config = {
    \   '_': {
    \       'runner': 'job',
    \       'hook/output_encode/encoding': 'cp932',
    \       'outputter/buffer/close_on_empty': 1,
    \   },
    \   'vim': {
    \       'hook/output_encode/encoding': '&fileencoding',
    \   },
    \   'nim': {
    \       'hook/output_encode/encoding': '&fileencoding',
    \   },
    \}

nmap <Space>rr <Plug>(quickrun)


" ==============================================================================
" glidenote/memolist 

let g:memolist_path = '~/memo'

map <Space>mn  :<C-u>MemoNew<CR>
" map <Space>ml  :<C-u>MemoList<CR>
" map <Space>mg  :<C-u>MemoGrep<CR>


" ==============================================================================
" dhruvasagar/vim-table-mode 

" https://7me.oji.0j0.jp/2018/vim-table-mode-memo.html

let g:table_mode_map_prefix = '<Space>t'
" markdownに対応するため
let g:table_mode_corner='|'
" デフォルトのmappingを無効化
let g:table_mode_disable_mappings = 1

" 自動で整える
let g:table_mode_auto_align = 1
" table-modeのトグル
let g:table_mode_toggle_map = 'm'

nnoremap <F4> :<C-u>%Tableize<CR>


" ==============================================================================
" roxma/nvim-yarp

let g:python3_host_prog = $LOCALAPPDATA.'/Programs/Python/Python37/python'
let $NVIM_PYTHON_LOG_FILE = expand('~/tmp/nvim_log')
let $NVIM_PYTHON_LOG_LEVEL = 'DEBUG'


" ==============================================================================
" roxma/vim-hug-neovim-rpc 

set pyxversion=3


" ==============================================================================
" Yggdroot/indentLine 

" インデントつけないバッファの名前
let g:indentLine_bufNameExclude = ['_.*']
let g:indentLine_bufTypeExclude = ['terminal']
let g:indentLine_fileTypeExclude = ['defx', 'calendar', 'help']
let g:indentLine_char = '|'


" ==============================================================================
" t9md/vim-quickhl 

nmap <Space>mm <Plug>(quickhl-manual-this)
xmap <Space>mm <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)


" ==============================================================================
" tyru/open-browser.vim 

" netrw の gx のマッピングをさせない
let g:netrw_nogx = 1

nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nnoremap <A-o><A-o> :<C-u>OpenBrowserSearch -duckduckgo 
nnoremap <A-o><A-n> :<C-u>OpenBrowserSearch -

" 追加
let g:openbrowser_search_engines = {
\   'dev': 'http://devdocs.io/#q={query}',
\   'gh': 'http://github.com/search?q={query}',
\   'duckduckgo': 'http://duckduckgo.com/?q={query}',
\   'memo': 'https://scrapbox.io/tamago324-05149866/search/page?q={query}',
\   'vim': 'https://scrapbox.io/vimemo/search/page?q={query}',
\   'awesome': 'https://vimawesome.com/?q={query}'
\}


" ==============================================================================
" ambv/black 

" :Blackでの1行を設定
let g:black_linelength = 99


" ==============================================================================
" simeji/winresizer 

let g:winresizer_start_key='ss'


" ==============================================================================
" davidhalter/jedi-vim 

" GitHub の Readme も参考になる
" https://github.com/davidhalter/jedi-vim

" augroup MyAutoCmdJedi
"     autocmd!
"     autocmd FileType python setlocal omnifunc=jedi#completions
"     " プレビューウィンドウの表示をしない
"     " autocmd FileType python setlocal completeopt-=preview
"     " https://github.com/davidhalter/jedi-vim/issues/217#issuecomment-163916534
"     " autocmd FileType python call jedi#configure_call_signatures()
" augroup END

" " completeopt の自動設定をしない
" let g:jedi#auto_vim_configuration = 0
" " jedi の補完を OFF (vim-lsp で行うため)
" let g:jedi#completions_enabled = 0
" " from xxx<Space>import とする
" let g:jedi#smart_auto_mappings = 1

" " jedi のデフォルト設定
" let g:jedi#auto_initialization = 1
" " signature をコマンドラインに表示
" let g:jedi#show_call_signatures = '2'

" mapping
" let g:jedi#goto_command             = '<Space>d'
" let g:jedi#goto_assignments_command = '<Space>g'
" let g:jedi#documentation_command    = 'K'
" let g:jedi#usages_command           = '<Space>n'
" let g:jedi#rename_command           = '<Space>r'
" let g:jedi#goto_definitions_command = ''


" ==============================================================================
" w0rp/ale 

" Linterのみのためにaleを使用する
let g:ale_linters = {
    \ 'python': [
    \   'flake8', 'mypy'
    \ ],
    \ 'vim': [
    \   'vint'
    \ ],
    \ 'nim': [
    \   'nimcheck'
    \ ],
    \ }

let g:ale_fixers = {
\   'nim': 'nimpretty'
\}

let g:ale_enabled = 1
" テキスト変更時にlintを実行しない
let g:ale_lint_on_text_changed = 'normal'
" 読み込み時には実行しない
let g:ale_lint_on_enter = 0
" insertモードから抜けたら実行する
let g:ale_lint_on_insert_leave = 1
" mypyのoption => https://mypy.readthedocs.io/en/latest/command_line.html
let g:ale_python_mypy_options = '--ignore-missing-imports --follow-imports=skip --namespace-packages'

" blackに合わせる
let g:ale_python_flake8_options = '--max-line-length='.g:black_linelength

" Default (E121,E123,E126,E226,E24,E704,W503,W504)
" E101: スペースとタブの両方が使われてますよー(文字列に含まれてるかも)
" E501: １行の長さが超えてしまうのは Black で修正するから、無視してOK
" F403: * やめてねー
" F405: 定義されていないですよー(めんどくさいときとか from a import * ってするから)
" W191: タブが使われてますよー(文字列に含まれてるかも)
" W503: 改行の前に演算子をおいてねー
let g:ale_python_flake8_options .= ' '.'--ignore=E121,E123,E126,E226,E24,E704,W503,W504,F405,W191,E101,F403,E501'

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '=='

nmap <silent> <A-j> <Plug>(ale_next_wrap_error)
nmap <silent> <A-k> <Plug>(ale_previous_wrap_error)
nmap <silent> <A-u> <Plug>(ale_next_wrap_warning)
nmap <silent> <A-i> <Plug>(ale_previous_wrap_warning)


" ==============================================================================
" Shougo/neosnippet.vim 

" C-L でsunippet を選択開始
imap <C-l> <Plug>(neosnippet_expand_or_jump)
smap <C-l> <Plug>(neosnippet_expand_or_jump)

" C-L で次の項目に移動
xmap <C-l> <Plug>(neosnippet_expand_target)

" TODO: 理解する
" 非表示文字をどうするか？
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" 自分の snippets
let g:neosnippet#snippets_directory = expand('~/vimfiles/snippets')

" }}}

" ==============================================================================
" ctrlpvim/ctrlp.vim 

" mapping
" nnoremap <Space>ff :<C-u>CtrlPCurFile<CR>
nnoremap <Space>fj :<C-u>CtrlPBuffer<CR>
nnoremap <Space>fq :<C-u>CtrlPGhq<CR>
nnoremap <Space>fk :<C-u>CtrlPMixed<CR>
" nnoremap <Space>fm :<C-u>CtrlPMRUFiles<CR>

nnoremap <Space>fl :<C-u>CtrlPLine %<CR>
" nnoremap <Space>fd :<C-u>CtrlPDir resolve(expnad('%:p:h'))<CR>

nnoremap <Space>ml :<C-u>CtrlP ~/memo<CR>

" マッピング
let g:ctrlp_prompt_mappings = {
    \ 'ToggleByFname()':      ['<C-g>'],
    \ 'PrtSelectMove("u")':   ['<A-u>'],
    \ 'PrtSelectMove("d")':   ['<A-d>'],
    \ 'PrtClearCache()':      ['<F5>'],
    \ 'AcceptSelection("e")': ['<Cr>'],
    \ 'AcceptSelection("h")': ['<C-s>', '<C-cr>'],
    \ 'AcceptSelection("t")': ['<C-t>'],
    \ 'AcceptSelection("v")': ['<C-v>'],
    \ 'PrtExpandDir()':       ['<Tab>'],
    \ 'PrtCurStart()':        ['<C-a>'],
    \ 'PrtCurEnd()':          ['<C-e>'],
    \ 'PrtCurLeft()':         ['<C-b>'],
    \ 'PrtCurRight()':        ['<C-f>'],
    \ 'PrtBS()':              ['<C-h>', '<Bs>'],
    \ 'PrtDelete()':          ['<C-d>'],
    \ 'PrtDeleteWord()':      ['<C-w>'],
    \ 'PrtClear()':           ['<C-u>'],
    \ 'PrtSelectMove("j")':   ['<C-j>'],
    \ 'PrtSelectMove("k")':   ['<C-k>'],
    \ 'PrtHistory(-1)':       ['<C-n>'],
    \ 'PrtHistory(1)':        ['<C-p>'],
    \ 'PrtExit()':            ['<Esc>', '<C-c>', '<C-q>'],
    \ 'PrtInsert("c")':       ['<C-o>'],
    \ 'PrtInsert()':          ['<C-r>'],
    \ 'ToggleRegex()':        [],
    \ 'PrtSelectMove("t")':   [],
    \ 'PrtSelectMove("b")':   [],
    \ 'ToggleFocus()':        [],
    \ 'PrtDeleteEnt()':       [],
    \ 'CreateNewFile()':      [],
    \ 'MarkToOpen()':         [],
    \ 'OpenMulti()':          [],
    \ 'ToggleType(1)':        [],
    \ 'ToggleType(-1)':       [],
    \ }

    " \ 'ToggleType(1)':        ['<C-o>'],
    " \ 'ToggleType(-1)':       ['<C-i>'],

    " \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
    " \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
    " \ 'ToggleFocus()':        ['<s-tab>'],
    " \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
    " \ 'PrtInsert()':          ['<c-\>'],
    " \ 'PrtDeleteEnt()':       ['<F7>'],
    " \ 'CreateNewFile()':      ['<c-y>'],
    " \ 'MarkToOpen()':         ['<c-z>'],
    " \ 'OpenMulti()':          ['<c-o>'],

" match window 50件表示(scroll 可能にする)
let g:ctrlp_match_window = 'order:tbb,max:20,results:200'

" ctrlp-ghq 
" <CR> で実行するコマンド
let ctrlp_ghq_default_action = 'tabe | Defx'

" .git を上の方へ探したいな...
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" 非同期で実行
let g:ctrlp_user_command_async = 1

" 除くディレクトリ
" let g:ctrlp_custom_ignore = '\v[\/](.venv|.git|.mypy_cache|.pytest_cache|.*.egg-info)$'

" 終了時に、キャッシュを削除しない
let g:ctrlp_clear_cache_on_exit = 0

" <C-p> で起動しないようにする
let g:ctrlp_map = ''

" " statusline
" " XXX: prog ってなんだろう
" let g:ctrlp_status_func = {
"     \ 'main': 'CtrlPStatusMain',
"     \ 'prog': 'CtrlPStatusProg',
"     \}
"
" function! CtrlPStatusMain(focus, byfname, regex, prev, item, next, marked) abort
"     let l:byfname = a:byfname ==# 'file' ? 'f' : 'p'
"     let l:regex = a:regex ? 'regex mode' : ''
"
"     return printf(' %s %s %s', l:byfname, a:item, l:regex)
" endfunction
"
" function! CtrlPStatusProg(str) abort
"     return a:str
" endfunction

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }


" ==============================================================================
" vim-lsp 

" デバッグ
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

augroup MyLsp
    autocmd!
    if executable('pyls')
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': { servier_info -> ['pyls'] },
            \ 'whitelist': ['python'],
            \ 'workspace_config': {
            \   'pyls': {
            \       'plugins': {
            \           'jedi_definition': {
            \               'follow_imports': 1, 
            \               'follow_builtin_imports': 1,
            \           },
            \   }
            \ }}
            \})
        autocmd FileType python call s:configure_lsp()
    endif
    if executable('nimlsp')
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'nimlsp',
        \   'cmd': {server_info->[&shell, &shellcmdflag, 'nimlsp C:\\nim\\nim-1.0.0']},
        \   'whitelist': ['nim'],
        \})
        autocmd FileType nim call s:configure_lsp()
    endif
augroup END

function! s:configure_lsp() abort
    " omnifunc を設定
    setlocal omnifunc=lsp#complete

    nnoremap <buffer> <C-]> :<C-u>LspDefinition<CR>
    nnoremap <buffer> gd    :<C-u>LspDefinition<CR>
    nnoremap <buffer> gu    :<C-u>LspReferences<CR>
    nnoremap <buffer> K     :<C-u>LspHover<CR>

    " nnoremap <buffer> gj    :<C-u>LspNextError<CR>
    " nnoremap <buffer> gk    :<C-u>LspPreviousError<CR>
    nnoremap <buffer> gh    :<C-u>LspCodeAction<CR>

endfunction
"" sign の表示を無効化 ( mint で行うため )
let g:lsp_diagnostics_enabled = 0


" ==============================================================================
" jremmen/vim-ripgrep 

nnoremap <Space>rg :<C-u>Rg 
" nnoremap <Space>fgr :<C-u>RgRoot 

" let g:rg_format = ''


" " ==============================================================================
" " othree/javascript-libraries-syntax.vim 
"
" function! s:javascript_libraries_syntax() abort
"     let g:use_javascript_libs = 'vue'
"     let b:javascript_lib_use_vue = 1
" endfunction
"
" autocmd MyAutoCmd Filetype javascript,javascript.jsx call s:javascript_libraries_syntax()
"
" 
" " ==============================================================================
" " liuchengxu/clap 
"
" " nnoremap <Space>fl :<C-u>Clap blines<CR>
" " nnoremap <Space>fj :<C-u>Clap buffers<CR>
" nnoremap <Space>fh :<C-u>Clap help<CR>
" nnoremap <Space>f; :<C-u>Clap command_history<CR>
" " nnoremap <Space>ff :<C-u>Clap files<CR>
"
" 

" " ==============================================================================
" " mattn/efm-langserver 
"
" " sign
" let g:lsp_signs_error = {'text': g:tamago324_sign_error}
" let g:lsp_signs_warning = {'text': g:tamago324_sign_warn}
"
" " カーソル下の lint 結果を表示
" let g:lsp_diagnostics_echo_cursor = 1
"

" ==============================================================================
" posva/vim-vue 
autocmd MyAutoCmd FileType vue syntax sync fromstart


" ==============================================================================
" LeafCage/yankround.vim 

nmap p      <Plug>(yankround-p)
xmap p      <Plug>(yankround-p)
nmap P      <Plug>(yankround-P)
nmap gp     <Plug>(yankround-gp)
xmap gp     <Plug>(yankround-gp)
nmap gP     <Plug>(yankround-gP)
nmap <C-p>  <Plug>(yankround-prev)
nmap <C-n>  <Plug>(yankround-next)

let g:yankround_use_region_hl = 1


" ==============================================================================
" kana/vim-textobj-user 

" b
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)


" ==============================================================================
" machakann/vim-highlightedyank 

" なんとなくちょうどいい
let g:highlightedyank_highlight_duration = 70


" ==============================================================================
" ctrlp-lanchear
" let g:ctrlp_launcher_file = '~/vimfiles/rc/plugins/ctrlp-launcher'


" ==============================================================================
" defx

augroup MyDefx
    autocmd!
    autocmd FileType defx call s:defx_my_settings()
augroup END

function! DefxTcdDown(ctx) abort
    if defx#is_directory()
        execute 'tcd '.a:ctx.targets[0]
        call defx#call_action('open')
    endif
endfunction

function! DefxTcdUp(ctx) abort
    call defx#call_action('cd', ['..'])
    execute 'tcd '.fnamemodify(a:ctx.cwd, ':p:h:h')
endfunction


function! s:defx_my_settings() abort

    setlocal cursorline
    setlocal statusline=\ 

    " file 作成
    nnoremap <silent><buffer><expr> N
    \ defx#do_action('new_file')

    " copy
    nnoremap <silent><buffer><expr> c
    \ defx#do_action('copy')

    " move
    nnoremap <silent><buffer><expr> m
    \ defx#do_action('move')

    " paste
    nnoremap <silent><buffer><expr> p
    \ defx#do_action('paste')

    " rename
    nnoremap <silent><buffer><expr> r
    \ defx#do_action('rename')

    nnoremap <silent><buffer><expr> <CR>
    \ defx#do_action('drop')

    " 階層を下に移動
    nnoremap <silent><buffer><expr> l
    \ defx#do_action('call', 'DefxTcdDown')

    " 階層を上に移動
    nnoremap <silent><buffer><expr> u
    \ defx#do_action('call', 'DefxTcdUp')

    " treeの開閉
    nnoremap <silent><buffer><expr> o
    \ defx#is_directory() ?
    \ defx#do_action('open_or_close_tree') :
    \ defx#do_action('drop')

    " 垂直分割で開く
    nnoremap <silent><buffer><expr> <C-i>
    \ defx#do_action('drop', 'vsplit')

    " 分割で開く
    nnoremap <silent><buffer><expr> <C-s>
    \ defx#do_action('drop', 'split')

    " タブで開く
    nnoremap <silent><buffer><expr> t
    \ defx#do_action('open', 'tabnew')

    nnoremap <silent><buffer><expr> cd
    \ defx#do_action('change_vim_cwd')

    nnoremap <silent><buffer><expr> I
    \ defx#do_action('toggle_ignored_files')

    nnoremap <silent><buffer><expr> R
    \ defx#do_action('redraw')

    " システムで設定しているプログラムで実行する
    nnoremap <silent><buffer><expr> x
    \ defx#do_action('execute_system')

    nnoremap <silent><buffer> H
    \ :<C-u>HereOpen<CR>

    nnoremap <silent><buffer> B
    \ :<C-u>BookmarkList<CR>

    " " trashboxに入れる(削除)、https://pypi.org/project/Send2Trash/ を使う
    " " pip install send2trash
    " nnoremap <silent><buffer><expr> d
    " \ defx#do_action('remove_trash')

    " " directory 作成
    " nnoremap <silent><buffer><expr> K
    " \ defx#do_action('new_directory')
    " nnoremap <silent><buffer><expr> q
    " \ defx#do_action('quit')
    " " ファイルパスのコピー
    " nnoremap <silent><buffer><expr> yy
    " \ defx#do_action('yank_path')
    " " 再帰で開く
    " nnoremap <silent><buffer><expr> O
    " \ defx#do_action('open_tree_recursive')
    " nnoremap <silent><buffer><expr> ~
    " \ defx#do_action('cd')
    " nnoremap <silent><buffer><expr> \
    " \ defx#do_action('cd', getcwd())
    " " バッファの再描画
    " nnoremap <silent><buffer><expr> <C-l>
    " nnoremap <silent><buffer><expr> !
    " \ defx#do_action('execute_command')
    " nnoremap <silent><buffer><expr> M
    " \ defx#do_action('new_multiple_files')
    " nnoremap <silent><buffer><expr> C
    " \ defx#do_action('toggle_columns', 'mark:filename:type:size:time')
    " nnoremap <silent><buffer><expr> S
    " \ defx#do_action('toggle_sort', 'Time')
    " " ignoreするファイルの状態をトグルする
    " nnoremap <silent><buffer><expr> >
    " \ defx#do_action('toggle_ignored_files')
    " " １つ前のアクションを実行
    " nnoremap <silent><buffer><expr> .
    " \ defx#do_action('repeat')
    " nnoremap <silent><buffer><expr> <Space>
    " \ defx#do_action('toggle_select') . 'j'
    " nnoremap <silent><buffer><expr> *
    " \ defx#do_action('toggle_select_all')
    " " ファイル名表示
    " nnoremap <silent><buffer><expr> <C-g>
    " \ defx#do_action('print')
    " nnoremap <silent><buffer><expr> <Tab> winnr('$') != 1 ?
    " \ ':<C-u>wincmd w<CR>' :
    " \ ':<C-u>Defx -buffer-name=temp -split=vertical<CR>'
    " プレビューウィンドウで表示
    " nnoremap <silent><buffer><expr> P
    " \ defx#do_action('open', 'pedit')
    " nnoremap <silent><buffer><expr> se
    " \ defx#do_action('save_session')
    " nnoremap <silent><buffer><expr> sl
    " \ defx#do_action('load_session')

    " nnoremap <silent><buffer><expr> j
    " \ line('.') == line('$') ? 'gg' : 'j'
    " nnoremap <silent><buffer><expr> k
    " \ line('.') == 1 ? 'G' : 'k'

    command! -buffer BAdd call defx#call_action('add_session')
    command! -buffer BookmarkList call DefxSessions(g:defx_session_file)
    " nnoremap <silent><buffer> B :<C-u>Denite defx/session<CR>

    nnoremap <buffer> <C-k> <Nop>
    nnoremap <buffer> <C-j> <Nop>
endfunction

function! DefxCurrentFileOpen() abort
    execute "Defx -no-toggle `expand('%:p:h')` -search=`expand('%:p')`"
    call defx#call_action('change_vim_cwd')
endfunction

nnoremap <silent><C-e> :<C-u>Defx<CR>
nnoremap <silent><Space>cdn :<C-u>call DefxCurrentFileOpen()<CR>

" DefxSessions
execute 'source '.expand('~/vimfiles/rc/plugins/defx_sessions.vim')

" icon を変える
call defx#custom#column('icon', {
\   'directory_icon': "\uf44a",
\   'opened_icon': "\uf44b",
\   'root_icon': ' ',
\})

let g:defx_session_file = expand('~/.defx_sessions')

" 共通のオプション
call defx#custom#option('_', {
\   'split': 'vertical',
\   'winwidth': 30,
\   'direction': 'topleft',
\   'toggle': 1,
\   'show_ignored_files': 0,
\   'root_marker': '.. ',
\   'session_file': g:defx_session_file,
\   'columns': 'indent:icon:filename:type',
\})


" ==============================================================================
" translate.vim
xmap     [tr <Plug>(VTranslate)
xmap     ]tr <Plug>(VTranslateBang)
" カーソル下の文字を翻訳
nnoremap [tr :<C-u>Translate  <C-r><C-w><CR>
nnoremap ]tr :<C-u>Translate! <C-r><C-w><CR>


" ==============================================================================
" lightline.vim
set noshowmode
set laststatus=2

let g:lightline = {}

let g:lightline.colorscheme = 'solarized'

let g:lightline.tabline = {
\   'left': [ ['tabs'] ],
\   'right': [ [] ],
\}

let g:lightline.active = {
\   'left': [ [ 't_mode', 'paste' ],
\             [ 'readonly', 't_filename' ],
\             [ 'linter_errors', 'linter_warnings', 'linter_ok' ]],
\   'right': [ [ 't_lineinfo' ],
\              [ 't_percent' ],
\              [ 't_filetype', 't_fileencoding', 't_fileformat' ]]
\}

let g:lightline.inactive = {
\   'left': [ [ 't_filename' ] ],
\   'right': [ [ 't_lineinfo' ],
\              [ 't_percent' ] ]
\}

let g:lightline.component_expand = {
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\}

" component_expand の色を設定?
let g:lightline.component_type = {
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'left',
\}

let g:lightline#ale#indicator_warnings = nr2char('0xf071')  " 
let g:lightline#ale#indicator_errors = nr2char('0xffb8a')   " 󿮊
let g:lightline#ale#indicator_ok = nr2char('0xf00c')        " 


function! VisibleRightComponent() abort
    return winwidth('.') > 70 &&
    \       &filetype !~# '\v^denite|^defx|deol|zsh'
endfunction

let g:lightline.component_function = {
\   't_mode': 'LightlineMode',
\   't_filename': 'LightlineFilename',
\   't_filetype': 'LightlineFiletype',
\   't_fileencoding': 'LightlineFileEncoding',
\   't_fileformat': 'LightlineFileFileFormat',
\   't_percent': 'LightlinePercent',
\   't_lineinfo': 'LightlineLineinfo',
\   't_inactive_mode': 'LightlineInactiveMode',
\}

function! LightlineMode() abort
    return &filetype ==# 'denite' ? 'Denite' :
    \       &filetype ==# 'defx' ? 'Defx' :
    \       lightline#mode()
endfunction

function! LightlineFilename() abort
    " 無名ファイルは %:t が '' となる
    return &filetype ==# 'denite-filter' ? 
    \           matchstr(denite#get_status('sources'), '^\w\+') :
    \       &filetype ==# 'denite' ? denite#get_status('sources') :
    \       &filetype =~# 'defx' ? '' :
    \       (expand('%:t') !=# '' ? expand('%:t') : 'No Name') .
    \       (&modifiable && &modified ? '[+]' : '')
endfunction

function! LightlineFiletype()
    return  VisibleRightComponent() ?
    \       (strlen(&filetype) ? &filetype : 'no ft') :
    \       ''
endfunction

function! LightlineFileEncoding()
    return  VisibleRightComponent() ?
    \       (&fileencoding !=# '' ? &fileencoding : &fileencoding) :
    \       ''
endfunction

function! LightlineFileFileFormat()
    return  VisibleRightComponent() ?
    \       &fileformat :
    \       ''
endfunction

function! LightlinePercent()
    return  VisibleRightComponent() ?
    \       printf('%3d', line('.') * 100 / line('$')) . '%' :
    \       ''
endfunction

function! LightlineLineinfo() abort
    return  VisibleRightComponent() ?
    \       line('.') . ':' . col('.') :
    \       ''
endfunction

" ==============================================================================
" colorscheme
function! DefineMyHighlishts() abort
    if g:colors_name =~# '^solarized8'
        hi IncSearch  gui=NONE guifg=fg guibg=#FFBF80
        hi Search     gui=NONE guifg=fg guibg=#FFFFA0
        hi SignColumn gui=NONE guifg=fg guibg=#FCF0CF

        " カーソル行はアンダーラインのみ
        hi CursorLine gui=underline guifg=NONE guibg=NONE

        " Diff* がめっちゃ重かったし、この色好きだから、いい感じ
        hi DiffAdd    gui=NONE guifg=fg guibg=#DFFFDF
        hi DiffChange gui=NONE guifg=fg guibg=#DFFFDF
        hi DiffDelete gui=NONE guifg=fg guibg=#FFDFDF
        hi DiffText   gui=NONE guifg=fg guibg=#AAFFAA

        " from shirotelin
        hi Todo       gui=bold guifg=#005F00 guibg=#afd7af

        " ====================
        " LeafCage/yankround.vim
        hi YankRoundRegion guibg=#FFEBCD

        " ====================
        " machakann/vim-highlightedyank
        hi HighlightedyankRegion guibg=bg guifg=#FFD688 gui=reverse

        " ====================
        " zah/nim.vim
        hi link nimBuiltin Statement

        " ====================
        " dense-analysis/ale
        hi ALEWarning     gui=undercurl guifg=fg      guibg=#D7FFD7
        hi ALEError       gui=undercurl guifg=fg      guibg=#FFE6FF
        hi ALEWarningSign gui=bold      guifg=#00AD00 guibg=#D7FFD7
        hi ALEErrorSign   gui=bold      guifg=#AF0000 guibg=#FFE6FF

        " ====================
        " markdown
        hi link MarkdownError Normal

    endif
endfunction
augroup MyColorScheme
    autocmd!
    autocmd ColorScheme * :call DefineMyHighlishts()
augroup END

" italic なくす
let g:solarized_italics = 0

colorscheme solarized8
set background=light


" ==============================================================================
" echodoc
let g:echodoc#enable_at_startup = 1


" ==============================================================================
" calendar.vim
let g:calendar_google_task = 0
" 初期表示で task を表示
let g:calendar_task = 1

" view のリスト
let g:calendar_views = ['year', 'month', 'week', 'day']

" 初期のview
let g:calendar_view = 'month'

augroup MyAutoCmdCalendar
    autocmd!
    " autocmd Filetype calendar nmap x <Plug>(calendar_xx)
augroup END


" ==============================================================================
" neopairs
let g:neopairs#enable = 1


" ==============================================================================
" previm



" ==============================================================================
" Shougo/denite.nvim

nnoremap <silent> <Space>ff :<C-u>DeniteBufferDir file/rec -default-action=split<CR>
" nnoremap <silent> <Space>fh :<C-u>Denite help -default-action=<CR>
" nnoremap <silent> <Space>fj :<C-u>Denite buffer -default-action=split<Cr>
" nnoremap <silent> <Space>fl :<C-u>Denite line -auto-action=highlight -winheight=25<CR>
" nnoremap <silent> <Space>fk :<C-u>Denite file_mru -default-action=split<CR>
nnoremap <silent> <Space>fm :<C-u>Denite menu -start-filter=false<CR>
" nnoremap <silent> <Space>fg :<C-u>Denite unite:giti<CR>
" https://github.com/raghur/vimfiles/blob/1a6720126308f96acf31384965c10c1ce5783a6e/vimrc#L492-L493
nnoremap <silent> <Space>fg :<C-u>Denite grep:::!<CR>
" nnoremap <silent> <Space>fq :<C-u>Denite ghq -default-action=open<CR>
nnoremap <silent> ; :<C-u>Denite command_history<CR>
nnoremap <silent> <Space>fs :<C-u>Denite unite:sonictemplate<CR>

" Denite の sources
nnoremap <Space>fd :<C-u>Denite <C-l>

" " 再表示
nnoremap <silent> <Space>f[ :<C-u>Denite -resume<CR>


call denite#custom#option('_', {
\   'prompt': '>',
\   'source_names': 1,
\   'vertical_preview': 1,
\   'direction': 'botright',
\   'start_filter': 1,
\   'winheight': 20,
\   'matchers': 'matcher/fruzzy',
\   'auto_resize': 1,
\   'winminheight': 1,
\   'filter-updatetime': 10,
\   'statusline': 0,
\})


" rg の設定
if executable('rg')
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep', '--no-heading'])
endif

" buffer
" timestamp を非表示
call denite#custom#var('buffer', 'date_format', '')

" mru
" 以下のような表示となる
" pwd:  ~\src\
" もと: ~\src\python\sample\main.py
" 結果:       python\sample\main.py
let g:neomru#filename_format = ':~:.'
let g:neomru#file_mru_limit = 500 " default is 1000
let g:neomru#directory_mru_limit = 500 " default is 1000

function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>     denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d        denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p        denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> <C-c>    denite#do_map('quit')
    nnoremap <silent><buffer><expr> <C-q>    denite#do_map('quit')
    nnoremap <silent><buffer><expr> i        denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> I        denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer>       <C-j>    j
    nnoremap <silent><buffer>       <C-k>    k
    nnoremap <silent><buffer><expr> <C-o>    denite#do_map('choose_action')
    nnoremap <silent><buffer>       <Space>q <Nop>
    nnoremap <silent><buffer><expr> <C-i>    denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> <C-s>    denite#do_map('do_action', 'split')
endfunction

function! s:denite_filter_my_settigns() abort
    nnoremap <silent><buffer>       <Space>q <Nop>
    inoremap <silent><buffer><expr> <C-q>
    \   denite#do_map('quit')
    inoremap <silent><buffer><expr> <C-c>
    \   denite#do_map('quit')
    nnoremap <silent><buffer><expr> <C-q>
    \   denite#do_map('quit')
    nnoremap <silent><buffer><expr> <C-c>
    \   denite#do_map('quit')

    " <C-w>p で最後にいたウィンドウに移動できる
    inoremap <silent><buffer> <C-k>
    \   <Esc><C-w>p
    inoremap <silent><buffer> <C-j>
    \   <Esc><C-w>p:call cursor(line('.')+1,0)<CR>

    nnoremap <silent><buffer><expr> <C-l>
    \   denite#do_map('toggle_matchers', 'matcher/regexp')
    inoremap <silent><buffer><expr> <C-l>
    \   denite#do_map('toggle_matchers', 'matcher/regexp')

    nnoremap <silent><buffer><expr> <C-i>
    \   denite#do_map('nop')
endfunction

augroup MyDeniteSettings
    autocmd!
    autocmd FileType denite         call s:denite_my_settings()
    autocmd FileType denite-filter  call s:denite_filter_my_settigns()
augroup END


" call denite#custom#action('file', 'test',
" \       {context -> execute('let g:foo = 1')})



" ==============================================================================
" mattn/gist-vim

" 設定方法
" Settings > Developper settingss > Personal access tokens でトークンを作って
" ~/.gist-vim に以下のように保存する
"   token xxxxxxxx

if has('win32')
    let g:gist_clip_command = 'clip'
endif

" 投稿したらブラウザを開く
let g:gist_open_browser_after_post = 1

" Private なgistも表示する
let g:gist_show_privates = 1

" デフォルトは private
let g:gist_post_private = 1

" 
let g:gist_list_vsplit = 1

" :w! としたときに更新をする
let g:gist_update_on_write = 2

" ==============================================================================
" raghur/fruzzy

let g:fruzzy#usenative = 1
let g:fruzzy#sortonempty = 0


" ==============================================================================
" " tomtom/ttodo_vim
" " todo.txt があるディレクトリ
" let g:ttodo#dirs = expand($XDG_CACHE_HOME.'/ttodo')
"
" if !isdirectory(g:ttodo#dirs)
"     call mkdir(g:ttodo#dirs)
" endif
"
" " default: '<LocalLeader>t'
" let g:ttodo#mapleader = '<LocalLeader>t'
"
" " todo.txt のファイル名
" " let g:ttodo#inbox = 'todo.txt'


" ==============================================================================
" Shougo/deol.nvim

" XXX: 参考にする https://git.io/JeKIn

" \%(\) : 部分正規表現として保存しない :help /\%(\)
" \%(>\|# \?\|\$\) :  > # $ 
let g:deol#prompt_pattern = '[^#>$ ]\{-}\%(>\|# \?\|\$\)'
" let g:deol#prompt_pattern = '.\{-}# '

" コマンドの履歴
let g:deol#shell_history_path = expand('~/deol_history')

augroup MyDeol
    autocmd!
    autocmd Filetype deol call DeolSettings()
    " expand('<afile>') とする
    autocmd BufWinEnter * if expand('<afile>') ==# 'deol-edit' | call DeolEditorSettings() | endif
augroup END

function! DeolSettings() abort
    tmap     <buffer><silent> <A-e> <C-w>:call deol#edit()<CR>
    nmap     <buffer><silent> <A-e> <Plug>(deol_edit)
    nmap     <buffer><silent> <A-t> <Plug>(deol_quit)

    " "\<Right>" じゃだめだった
    nnoremap <buffer><silent><expr> I
    \   'i' . repeat("<Right>", len(getline('.')))
    nnoremap <buffer><silent><expr> A
    \   'i' . repeat("<Left>", len(getline('.')))

    " 不要なマッピングを削除
    nnoremap <buffer>         <C-o> <Nop>
    nnoremap <buffer>         <C-i> <Nop>
    nnoremap <buffer>         <C-e> <Nop>
    nnoremap <buffer>         <C-z> <Nop>
endfunction

function! DeolEditorSettings() abort
    imap <buffer> <C-q> <Esc>:call QuitDeolEditor()<CR>
    nmap <buffer> <C-q> <Esc>:call QuitDeolEditor()<CR>
    imap <buffer> <A-e> <Esc>:call QuitDeolEditor()<CR>
    nmap <buffer> <A-e> <Esc>:call QuitDeolEditor()<CR>

    nnoremap <buffer>         <C-o> <Nop>
    nnoremap <buffer>         <C-i> <Nop>
    nnoremap <buffer>         <C-e> <Nop>

    setlocal winfixheight
endfunction


" TODO: タブが削除されたら、その中にある deol もちゃんと消してあげる
function! QuitDeolEditor() abort
    quit
    if exists('t:deol')
        call win_gotoid(bufwinid(t:deol.bufnr))
    endif
endfunction

function! ShowDeol(tabnr, ...) abort
    let l:deol = gettabvar(a:tabnr, 'deol', {})

    if a:0 ==# 1
        let l:command = a:1
    else
        let l:command = &shell
    endif

    botright 25new
    setlocal winfixheight

    if empty(l:deol)
        let l:cwd = expand('%:p')
        call deol#start(printf('-edit -cwd=%s -command=%s', l:cwd, l:command))
    elseif !bufexists(l:deol.bufnr)
        let l:cwd = expand('%:p')
        call deol#start(printf('-edit -cwd=%s -command=%s', l:cwd, l:command))
    else
        " 復活
        execute 'buffer ' . l:deol.bufnr
        normal! i
        call deol#edit()
    endif
endfunction


function! HideDeol(tabnr) abort
    let l:deol = gettabvar(a:tabnr, 'deol', {})
    if empty(l:deol)
        " まだ、作られていない場合、終わり
        return
    endif

    for l:bufnr in tabpagebuflist(a:tabnr)
        if l:deol.bufnr ==# l:bufnr
            execute 'hide'
            break
        endif
    endfor
endfunction


function! IsShowDeol(tabnr) abort
    let l:deol = gettabvar(a:tabnr, 'deol', {})
    if empty(l:deol)
        " まだ、作られていない場合、終わり、表示すらされないため
        return 0
    endif

    for l:bufnr in tabpagebuflist(a:tabnr)
        if l:deol.bufnr ==# l:bufnr
            return 1
        endif
    endfor
    return 0
endfunction


function! ToggleDeol(tabnr) abort
    if IsShowDeol(a:tabnr)
        call HideDeol(a:tabnr)
    else
        call ShowDeol(a:tabnr)
    endif
endfunction


command! DeolOpen :<C-u>Deol<CR>
command! ToggleDeol call ToggleDeol(tabpagenr())
nnoremap <A-t> :<C-u>ToggleDeol<CR>
tnoremap <A-t> <C-\><C-n>:<C-u>ToggleDeol<CR>



" ==============================================================================
" mattn/sonictemplate-vim

let g:sonictemplate_vim_template_dir = [
\   expand('~/vimfiles/template'),
\   expand('~/vimfiles/work/template'),
\]


" ==============================================================================
" dbeniamine/todo.txt-vim
" [タスク管理メソッド todo.txt が面白そう - Qiita https://qiita.com/sta/items/0f72c9c956cf05df8141]
" [todotxt/todo.txt: ‼️ A complete primer on the whys and hows of todo.txt. https://github.com/todotxt/todo.txt]
" [dbeniamine/todo.txt-vim: Efficient Todo.txt management in vim https://github.com/dbeniamine/todo.txt-vim]

" マッピングはここを見る
" ~\ghq\github.com\tamago324\vimfiles\plugged\todo.txt-vim\ftplugin\todo.vim

" done.txt の名前
let g:TodoTxtForceDoneName='done.txt'
" デフォルトのマッピングを OFF
let g:Todo_txt_do_not_map = 1

" @  コンテキスト(状況で管理するため)
" due:yyyy-mm-dd 期限(due)

augroup MyTodo
    autocmd!
    autocmd FileType todo setlocal omnifunc=todo#Complete
    autocmd FileType todo call TodoMappings()
augroup END

function! TodoMappings() abort
    nnoremap <buffer> [Todo]   <Nop>
    nmap     <buffer> <Space>t [Todo]

    nnoremap <silent><buffer> o o<C-R>=strftime("%Y-%m-%d")<CR> 
    inoremap <silent><buffer> date<Tab> <C-R>=strftime("%Y-%m-%d")<CR>

    imap     <silent><buffer> + +<C-X><C-O>
    imap     <silent><buffer> @ @<C-X><C-O>

    nmap     <silent><buffer> [Todo]x <Plug>DoToggleMarkAsDone

    " " 日付を入れる
    " noremap  <silent><buffer> [Todo]d :<C-u>call todo#PrependDate()<CR>

    " 優先順位
    noremap  <silent><buffer> [Todo]a :<C-u>call todo#PrioritizeAdd('A')<CR>
    noremap  <silent><buffer> [Todo]b :<C-u>call todo#PrioritizeAdd('B')<CR>
    noremap  <silent><buffer> [Todo]c :<C-u>call todo#PrioritizeAdd('C')<CR>
    noremap  <silent><buffer> [Todo]j :<C-u>call todo#PrioritizeIncrease()<CR>
    noremap  <silent><buffer> [Todo]k :<C-u>call todo#PrioritizeDecrease()<CR>

    " 期限
    nmap     <silent><buffer> [Todo]p <Plug>TodotxtIncrementDueDateNormal
    nmap     <silent><buffer> [Todo]n <Plug>TodotxtDecrementDueDateNormal
    nnoremap <silent><buffer> [Todo]d A due:<C-R>=strftime("%Y-%m-%d")<CR><Esc>0

    " 管理
    nnoremap <silent><buffer> [Todo]g :<C-u>call todo#RemoveCompleted()<CR>
endfunction

nnoremap <Space>tt :<C-u>Todo<CR>
command! Todo call tmg#DropOrTabedit('~/memo/todo/todo.txt')
