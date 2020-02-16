scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf/Filer.vim'))
    finish
endif

let g:Lf_FilerShowDevIcons = 1

let g:Lf_FilerUseDefaultNormalMap = 0
let g:Lf_FilerNormalMap = {
\   'h':             'open_parent',
\   'l':             'open_current',
\   '<C-h>':         'open_parent',
\   '<C-l>':         'open_current',
\   '<C-f>':         'toggle_hidden_files',
\   '<C-g>':         'goto_root_marker_dir',
\   'j':             'down',
\   'k':             'up',
\   '<F1>':          'toggle_help',
\   '<Tab>':         'switch_insert_mode',
\   'i':             'switch_insert_mode',
\   'p':             'preview',
\   'q':             'quit',
\   '<C-q>':         'quit',
\   '<C-e>':         'quit',
\   'o':             'accept',
\   '<CR>':          'accept',
\   '<C-s>':         'accept_horizontal',
\   '<C-v>':         'accept_vertical',
\   '<C-t>':         'accept_tab',
\   '<Esc>':         'close_preview_popup',
\}

let g:Lf_FilerUseDefaultInsertMap = 0
let g:Lf_FilerInsertMap = {
\   '<C-h>':        'open_parent',
\   '<C-l>':        'open_current',
\   '<C-f>':        'toggle_hidden_files',
\   '<C-g>':        'goto_root_marker_dir',
\   '<C-e>':        'quit',
\   '<Esc>':        'quit',
\   '<CR>':         'accept',
\   '<C-s>':        'accept_horizontal',
\   '<C-v>':        'accept_vertical',
\   '<C-t>':        'accept_tab',
\   '<C-r>':        'toggle_regex',
\   '<BS>':         'backspace',
\   '<C-w>':        'delete_left_word',
\   '<C-o>':        'paste',
\   '<C-j>':        'down',
\   '<C-k>':        'up',
\   '<C-p>':        'prev_history',
\   '<C-n>':        'next_history',
\   '<C-q>':        'preview',
\   '<Tab>':        'switch_normal_mode',
\}

let g:Lf_NormalMap = get(g:, 'Lf_NormalMap', {})
let g:Lf_NormalMap = {'Filer':   [['B', ':LeaderfBookmark<CR>']]}
