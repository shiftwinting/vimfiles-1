scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/quickrun.vim'))
    finish
endif

let g:lightline = {}

let g:lightline.colorscheme = 'solarized'

let g:lightline.tabline = {
\   'left': [ ['tabs'] ],
\   'right': [ [] ],
\}

" \             [ 't_gitbranch' ]
let g:lightline.active = {
\   'left': [ [ 't_mode', 'paste'],
\             [ 'readonly', 't_filename' ],
\             [ 'linter_errors', 'linter_warnings', 'linter_ok' ],
\             [ 't_gitbranch' ],
\   ],
\   'right': [ [ 't_lineinfo' ],
\              [ 't_percent' ],
\              [ 't_filetype', 't_fileencoding', 't_fileformat' ]]
\}

let g:lightline.inactive = {
\   'left': [ [ 't_inactive_mode', 't_filename' ] ],
\   'right': [ [ 't_lineinfo' ],
\              [ 't_percent' ] ]
\}

let g:lightline.component_expand = {
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\}

" component_expand の色を設定?
let g:lightline.component_type = {
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'left',
\}

let g:lightline.separator = {
\   'left': '󾂰',
\   'right': '󾂲'
\}
let g:lightline.subseparator = {
\   'left': '󾂱',
\   'right': '󾂳'
\}

let g:lightline#ale#indicator_warnings = nr2char('0xf071')  " 
let g:lightline#ale#indicator_errors = nr2char('0xffb8a')   " 󿮊
let g:lightline#ale#indicator_ok = nr2char('0xf00c')        " 


function! VisibleRightComponent() abort
    return winwidth('.') > 70 &&
    \       &filetype !~# '\v^denite|^defx|deol|zsh|vaffle'
endfunction

let g:lightline.component_function = {
\   't_mode': 'LightlineMode',
\   't_filename': 'LightlineFilename',
\   't_filetype': 'LightlineFiletype',
\   't_fileencoding': 'LightlineFileEncoding',
\   't_fileformat': 'LightlineFileFileFormat',
\   't_percent': 'LightlinePercent',
\   't_lineinfo': 'LightlineLineinfo',
\   't_inactive_mode': 'LightlineInactiveMode',
\   't_gitbranch': 'LightlineGitBranch',
\   't_eskk_mode': 'LightlineSKKMode',
\}

function! LightlineMode() abort
    return &filetype ==# 'denite' ? 'Denite' :
    \       &filetype ==# 'denite-filter' ? 'FILTER' :
    \       &filetype ==# 'defx' ? 'Defx' :
    \       lightline#mode()
endfunction

function! LightlineFilename() abort
    " 無名ファイルは %:t が '' となる
    return &filetype ==# 'denite-filter' ? '' :
    \       &filetype ==# 'denite' ? denite#get_status('sources') :
    \       &filetype =~# 'defx' ? '' :
    \       (expand('%:t') !=# '' ? expand('%:t') : 'No Name') .
    \       (&modifiable && &modified ? '[+]' : '')
endfunction

function! LightlineFiletype()
    return  VisibleRightComponent() ?
    \       (strlen(&filetype) ? &filetype : 'no ft') :
    \       ''
endfunction

function! LightlineFileEncoding()
    return  VisibleRightComponent() ?
    \       (&fileencoding !=# '' ? &fileencoding : &fileencoding) :
    \       ''
endfunction

function! LightlineFileFileFormat()
    return  VisibleRightComponent() ?
    \       &fileformat :
    \       ''
endfunction

function! LightlinePercent()
    return  VisibleRightComponent() ?
    \       printf('%3d', line('.') * 100 / line('$')) . '%' :
    \       ''
endfunction

function! LightlineLineinfo() abort
    return  VisibleRightComponent() ?
    \       line('.') . ':' . printf('%-3d', col('.')) :
    \       ''
endfunction

function! LightlineInactiveMode() abort
    return &filetype ==# 'denite-filter' ? 'FILTER' :
    \       &filetype ==# 'denite' ? 'Denite' :
    \       ''
endfunction

function! LightlineGitBranch() abort
    return exists('*FugitiveHead') && !empty(FugitiveHead())  ? ''.FugitiveHead() : ''
endfunction

