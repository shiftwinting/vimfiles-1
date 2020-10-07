scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/deoplete.vim'))
    finish
endif

inoremap <expr><C-Space> deoplete#refresh()

" refresh_always: チラツキ防止
" yarp: nvim-yarp の機能を使う
call deoplete#custom#option({
\   'smart_case': v:true,
\   'num_processes': 4,
\   'refresh_always': v:false,
\   'min_pattern_length': 1,
\   'yarp': v:true,
\   'auto_refresh_delay': 10,
\})

call deoplete#custom#source('buffer', 'rank', 9999)

call deoplete#custom#source('_', 'converters', [
\   'converter_remove_paren'
\])

call deoplete#custom#var('omni', 'functions', {
\   'c': ['lsp#complete']
\})

call deoplete#custom#option('omni_patterns', {
\   'c': ['[^. *\t]\%(\.\|->\)\w*'],
\   'cpp': ['[^. *\t]\%(\.\|->\)\w*', '[a-zA-Z_]\w*::'],
\})