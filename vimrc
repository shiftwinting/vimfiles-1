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

function! PackInit() abort
    packadd minpac

    call minpac#init()

    " packadd でロードするために minpac 自体は {'type': 'opt'} で追加しておく
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " その他のプラグイン
    call minpac#add('vim-jp/vimdoc-ja')
    call minpac#add('vim-jp/vital.vim')
    call minpac#add('vim-jp/syntax-vim-ex')

    call minpac#add('Yggdroot/indentLine')
    call minpac#add('ap/vim-css-color')
    call minpac#add('dense-analysis/ale')
    call minpac#add('dhruvasagar/vim-table-mode')
    call minpac#add('glidenote/memolist.vim')
    call minpac#add('kana/vim-repeat')
    call minpac#add('ludovicchabant/vim-gutentags') " tags 生成
    call minpac#add('machakann/vim-highlightedyank')
    call minpac#add('majutsushi/tagbar')
    call minpac#add('markonm/traces.vim') " :s の可視化
    call minpac#add('mattn/emmet-vim')
    call minpac#add('mattn/sonictemplate-vim')
    call minpac#add('mechatroner/rainbow_csv')
    call minpac#add('simeji/winresizer') " ウィンドウ操作
    call minpac#add('skanehira/translate.vim')
    call minpac#add('t9md/vim-quickhl')
    call minpac#add('thinca/vim-quickrun')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tyru/capture.vim') " Exコマンドをバッファへ出力
    call minpac#add('tyru/open-browser.vim')
    call minpac#add('tyru/open-browser-github.vim')
    call minpac#add('previm/previm')
    call minpac#add('tpope/vim-endwise')
    call minpac#add('kana/vim-tabpagecd')
    call minpac#add('mattn/gist-vim')
    call minpac#add('mattn/webapi-vim')
    call minpac#add('dbeniamine/todo.txt-vim')
    call minpac#add('tomtom/tcomment_vim')
    call minpac#add('andymass/vim-matchup')
    call minpac#add('rbtnn/vim-coloredit')
    call minpac#add('tweekmonster/helpful.vim')
    call minpac#add('jiangmiao/auto-pairs')
    call minpac#add('haya14busa/vim-asterisk')
    call minpac#add('svermeulen/vim-cutlass')   " 削除系はすべてブラックホールレジスタに入れる
    call minpac#add('rcmdnk/yankround.vim')
    call minpac#add('rbtnn/vim-mrw')
    call minpac#add('simnalamburt/vim-mundo')   " undotree の可視化
    call minpac#add('rhysd/reply.vim')
    call minpac#add('deris/vim-shot-f')
    call minpac#add('unblevable/quick-scope')
    call minpac#add('mg979/vim-visual-multi')
    call minpac#add('tamago324/vim-browsersync')
    call minpac#add('skywind3000/vim-quickui')

    " == python
    call minpac#add('vim-python/python-syntax')

    " == php
    call minpac#add('jwalton512/vim-blade')

    " == nim
    call minpac#add('zah/nim.vim')

    " == frontend
    call minpac#add('AndrewRadev/tagalong.vim')     " 閉じタグを自動で書き換えてくれる
    call minpac#add('hail2u/vim-css3-syntax')
    call minpac#add('jason0x43/vim-js-indent')
    call minpac#add('leafOfTree/vim-vue-plugin')
    call minpac#add('othree/html5.vim')
    call minpac#add('prettier/vim-prettier', { 'do': 'yarn install' }) " Formatter

    " syntax
    call minpac#add('yuezk/vim-js')
    call minpac#add('delphinus/vim-firestore')
    call minpac#add('k-takata/vim-dosbatch-indent')

    " == lsp
    call minpac#add('Shougo/neosnippet.vim')
    call minpac#add('Shougo/neosnippet-snippets')
    call minpac#add('honza/vim-snippets')

    " == complete
    call minpac#add('Shougo/neco-syntax')

    " == complete vim
    call minpac#add('machakann/vim-Verdin')

    " == textobj
    call minpac#add('kana/vim-textobj-user')
    call minpac#add('osyo-manga/vim-textobj-multiblock')
    call minpac#add('kana/vim-textobj-function')
    call minpac#add('haya14busa/vim-textobj-function-syntax')
    call minpac#add('kana/vim-textobj-line')

    " == operator
    call minpac#add('kana/vim-operator-user')
    call minpac#add('kana/vim-operator-replace')

    " == dark power
    call minpac#add('Shougo/deol.nvim')
    call minpac#add('Shougo/context_filetype.vim')

    " == lightline
    call minpac#add('itchyny/lightline.vim')

    " == git
    call minpac#add('airblade/vim-gitgutter')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('junegunn/gv.vim')    " log をみやすくする
    call minpac#add('gisphm/vim-gitignore')     " gitignore の highlight/snippets

    " == colorscheme
    " :colorscheme は opt でもいいため
    call minpac#add('lifepillar/vim-solarized8', {'type': 'opt'})

    " == LeaderF
    call minpac#add('Yggdroot/LeaderF', { 'do': './install.bat' })
    call minpac#add('tamago324/LeaderF-ghq')
    call minpac#add('tamago324/LeaderF-cdnjs')
    call minpac#add('tamago324/LeaderF-bookmark')
    call minpac#add('tamago324/LeaderF-openbrowser')
    call minpac#add('tamago324/LeaderF-filer')
        call minpac#add('ryanoasis/vim-devicons')
    call minpac#add('tamago324/LeaderF-unite')
        call minpac#add('Shougo/unite.vim')
        call minpac#add('thinca/vim-ref')
        call minpac#add('Shougo/unite-outline')

    " coc
    call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
    call minpac#add('Shougo/neco-vim')
    call minpac#add('neoclide/coc-neco')
    call minpac#add('josa42/vim-lightline-coc')

    " ------------------------------------------------------------------------------

endfunction

set runtimepath^=~/ghq/github.com/tamago324/LeaderF
set runtimepath^=~/ghq/github.com/tamago324/LeaderF-filer

" $PATH に $VIM が入っていない場合、先頭に追加する
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
    let $PATH = $VIM . ';' . $PATH
endif

if has('win32')
    let $XDG_CACHE_HOME = $LOCALAPPDATA

    if $PATH !~# 'Yarn/bin'
        let $PATH = expand($LOCALAPPDATA.'/Yarn/bin').';' . $PATH
    endif

    " dart のパスを追加
    if $PATH !~# 'dart-sdk/bin'
        let $PATH = expand('C:/tools/dart-sdk/bin').';' . $PATH
    endif

    if $PATH !~# 'ctags'
        let $PATH = expand('~/ctags').';' . $PATH
    endif
endif

call map(sort(split(globpath(&runtimepath, '_config/*.vim'))), {->[execute('exec "so" v:val')]})
