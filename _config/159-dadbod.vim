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

let g:db_ui_icons = {
\   'expanded':         '',
\   'collapsed':        '',
\   'saved_query':      '',
\   'new_query':        '',
\   'tables':           '~',
\   'buffers':          '󿘽',
\   'connection_ok':    '',
\   'connection_error': '',
\}

let g:dbui_table_helpers = {}
let g:dbui_table_helpers.postgresql = {
\   'TColumns': "SELECT TABLE_NAME,\nCOLUMN_NAME,\nis_nullable,\ndata_type,\ncharacter_maximum_length,\nnumeric_precision\nFROM information_schema.columns\nWHERE TABLE_NAME='{table}';",
\}

augroup MyDadbod
    autocmd!
    autocmd Filetype sql call s:dadbod_setup()
augroup END
function! s:dadbod_setup() abort
    if exists('b:dbui_is_tmp')
        nmap <buffer> <Space>W <Plug>(DBUI_SaveQuery)
    endif
endfunction
