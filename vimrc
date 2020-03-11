set encoding=utf-8
scriptencoding utf-8

" " 改行コードの設定
set fileformats=unix,dos,mac

" https://github.com/vim-jp/issues/issues/1186
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932

" デフォルトのプラグインをOFF
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

let g:min_vimrc = 1
let g:min_vimrc = get(g:, 'min_vimrc', 0)


function! s:plug(require, name, ...) abort
    " min かつ 必須ではない場合、読み込まない
    let l:opts = a:0 > 0 ? a:1 : {}
    if a:require || !g:min_vimrc
        Plug a:name, l:opts
    endif
endfunction

" <bang>0 って書くと、0 or 1 で渡せる (vim-plug からもらった)
command! -bang -nargs=+ MyPlug call <SID>plug(<bang>0, <args>)



call plug#begin('~/vimfiles/plugged')


" いつでも使うやつには ! をつける

MyPlug! 'junegunn/vim-plug'
MyPlug! 'vim-jp/vimdoc-ja'
MyPlug! 'vim-jp/vital.vim'
MyPlug! 'vim-jp/syntax-vim-ex'


MyPlug  'andymass/vim-matchup'
MyPlug  'dense-analysis/ale'
MyPlug  'dhruvasagar/vim-table-mode'
MyPlug  'majutsushi/tagbar'
MyPlug  'mattn/emmet-vim'
MyPlug  'mattn/gist-vim'
MyPlug  'mattn/webapi-vim'
MyPlug  'mg979/vim-visual-multi'
MyPlug  'previm/previm'
MyPlug  'rbtnn/vim-coloredit'
MyPlug  'rhysd/reply.vim'
MyPlug  'simnalamburt/vim-mundo'
MyPlug  'skanehira/translate.vim'
MyPlug  'skywind3000/vim-quickui'
MyPlug  'tamago324/vim-browsersync'
MyPlug  'tweekmonster/helpful.vim'
MyPlug  'unblevable/quick-scope'
MyPlug! 'Yggdroot/indentLine'
MyPlug! 'ap/vim-css-color'
MyPlug! 'dbeniamine/todo.txt-vim'
MyPlug! 'deris/vim-shot-f'
MyPlug! 'glidenote/memolist.vim'
MyPlug! 'haya14busa/vim-asterisk'
MyPlug! 'jiangmiao/auto-pairs'
MyPlug! 'junegunn/vim-easy-align'
MyPlug! 'kana/vim-repeat'
MyPlug! 'kana/vim-tabpagecd'
MyPlug! 'ludovicchabant/vim-gutentags'
MyPlug! 'machakann/vim-highlightedyank'
MyPlug! 'markonm/traces.vim'
MyPlug! 'mattn/sonictemplate-vim'
MyPlug! 'mechatroner/rainbow_csv'
MyPlug! 'rbtnn/vim-mrw'
MyPlug! 'rcmdnk/yankround.vim'
MyPlug! 'simeji/winresizer'
MyPlug! 'svermeulen/vim-cutlass'
MyPlug! 't9md/vim-quickhl'
MyPlug! 'thinca/vim-qfreplace'
MyPlug! 'thinca/vim-quickrun'
MyPlug! 'tomtom/tcomment_vim'
MyPlug! 'tpope/vim-endwise'
MyPlug! 'tpope/vim-surround'
MyPlug! 'tyru/capture.vim'
MyPlug! 'tyru/open-browser-github.vim'
MyPlug! 'tyru/open-browser.vim'


" --------------------------
" python
" --------------------------
MyPlug 'vim-python/python-syntax'

" --------------------------
" php
" --------------------------
MyPlug 'jwalton512/vim-blade'

" --------------------------
" nim
" --------------------------
MyPlug 'zah/nim.vim'

" --------------------------
" frontend
" --------------------------
MyPlug 'AndrewRadev/tagalong.vim'
MyPlug 'hail2u/vim-css3-syntax'
MyPlug 'jason0x43/vim-js-indent'
MyPlug 'leafOfTree/vim-vue-plugin'
MyPlug 'othree/html5.vim'
MyPlug 'prettier/vim-prettier', { 'do': 'yarn install' }
MyPlug 'yuezk/vim-js'

" --------------------------
" syntax
" --------------------------
MyPlug  'delphinus/vim-firestore'
MyPlug! 'k-takata/vim-dosbatch-indent'

" --------------------------
" snippets
" --------------------------
MyPlug! 'Shougo/neosnippet.vim'
MyPlug! 'Shougo/neosnippet-snippets'
MyPlug! 'honza/vim-snippets'

" --------------------------
" complete
" --------------------------
MyPlug! 'Shougo/neco-syntax'

" --------------------------
" complete vim
" --------------------------
MyPlug! 'machakann/vim-Verdin'

" --------------------------
" textobj
" --------------------------
MyPlug! 'kana/vim-textobj-user'
MyPlug! 'osyo-manga/vim-textobj-multiblock'
MyPlug! 'kana/vim-textobj-function'
MyPlug! 'haya14busa/vim-textobj-function-syntax'
MyPlug! 'kana/vim-textobj-line'

" --------------------------
" operator
" --------------------------
MyPlug! 'kana/vim-operator-user'
MyPlug! 'kana/vim-operator-replace'

" --------------------------
" dark power
" --------------------------
MyPlug! 'Shougo/deol.nvim'
MyPlug  'Shougo/context_filetype.vim'

" --------------------------
" lightline
" --------------------------
MyPlug! 'itchyny/lightline.vim'

" --------------------------
" git
" --------------------------
MyPlug  'airblade/vim-gitgutter'
MyPlug! 'tpope/vim-fugitive'
MyPlug  'junegunn/gv.vim'
MyPlug! 'gisphm/vim-gitignore'
MyPlug! 'rhysd/conflict-marker.vim'

" --------------------------
" colorscheme
" --------------------------
MyPlug! 'lifepillar/vim-solarized8'

" --------------------------
" LeaderF
" --------------------------
MyPlug! 'Yggdroot/LeaderF', { 'do': './install.bat' }
MyPlug! 'tamago324/LeaderF-ghq'
MyPlug  'tamago324/LeaderF-cdnjs'
MyPlug! 'tamago324/LeaderF-bookmark'
MyPlug! 'tamago324/LeaderF-openbrowser'
MyPlug! 'tamago324/LeaderF-filer'
MyPlug! 'ryanoasis/vim-devicons'
    MyPlug! 'tamago324/LeaderF-unite'
MyPlug! 'Shougo/unite.vim'
    MyPlug  'thinca/vim-ref'
    MyPlug  'Shougo/unite-outline'

" --------------------------
" coc
" --------------------------
MyPlug 'neoclide/coc.nvim', {'branch': 'release'}
MyPlug 'Shougo/neco-vim'
MyPlug 'neoclide/coc-neco'
MyPlug 'josa42/vim-lightline-coc'



call plug#end()

" ------------------------------------------------------------------------------

" set runtimepath^=~/ghq/github.com/tamago324/LeaderF
" set runtimepath^=~/ghq/github.com/tamago324/LeaderF-filer

" $PATH に $VIM が入っていない場合、先頭に追加する
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
    call tmg#add_path($VIM)
endif

if has('win32')
    let $XDG_CACHE_HOME = $LOCALAPPDATA

    if $PATH !~# 'Yarn/bin'
        call tmg#add_path($LOCALAPPDATA.'/Yarn/bin')
    endif

    " dart のパスを追加
    if $PATH !~# 'dart-sdk/bin'
        call tmg#add_path('C:/tools/dart-sdk/bin')
    endif

    if $PATH !~# 'ctags'
        call tmg#add_path('~/ctags')
    endif
endif

call map(sort(split(globpath(&runtimepath, '_config/*.vim'))), {->[execute('exec "so" v:val')]})
