scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/tig_explorer.vim'))
    finish
endif

" nnoremap <Space>gs :<C-u>TigOpenProjectRootDir<CR>
"
" " default のまま
" let g:tig_explorer_keymap_edit    = '<C-o>'
" let g:tig_explorer_keymap_tabedit = '<C-t>'
" let g:tig_explorer_keymap_split   = '<C-s>'
" let g:tig_explorer_keymap_vsplit  = '<C-v>'
