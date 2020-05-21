scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/db.vim'))
    finish
endif


" 'postgresql://ユーザー名:パスワード@ホスト:ポート/DB名'
" g:dbs で定義する
let g:dbs = {
\   'zero_study': 'postgresql://postgres:postgres@127.0.0.1:5432/shop',
\}

" g:db_ui_table_helpers で便利なヘルパーテーブルを作成できる？

" いろいろの保存先
let g:db_ui_save_location = expand($LOCALAPPDATA . '/db_ui')
let g:db_ui_show_database_icon = 1

let g:db_ui_icons = {
\   'expanded':         '',
\   'collapsed':        '',
\   'saved_query':      '',
\   'new_query':        '',
\   'tables':           '',
\   'buffers':          '󿘽',
\   'add_connection':   '',
\   'connection_ok':    '',
\   'connection_error': '',
\}

let g:db_ui_table_helpers = {}
let g:db_ui_table_helpers.postgresql = {
\   'table_def': join(readfile(expand('<sfile>:h') . '/sql/postgresql/table_def.sql'), "\n") 
\}

augroup MyDadbod
    autocmd!
    autocmd Filetype sql call s:sql_setup()
    autocmd Filetype dbui call s:dbui_setup()
augroup END
function! s:sql_setup() abort
    if exists('b:dbui_is_tmp')
        nmap    <buffer> <Space>W  <Plug>(DBUI_SaveQuery)
        nmap    <buffer> <Space>rr <Plug>(DBUI_ExecuteQuery)
        vmap    <buffer> <Space>rr <Plug>(DBUI_ExecuteQuery)

        " キャッシュを更新
        nnoremap <buffer> <F5> :call vim_dadbod_completion#fetch(bufnr())<CR>

        set omnifunc=vim_dadbod_completion#omni
    endif
endfunction

function! s:dbui_setup() abort
    nmap <C-t> <Plug>(DBUI_SelectLineVsplit)<C-w>T
endfunction

nnoremap md :<C-u>DBUIToggle<CR>
