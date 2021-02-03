set encoding=utf-8

filetype plugin indent on
syntax enable

set runtimepath+=~/.ghq/github.com/{{_cursor_}}

set nobackup
set noswapfile
language messages en_US.utf8

" nvim --clean -u {{_expr_:expand('%:p:~')}} -i NONE
