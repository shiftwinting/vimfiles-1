scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/pydocstring.vim'))
    finish
endif

let g:pydocstring_enable_mapping = 0

" 'sphinx', 'google', 'numpy'
let g:pydocstring_formatter = 'sphinx'

if executable('doq')
    " system() を使うと開業がついてしまうため
    let g:pydocstring_doq_path = substitute(substitute(system('where doq'), '\', '/', 'g'), '\n$', '', '')
endif


function! s:settings() abort
    nmap <silent> <M-d> <Plug>(pydocstring)
endfunction

augroup MyPydocstring
    autocmd!
    autocmd FileType python call <SID>settings()
augroup END
