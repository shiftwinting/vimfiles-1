scriptencoding utf-8

let g:Lf_FilerShowPromptPath = 1

let g:Lf_FilerUseDefaultNormalMap = 0
let g:Lf_FilerNormalMap = {
\   'h':             'open_parent',
\   'l':             'open_current',
\   '<C-h>':         'open_parent',
\   '<C-l>':         'open_current',
\   '.':             'toggle_hidden_files',
\   '~':             'goto_root_marker_dir',
\   'j':             'down',
\   'k':             'up',
\   '<F1>':          'toggle_help',
\   '<Tab>':         'switch_insert_mode',
\   'i':             'switch_insert_mode',
\   'p':             'preview',
\   'q':             'quit',
\   '<C-q>':         'quit',
\   '<C-e>':         'quit',
\   '<C-c>':         'quit',
\   'o':             'accept',
\   '<CR>':          'accept',
\   '<C-s>':         'accept_horizontal',
\   '<C-v>':         'accept_vertical',
\   '<C-t>':         'accept_tab',
\   '<Esc>':         'close_preview_popup',
\   'S':             'add_selections',
\   '<C-a>':         'select_all',
\   '<F3>':          'clear_selections',
\   'K':             'mkdir',
\   'R':             'rename',
\   'C':             'copy',
\   'P':             'paste',
\   'N':             'create_file',
\   '@':             'change_directory',
\   'H':             'history_back',
\   'L':             'history_forward',
\}

let g:Lf_FilerUseDefaultInsertMap = 0
let g:Lf_FilerInsertMap = {
\   '<C-h>':        'open_parent_or_backspace',
\   '<C-l>':        'open_current',
\   '<Esc>':        'quit',
\   '<CR>':         'accept',
\   '<C-s>':        'accept_horizontal',
\   '<C-v>':        'accept_vertical',
\   '<C-t>':        'accept_tab',
\   '<C-r>':        'toggle_regex',
\   '<BS>':         'backspace',
\   '<C-w>':        'delete_left_word',
\   '<C-u>':        'clear_line',
\   '<C-o>':        'paste',
\   '<C-j>':        'down',
\   '<C-k>':        'up',
\   '<C-p>':        'prev_history',
\   '<C-n>':        'next_history',
\   '<Tab>':        'switch_normal_mode',
\   '<C-b>':        'left',
\   '<C-f>':        'right',
\   '<C-a>':        'home',
\   '<C-e>':        'end',
\}

" let g:Lf_NormalMap = {
" \   "Filer": [
" \      ['m', ':call Lf_filer_context_menu()<CR>']
" \   ],
" \}
"
" function! Lf_filer_context_menu() abort
"     exec g:Lf_py "from filerExpl import *"
"     let l:commands = ['create_file', 'mkdir', 'rename', 'copy', 'paste']
"     let l:selection = confirm('Action?', "New &file\n&New Directory\n&Rename\n&Copy\n&Paste")
"     silent exe 'redraw'
"     exec printf('exec g:Lf_py "filerExplManager.do_command(''%s'')"', l:commands[l:selection - 1])
" endfunction
