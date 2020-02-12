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
\   '~':             'goto_root_marker_dir',
\   '.':             'toggle_hidden_files',
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
\   '<C-Up>':        'page_up_in_preview',
\   '<C-Down>':      'page_down_in_preview',
\   '<Esc>':         'close_preview_popup',
\}

let g:Lf_FilerUseDefaultInsertMap = 0
let g:Lf_FilerInsertMap = {
\   '<C-h>':        'open_parent',
\   '<C-l>':        'open_current',
\   '<C-y>':        'toggle_hidden_files',
\   '<C-g>':        'goto_root_marker_dir',
\   '<Esc>':        'quit',
\   '<C-c>':        'quit',
\   '<C-e>':        'quit',
\   '<CR>':         'accept',
\   '<C-s>':        'accept_horizontal',
\   '<C-v>':        'accept_vertical',
\   '<C-t>':        'accept_tab',
\   '<C-r>':        'toggle_regex',
\   '<BS>':         'backspace',
\   '<C-u>':        'clear_line',
\   '<C-w>':        'delete_left_word',
\   '<C-d>':        'delete',
\   '<C-o>':        'paste',
\   '<C-b>':        'left',
\   '<C-f>':        'right',
\   '<C-j>':        'down',
\   '<C-k>':        'up',
\   '<C-p>':        'prev_history',
\   '<C-n>':        'next_history',
\   '<C-q>':        'preview',
\   '<Tab>':        'switch_normal_mode',
\   '<C-Up>':       'page_up_in_preview',
\   '<C-Down>':     'page_down_in_preview',
\   '<ScroollWhellUp>': 'up3',
\   '<ScroollWhellDown>': 'down3',
\}
