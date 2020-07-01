scriptencoding utf-8

let g:quickrun_config = {}

" Windows の場合、コマンドの出力は cp932 のため
" (vimとかは内部で実行しているため、utf-8にする必要がある)
" hook/output_encode/encoding で encoding の from:to を指定できる
let g:quickrun_config = {
\   '_': {
\       'runner': 'job',
\       'hook/output_encode/encoding': 'cp932',
\       'outputter/buffer/close_on_empty': 1,
\   },
\   'vim': {
\       'hook/output_encode/encoding': '&fileencoding',
\   },
\   'nim': {
\       'hook/output_encode/encoding': '&fileencoding',
\   },
\   'python': {
\       'exec': 'py -3 %s',
\       'hook/output_encode/encoding': '&fileencoding',
\   },
\   'scheme': {
\       'exec': 'gosh %s',
\   },
\   'c': {
\       'command': 'clang',
\       'exec': ['%c %o %s:p:r', 'a.exe %a'],
\       'tempfile': '%{tempname()}.c',
\       'hook/sweep/files': '%S:p:r',
\   },
\}

" \   'c': {
" \       'exec': 'clang.exe %s && a'
" \   }

nmap <Space>rr <Plug>(quickrun)

command! QRHookUtf8 let b:quickrun_config = {'hook/output_encode/encoding': 'utf8'}
