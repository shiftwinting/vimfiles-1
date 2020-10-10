set encoding=utf-8
scriptencoding utf-8

" " 改行コードの設定
set fileformats=unix,dos,mac

" https://github.com/vim-jp/issues/issues/1186
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932

let g:plug_script = expand('<sfile>:h').'/plug.vim'
let g:vimfiles_path = expand('<sfile>:h')

if $IS_WSL
    let $MYVIMFILES = expand('$HOME/.vim')
else
    let $MYVIMFILES = expand('$HOME/vimfiles')
endif

exec 'source '.expand('<sfile>:h').'/plug.vim'

if has('gui_running')
    let $EDITOR = 'gvim'
endif

" ------------------------------------------------------------------------------

" $PATH に $VIM が入っていない場合、先頭に追加する
if has('win32') && $PATH !~? '/(^/|;/)' . escape($VIM, '//') . '/(;/|$/)'
    call vimrc#add_path($VIM)
endif

if has('win32')
    let $XDG_CACHE_HOME = $LOCALAPPDATA

    call vimrc#add_path($LOCALAPPDATA.'/Yarn/bin', 'Yarn/bin')
    call vimrc#add_path('~/.poetry/bin',           '.poetry/bin')
    call vimrc#add_path('C:/tools/dart-sdk/bin',   'dart-sdk/bin')
    call vimrc#add_path('~/ctags',                 'ctags')
    call vimrc#add_path('C:/Neovim/bin',           'Neovim/bin')
    call vimrc#add_path($HOME.'/.pyenv/pyenv-win/versions/3.8.1/Scripts')
    call vimrc#add_path($HOME.'/.pyenv/pyenv-win/bin')
    call vimrc#add_path('C:/Program Files/PostgreSQL/12/bin')
    call vimrc#add_path('C:/SBCL/1.4.14')
    call vimrc#add_path('C:/Racket')
    call vimrc#add_path('C:/Program Files/LLVM/bin')
    call vimrc#add_path('C:/Gauche/bin')
    call vimrc#add_path('C:/tools/graphviz/release/bin')
    call vimrc#add_path('C:/msys64/mingw64/bin')
    call vimrc#add_path('C:/tools/latexmk')
    " gtags
    call vimrc#add_path('C:/tools/global/bin')
    call vimrc#add_path('C:/CMake/bin')

    " asynctask の実行用
    call vimrc#add_path('~/vimfiles/plugged/asynctasks.vim/bin')

    " pipenv の 仮想環境をプロジェクト内に作る
    let $PIPENV_VENV_IN_PROJECT = 'true'

    call vimrc#add_path('$LOCALAPPDATA/Programs/Git/usr/bin')

endif

call map(sort(split(globpath(&runtimepath, '_config/*.vim'))), {->[execute('exec "so" v:val')]})
