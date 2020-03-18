scriptencoding utf-8

" 折返しのインデント
let g:vim_indent_cont = 0

" from https://twitter.com/hrsh7th/status/1206597079134437378
let $MYVIMRC = resolve($MYVIMRC)


set autoindent          " 改行時に前の行のインデントを維持する
" set smartindent         " 改行時に入力された行の末尾に合わせて次の行のインデントを増減
set shiftround          " インデント幅を必ず shiftwidth の倍数にする
set hlsearch            " 検索文字列をハイライトする
set incsearch           " 文字を入力されるたびに検索を実行する
set scrolloff=5         " 5行開けてスクロールできるようにする
set visualbell t_vb=    " ビープ音すべてを無効にする
set noerrorbells        " エラーメッセージの表示時にビープ音を鳴らさない
set history=3000         " 検索、置換、コマンド... の履歴を300にする(default: 50)
set showtabline=2       " 常にタブを表示
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 大文字が入らない限り、大文字小文字は区別しない
set cmdheight=2         " 2 で慣れてしまったため
set ambiwidth=double    " 記号を正しく表示
set timeoutlen=480      " マッピングの待機時間
set nrformats-=octal    " 07 で CTRL-A しても、010 にならないようにする
set signcolumn=yes      " 常に表示
set completeslash=slash " 補完時に使用する slash
set nostartofline       " <C-v>で選択しているときに、上下移動しても、行頭に行かないようにする
set autoread            " Vim の外でファイルを変更した時、自動で読み込む
set splitright          " 縦分割した時、カレントウィンドウの右に作成する

" menuone:  候補が1つでも表示
" popup:    info を popup で表示
" noselect: 自動で候補を表示しない
set completeopt=menuone,noselect,noinsert
set pumheight=15

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" syntax highlight
" syntax enable と syntax on の違いを理解する (:help :syntax-on)
" on: 既存の色の設定を上書きする
" enable: まだ、設定されていない色の設定のみ適用する
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

" cmdline の補完設定
" ステータスラインに候補を表示
set wildmenu

" Tab 1回目:  共通部分まで補完し、候補リストを表示
" Tab 2回目~: 候補を完全に補完
set wildmode=longest:full,list:full

" cmdline から cmdline-window へ移動
set cedit=\<C-k>

" listchars (不可視文字を表示する) "
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

" 補完候補の最大表示数
set pumheight=15
" 補完のメッセージを表示しない
set shortmess+=c

" diff の設定
" https://qiita.com/takaakikasai/items/3d4f8a4867364a46dfa3
" internal: 内部diffライブラリを設定する
" filler: 片方にしか無い行を埋める
" algorithm:histogram: histogram差分アルゴリズム を使用する
" indent-heuristic: 内部 diff のインデントヒューリスティック？を使う
set diffopt=internal,filler,algorithm:histogram,indent-heuristic

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

" fold 折畳
function! MyFoldText() abort "
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

" from kaoriya's vimrc
" マルチバイト文字の間でも改行できるようにする(autoindentが有効の場合いる)
set formatoptions+=m
" マルチバイト文字の間で行連結した時、空白を入れない
set formatoptions+=M

" from #vimtips_ac https://twitter.com/Takutakku/status/1207676964225597441
" 結合時、コメントを削除する
set formatoptions+=j

" 自動でコメント開始文字を挿入しないようにする
" set formatoptions-=r
" set formatoptions-=o

" https://github.com/shanselman/cmd-colors-solarized

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


" terminal
" prefix
set termwinkey=<C-w>

set noshowmode
set laststatus=2

execute 'set viewdir='.expand("~/_vimview")

" パスとして = を含めない (set rtp=~/path/to/file で補完できるようにする)
set isfname-==

" 矩形選択の時、文字がない箇所も選択できるようにする
set virtualedit=block

" -------------------------------------------------------------
" gf とかで相対パスを検索するときの基準となるディレクトリのリスト
set path=
" カレントファイルからの相対パス
set path+=.
" カレントディレクトリからの相対パス
set path+=,,
" カレントディレクトリから上に探しに行く
set path+=**

set foldlevelstart=99

" 表示できるところまで表示する
set display=lastline
