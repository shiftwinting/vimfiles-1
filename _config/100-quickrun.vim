scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/quickrun.vim'))
    finish
endif

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
    \}

nmap <Space>rr <Plug>(quickrun)
