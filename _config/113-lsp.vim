scriptencoding utf-8

finish

" デバッグ
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" from https://gist.github.com/mattn/3c65639710016d662701bb2526ecba55
" mattn さんの lsp の設定

" if executable('pyls')
"     " pip install python-language-server
"     augroup MyLspPython
"         autocmd!
"         autocmd User lsp_setup call lsp#register_server({
"             \ 'name': 'pyls',
"             \ 'cmd': {server_info->[&shell, &shellcmdflag, 'pyls']},
"             \ 'whitelist': ['python'],
"             \ })
"         autocmd FileType python call s:configure_lsp()
"     augroup END
" endif
"

if executable('nimlsp')
    augroup MyLspNim
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'nimlsp',
        \   'cmd': {server_info->[&shell, &shellcmdflag, 'nimlsp C:\\nim\\nim-1.0.2']},
        \   'whitelist': ['nim'],
        \})
        autocmd FileType nim call s:configure_lsp()
    augroup END
endif


if executable('typescript-language-server')
    augroup MyLspTypeScript
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'typescript-language-server',
        \   'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \   'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \   'whitelist': ['typescript', 'javasript'],
        \})
        autocmd FileType javascript.typescript setlocal omnifunc=lsp#complete
    augroup END
endif

" if executable('html-languageserver')
"     " pip install python-language-server
"     augroup MyLspHTML
"         au!
"         autocmd User lsp_setup call lsp#register_server({
"         \   'name': 'html-languageserver',
"         \   'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
"         \   'whitelist': ['html'],
"         \})
"         autocmd FileType html call s:configure_lsp()
"     augroup END
" endif

" " from https://gist.github.com/yaegassy/57e50125e9c6488581c4b8fe608ce194
" if executable('vls')
"     " npm i -g vue-language-server
"     " [vetur/server at master · vuejs/vetur https://github.com/vuejs/vetur/tree/master/server]
"     augroup MyLspVue
"         autocmd!
"         autocmd User lsp_setup call lsp#register_server({
"         \   'name': 'vue-language-server',
"         \   'cmd': {server_info->[&shell, &shellcmdflag, 'vls']},
"         \   'whitelist': ['vue'],
"         \   'initialization_options': {
"         \       'config': {
"         \           'html': {},
"         \            'vetur': {
"         \                'validation': {}
"         \            }
"         \       }
"         \   }
"         \})
"     augroup END
" endif

function! s:configure_lsp() abort
    " omnifunc を設定
    setlocal omnifunc=lsp#complete

    nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
    nnoremap <buffer><silent> <Space>;r    :<C-u>LspReferences<CR>
    nnoremap <buffer><silent> K     :<C-u>LspHover<CR>

    nnoremap <buffer> gj    :<C-u>LspNextError<CR>
    nnoremap <buffer> gk    :<C-u>LspPreviousError<CR>
    nnoremap <buffer><silent> <Space>;a    :<C-u>LspCodeAction<CR>

endfunction
"" sign の表示を無効化 ( mint で行うため )
let g:lsp_diagnostics_enabled = 0

let g:lsp_settings_servers_dir = expand("~/lsp_server")

augroup MyLspSettings
    autocmd!
    autocmd FileType html,python,vim call s:configure_lsp()
augroup END
