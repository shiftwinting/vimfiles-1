scriptencoding utf-8

" 読み込まないと関数を呼べないため
packadd vim-quickui
let g:quickui_color_scheme = 'solarized'

noremap <C-s> :<C-u>call quickui#menu#open()<CR>
augroup MyQuickui
    autocmd!
    autocmd Filetype todo nnoremap <C-s> :<C-u>call quickui#menu#open('todo')<CR>
augroup END


" ============================================================================
" todo
call quickui#menu#switch('todo')
call quickui#menu#reset()

call quickui#menu#install('&Todo', [
\   ['&Done', 'call todo#ToggleMarkAsDone("")'],
\   ['&Cancel', 'call todo#ToggleMarkAsDone("Cancelled")'],
\   ['&AddDue', "normal! A due:\<C-R>=strftime('%Y-%m-%d')\<CR>\<Esc>0"],
\], '<auto>', 'todo')


" ============================================================================
" system
call quickui#menu#switch('system')
call quickui#menu#reset()

call quickui#menu#install('&BrowserSync', [
\   ['&Start', 'BrowserSyncStart'],
\   ['S&top', 'BrowserSyncStop'],
\   ['&Open', 'BrowserSyncOpen'],
\   ['&Reload', 'BrowserSyncReload'],
\])

call quickui#menu#install('&Sass', [
\   ['&Start', 'call feedkeys(":SassWatchStart ")'],
\   ['S&top', 'SassWatchStop'],
\])

call quickui#menu#install('&ghq', [
\   ['&Get', 'call feedkeys(":GhqGet ")'],
\   ['&Create', 'echo "todo"'],
\])
