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

let g:lightline.active = {
\   'left': [ [ 't_mode', 'paste'],
\             [ 'readonly', 't_filename' ],
\             [ 'coc_errors', 'coc_warnings', 'coc_ok'],
\             [ 't_gitbranch', 't_gitfetch' ],
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

let g:lightline.separator = {
\   'left': '󾂰',
\   'right': '󾂲'
\}
let g:lightline.subseparator = {
\   'left': '',
\   'right': ''
\}

let g:lightline#coc#indicator_warnings = nr2char('0xf071')  " 
let g:lightline#coc#indicator_errors = nr2char('0xffb8a')   " 󿮊
let g:lightline#coc#indicator_ok = nr2char('0xf00c')        " 

call lightline#coc#register()

function! VisibleRightComponent() abort
    return winwidth('.') > 70 &&
    \       &filetype !~# '\v^zsh|vaffle'
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
\   't_gitfetch': 'gitstatus#fetch_status'
\}

function! LightlineMode() abort
    return &filetype ==# 'vaffle' ? 'Vaffle' :
    \       lightline#mode()
endfunction

function! LightlineFilename() abort
    " 無名ファイルは %:t が '' となる
    return (expand('%:t') !=# '' ? expand('%:t') : 'No Name') .
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
