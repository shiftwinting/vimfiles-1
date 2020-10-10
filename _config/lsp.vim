scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/lsp.vim'))
    finish
endif

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

    inoremap <buffer> <C-space> <C-x><C-o>

endfunction

augroup MyLsp
    autocmd!
    " autocmd User lsp_setup call s:lsp_setup()
    autocmd FileType python,vim,c,cpp call s:lsp_settings()
augroup END


" デバッグ用
let g:lsp_log_verbose = 1
if has('win32')
    let g:lsp_log_file = 'C:/tmp/vimlsp.log'
else
    let g:lsp_log_file = '/tmp/vimlsp.log'
endif


" lint するか？
" let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_enabled = 0

" カーソル位置の診断結果を echo する
let g:lsp_diagnostics_echo_cursor = 0
