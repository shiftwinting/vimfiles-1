
if exists('current_compiler')
  finish
endif
let current_compiler = 'luacheck'

" --new-globals vim pprint
" --no-color
" -std luajit
" --formatter plain
" --codes
setlocal makeprg=luacheck\ %:p\ --new-globals\ vim\ pprint\ --no-color\ --std\ luajit\ --codes

" From syntastic > https://github.com/vim-syntastic/syntastic/blob/master/syntax_checkers/lua/luacheck.vim#L48-L50

" %-G%.%#  -> メッセージを無視する
setlocal errorformat=%f:%l:%c:\ (%t%n)\ %m,%-G%.%#
