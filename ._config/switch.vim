scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/switch.vim'))
    finish
endif


let g:switch_mapping = ''

nnoremap <Space>n  :<C-u>Switch<CR>

" let g:switch_custom_definitions =
"     \ [
"     \   ['pick', 'squash', 'fixup', 'edit'],
"     \   ['->', '<-']
"     \ ]
