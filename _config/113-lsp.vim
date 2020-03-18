scriptencoding utf-8

" mattn さんの lsp の設定 https://gist.github.com/mattn/3c65639710016d662701bb2526ecba55

function! s:lsp_setup() abort

    " python -m pip install python-language-server
    if executable('pyls')
        call lsp#register_server({
        \   'name': 'pyls',
        \   'cmd': [&shell, &shellcmdflag, 'pyls'],
        \   'whitelist': ['python'],
        \})
    endif


    " yarn global add vim-language-server
    if executable('vim-language-server')
        call lsp#register_server({
        \   'name': 'vim',
        \   'cmd': [&shell, &shellcmdflag, 'vim-language-server', '--stdio'],
        \   'whitelist': ['vim'],
        \})
    endif

endfunction


" | 機能                    | vim | pyls |
" |-------------------------|-----|------|
" | definition              | o   | o    |
" | references              | o   | o    |
" | hover                   | o   | o    |
" | signatureHelp           | o   | o    |
" | rename                  | o   | o    |
" | completion              | o   | o    |
" | executeCommand          | x   | ?    |
" | documentHighlight       | x   | o    |
" | codeAction              | x   | o    |
" | codeLens                | x   | o    |
" | documentRangeFormatting | x   | o    |
" | documentFormatting      | x   | o    |

function! s:lsp_settings() abort
    " completion
    setlocal omnifunc=lsp#complete

    " definition
    nmap <buffer> gd    <plug>(lsp-definition)

    " references
    nmap <buffer> gr    <plug>(lsp-references)
    nmap <buffer> [r    <plug>(lsp-next-reference)
    nmap <buffer> ]r    <plug>(lsp-previous-reference)

    " hover
    nmap <buffer> K     <plug>(lsp-hover)

    " rename

endfunction

augroup MyLsp
    autocmd!
    autocmd User lsp_setup call s:lsp_setup()
    autocmd FileType python,vim call s:lsp_settings()
augroup END


" デバッグ用
let g:lsp_log_verbose = 1
let g:lsp_log_file = 'C:/tmp/vimlsp.log'

" 診断結果を表示する
let g:lsp_diagnostics_enabled = 1
