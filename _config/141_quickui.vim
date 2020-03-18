scriptencoding utf-8

let g:quickui_color_scheme = 'solarized'

noremap <C-s> :<C-u>call quickui#menu#open()<CR>
augroup MyQuickui
    autocmd!
    autocmd Filetype todo nnoremap <buffer> <C-s> :<C-u>call quickui#menu#open('todo')<CR>
augroup END


" ============================================================================
" todo
call quickui#menu#switch('todo')
call quickui#menu#reset()

call quickui#menu#install('&Todo', [
\   ['&Done',   'call todo#ToggleMarkAsDone("")'],
\   ['&Cancel', 'call todo#ToggleMarkAsDone("Cancelled")'],
\   ['&AddDue', "normal! A due:\<C-R>=strftime('%Y-%m-%d')\<CR>\<Esc>0"],
\], '<auto>', 'todo')


" ============================================================================
" system
call quickui#menu#switch('system')
call quickui#menu#reset()


" browser sync
call quickui#menu#install('&BrowserSync', [
\   ['&start',  'BrowserSyncStart'],
\   ['s&top',   'BrowserSyncStop'],
\   ['&open',   'BrowserSyncOpen'],
\   ['&reload', 'BrowserSyncReload'],
\])


" sass
call quickui#menu#install('&Sass', [
\   ['&start', 'call sasswatch#start_intaractive()'],
\   ['s&top',  'SassWatchStop'],
\])


" ghq
call quickui#menu#install('gh&q', [
\   ['&get',    'call feedkeys(":GhqGet ")'],
\   ['&create', 'echo "todo"'],
\])


" git
call quickui#menu#install('&Git', [
\   ['&commit',       'call git#commit()'],
\   ['&commit amend', 'call git#commit_amend()'],
\   ['&push',         'call git#push()'],
\   ['pu&ll',         'call git#pull())'],
\   ['&checkout',     'Leaderf git_checkout --popup'],
\])
