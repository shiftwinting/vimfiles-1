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

" " 内部エンコーディング
" set encoding=utf-8
" " スクリプトの文字コード (encodingを設定した後に設定する必要がある)
" scriptencoding utf-8

" Plug

" ダウンロード先ディレクトリを指定
call plug#begin('~/vimfiles/plugged')

Plug 'junegunn/vim-plug'
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-jp/vital.vim'
Plug 'vim-jp/syntax-vim-ex' " VimL のハイライト拡張

Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
Plug 'dhruvasagar/vim-table-mode'
Plug 'glidenote/memolist.vim'
Plug 'kana/vim-repeat'
Plug 'ludovicchabant/vim-gutentags' " tags 生成
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'markonm/traces.vim' " :s の可視化
Plug 'mattn/emmet-vim'
Plug 'mattn/sonictemplate-vim'
Plug 'mechatroner/rainbow_csv'
Plug 'rhysd/clever-f.vim'
Plug 'simeji/winresizer' " ウィンドウ操作
Plug 'skanehira/translate.vim'
Plug 't9md/vim-quickhl'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-surround'
Plug 'tyru/capture.vim' " Exコマンドをバッファへ出力
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'previm/previm'
Plug 'tpope/vim-endwise'
Plug 'kana/vim-tabpagecd'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'dbeniamine/todo.txt-vim'
Plug 'tomtom/tcomment_vim'
Plug 'andymass/vim-matchup'
Plug 'rbtnn/vim-coloredit'
Plug 'tweekmonster/helpful.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'haya14busa/vim-asterisk'
" Plug 'svermeulen/vim-yoink'
Plug 'svermeulen/vim-cutlass'   " 削除系はすべてブラックホールレジスタに入れる
Plug 'cocopon/vaffle.vim'
Plug 'rcmdnk/yankround.vim'

" == python
" Plug 'ambv/black'

" == php
Plug 'jwalton512/vim-blade'

" == nim
Plug 'zah/nim.vim'

" == frontend
Plug 'othree/html5.vim'
" Plug 'posva/vim-vue'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " Formatter
Plug 'jason0x43/vim-js-indent'
Plug 'leafOfTree/vim-vue-plugin'

" syntax
Plug 'yuezk/vim-js'
Plug 'delphinus/vim-firestore'
Plug 'k-takata/vim-dosbatch-indent'

" == lsp
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/async.vim'
" Plug 'thomasfaingnaert/vim-lsp-snippets'
" Plug 'thomasfaingnaert/vim-lsp-neosnippet'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
" Plug 'mattn/vim-lsp-settings'

" " == complete
Plug 'Shougo/neco-syntax'

" == complete vim
Plug 'machakann/vim-Verdin'

" " == textobj
Plug 'kana/vim-textobj-user'
Plug 'osyo-manga/vim-textobj-multiblock'
Plug 'kana/vim-textobj-function'
Plug 'haya14busa/vim-textobj-function-syntax'
Plug 'kana/vim-textobj-line'

" == operator
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'

" == dark power
" Plug 'Shougo/echodoc.vim'
Plug 'Shougo/deol.nvim'
Plug 'Shougo/context_filetype.vim'

" == lightline
Plug 'itchyny/lightline.vim'
" Plug 'maximbaz/lightline-ale'

" == git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
\   | Plug 'junegunn/gv.vim'    " log をみやすくする
Plug 'gisphm/vim-gitignore'     " gitignore の highlight/snippets

" == colorscheme
Plug 'lifepillar/vim-solarized8'

" == LeaderF
Plug 'Yggdroot/LeaderF', { 'do': './install.bat' }
Plug 'tamago324/LeaderF-ghq'
Plug 'tamago324/LeaderF-cdnjs'
Plug 'tamago324/LeaderF-bookmark'
Plug 'tamago324/LeaderF-openbrowser'
Plug 'tamago324/LeaderF-filer'
\   | Plug 'ryanoasis/vim-devicons'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'josa42/vim-lightline-coc'

" ------------------------------------------------------------------------------

" Plug '~/ghq/github.com/tamago324/ale'
" Plug '~/ghq/github.com/tamago324/LeaderF'

call plug#end()

if has('win32')
    let $XDG_CACHE_HOME = $LOCALAPPDATA
endif

" $PATH に $VIM が入っていない場合、先頭に追加する
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
    let $PATH = $VIM . ';' . $PATH
endif

" " yarn のパスを追加
if $PATH !~# 'Yarn/bin'
    if has('win32')
        let $PATH = expand($LOCALAPPDATA.'/Yarn/bin').';' . $PATH
    endif
endif

call map(sort(split(globpath(&runtimepath, '_config/*.vim'))), {->[execute('exec "so" v:val')]})
