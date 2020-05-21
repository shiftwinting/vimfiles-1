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

let g:min_vimrc = 0
let g:min_vimrc = get(g:, 'min_vimrc', 0)

let g:plug_script = expand('<sfile>:h').'/plug.vim'
let g:vimfiles_path = expand('<sfile>:h')

exec "source ".expand("<sfile>:h").'/plug.vim'

" ------------------------------------------------------------------------------

" $PATH に $VIM が入っていない場合、先頭に追加する
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
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

    " pipenv の 仮想環境をプロジェクト内に作る
    let $PIPENV_VENV_IN_PROJECT = 'true'

    call vimrc#add_path('$LOCALAPPDATA/Programs/Git/usr/bin')

endif

call map(sort(split(globpath(&runtimepath, '_config/*.vim'))), {->[execute('exec "so" v:val')]})

exec "source ".expand("<sfile>:h")."/work.vim"
