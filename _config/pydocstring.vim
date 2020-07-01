scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/pydocstring.vim'))
    finish
endif

let g:pydocstring_enable_mapping = 0

" 'sphinx', 'google', 'numpy'
let g:pydocstring_formatter = 'sphinx'

" if executable('doq')
"     let g:pydocstring_doq_path = system('where doq')
" endif
