scriptencoding utf-8
UsePlugin 'vim-quickrun'

let g:quickrun_config = {}

" Windows の場合、コマンドの出力は cp932 のため
" (vimとかは内部で実行しているため、utf-8にする必要がある)
" hook/output_encode/encoding で encoding の from:to を指定できる
let g:quickrun_config = {
\   '_': {
\       'runner': has('nvim') ? 'system' : 'job',
\       'hook/output_encode/encoding': has('win32') ? 'cp932' : 'utf-8',
\       'outputter/buffer/close_on_empty': 1,
\   },
\   'vim': {
\       'hook/output_encode/encoding': '&fileencoding',
\   },
\   'nim': {
\       'hook/output_encode/encoding': '&fileencoding',
\   },
\   'python': {
\       'exec': has('win32') ? 'py -3 %s %a' : 'python3.9 %s %a',
\       'hook/output_encode/encoding': '&fileencoding',
\   },
\   'scheme': {
\       'exec': 'gosh %s',
\   },
\   'c': {
\       'command': 'clang',
\       'exec': has('win32') ? ['%c %o %s:p', 'a.exe %a'] : ['%c %o %s:p', './a.out %a'],
\       'tempfile': '%{tempname()}.c',
\       'hook/sweep/files': '%S:p:r',
\       'cmdopt': '-Wall',
\   },
\   'haskell': {
\       'command': 'stack',
\       'cmdopt': 'runhaskell',
\   },
\   'lua': {
\       'type': 'lua/vim'
\   },
\}

" \   'c': {
" \       'exec': 'clang.exe %s && a'
" \   }
" \   'rust': {
" \       'exec': 'cargo run'
" \   }

nmap <Space>rr <Plug>(quickrun)

command! QRHookUtf8 let b:quickrun_config = {'hook/output_encode/encoding': 'utf8'}

nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

