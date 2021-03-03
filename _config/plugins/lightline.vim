scriptencoding utf-8
UsePlugin 'lightline.vim'

let g:lightline = {}
let s:colors = [
\   ['^gruvbox', 'gruvbox_material']
\]

for s:color in s:colors
    if get(g:, 'colors_name', '') =~# s:color[0]
        let g:lightline.colorscheme = s:color[1]
    endif
endfor

let g:lightline.tabline = {
\   'left': [ ['tabs'] ],
\   'right': [ [] ],
\}

" \             [ 'coc_errors', 'coc_warnings', 'coc_ok'],
let g:lightline.active = {
\   'left': [ [ 't_mode', 'paste'],
\             [ 'readonly', 't_filename' ],
\   ],
\   'right': [[ 't_filetype', 't_percent', 't_lineinfo' ]]
\}

let g:lightline.inactive = {
\   'left': [ [ 't_inactive_mode', 't_filename' ] ],
\   'right': [ [ 't_percent', 't_lineinfo' ] ],
\}

" let g:lightline.separator = {
" \   'left': '󾂰',
" \   'right': '󾂲'
" \}
let g:lightline.subseparator = {
\   'left': '',
\   'right': '|'
\}
let g:lightline.mode_map = {
\   'n':        'N',
\   'i':        'I',
\   'R':        'R',
\   'v':        'V',
\   'V':        'V-L',
\   "\<C-v>":   'V-B',
\   'c':        'C',
\   's':        'S',
\   'S':        'S-L',
\   "\<C-s>":   'S-B',
\   't':        'T',
\}

function! VisibleRightComponent() abort
    return winwidth('.') > 70 &&
    \       &filetype !~# '\v^zsh|deoledit'
endfunction

let g:lightline.component_function = {
\   't_mode': 'L_mode',
\   't_filename': 'L_filename',
\   't_filetype': 'L_filetype',
\   't_fileencoding': 'L_fileEncoding',
\   't_fileformat': 'L_fileFileFormat',
\   't_percent': 'L_percent',
\   't_lineinfo': 'L_lineinfo',
\   't_inactive_mode': 'L_inactiveMode',
\}

function! L_mode() abort
    return lightline#mode()
endfunction

function! L_filename() abort
    " 無名ファイルは %:t が '' となる
    return &filetype ==# 'qf' ? '[QuickFix]' :
    \       &filetype ==# 'deoledit' ? fnamemodify(getcwd(), ':~') :
    \       (expand('%:t') !=# '' ? expand('%:t') : 'No Name') . (&modifiable && &modified ? '[+]' : '')
endfunction

function! L_filetype()
    return  VisibleRightComponent() ?
    \       (strlen(&filetype) ? &filetype : 'no ft') :
    \       ''
endfunction

function! L_fileEncoding()
    return  VisibleRightComponent() ?
    \       (&fileencoding !=# '' ? &fileencoding : &fileencoding) :
    \       ''
endfunction

function! L_fileFileFormat()
    return  VisibleRightComponent() ?
    \       &fileformat :
    \       ''
endfunction

function! L_percent()
    return  VisibleRightComponent() ?
    \       printf('%3d', line('.') * 100 / line('$')) . '%' :
    \       ''
endfunction

function! L_lineinfo() abort
    return  VisibleRightComponent() ?
    \       line('.') . ':' . printf('%-3d', col('.')) :
    \       ''
endfunction

function! L_inactiveMode() abort
    return &filetype ==# 'denite-filter' ? 'FILTER' :
    \       &filetype ==# 'denite' ? 'Denite' :
    \       ''
endfunction

