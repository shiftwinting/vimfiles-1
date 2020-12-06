scriptencoding utf-8

" finish

if empty(globpath(&rtp, 'autoload/asyncomplete.vim'))
    finish
endif

augroup MyAsyncomplete
    autocmd!
    autocmd Filetype * if &ft isnot 'python' | imap <c-space> <Plug>(asyncomplete_force_refresh) | endif
augroup END


function! s:exists_source(name) abort
    return !empty(globpath(&rtp, printf('autoload/asyncomplete/sources/%s.vim', a:name)))  
endfunction

augroup asynctomplete_setup

    if <SID>exists_source('neosnippet')
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
        \   'name': 'neosnippet',
        \   'whitelist': ['*'],
        \   'blacklist': ['lisp', 'python'],
        \   'completor': function('asyncomplete#sources#neosnippet#completor'),
        \ }))
    endif

    if <SID>exists_source('necosyntax')
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
        \   'name': 'necosyntax',
        \   'whitelist': ['*'],
        \   'blacklist': ['python', 'lisp'],
        \   'completor': function('asyncomplete#sources#necosyntax#completor'),
        \ }))
    endif

    if <SID>exists_source('necovim')
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
        \   'name': 'necovim',
        \   'whitelist': ['vim'],
        \   'completor': function('asyncomplete#sources#necovim#completor'),
        \ }))
    endif

    if <SID>exists_source('omni')
        " python は jedi の補完を使いたいため
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
        \   'name': 'omni',
        \   'whitelist': ['sql', 'lisp'],
        \   'blacklist': ['c', 'cpp', 'html', 'python'],
        \   'completor': function('asyncomplete#sources#omni#completor')
        \ }))
    endif

    if <SID>exists_source('buffer')
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \   'name': 'buffer',
        \   'whitelist': ['*'],
        \   'blacklist': ['lisp', 'python'],
        \   'completor': function('asyncomplete#sources#buffer#completor'),
        \   'config': {
        \      'max_buffer_size': 100000,
        \   },
        \ }))
    endif

augroup END
