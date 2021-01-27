scriptencoding utf-8
UsePlugin 'lightline.vim'

let g:lightline = {}
let s:colors = [
\   ['^solarzed8', 'solarized'],
\   ['one', 'one'],
\   ['nord', 'nord'],
\   ['iceberg', 'iceberg'],
\   ['palenight', 'palenight'],
\   ['ayu', 'tender'],
\   ['^gruvbox', 'gruvbox_material']
\]

for s:color in s:colors
    if get(g:, 'colors_name', '') =~# s:color[0]
        let g:lightline.colorscheme = s:color[1]
    endif
endfor

" if g:colors_name =~# '^solarzed8'
"     let g:lightline.colorscheme = 'solarized'
" elseif g:colors_name ==# 'one'
"     let g:lightline.colorscheme = 'one'
" elseif g:colors_name ==# 'nord'
"     let g:lightline.colorscheme = 'nord'
" endif

let g:lightline.tabline = {
\   'left': [ ['tabs'] ],
\   'right': [ [] ],
\}

" \             [ 'coc_errors', 'coc_warnings', 'coc_ok'],
let g:lightline.active = {
\   'left': [ [ 't_mode', 'paste'],
\             [ 'readonly', 't_filename' ],
\             [ 't_gitbranch', 't_gitfetch' ],
\             [ 't_browsersync', 't_sasswatch'],
\   ],
\   'right': [ [ 't_lineinfo' ],
\              [ 't_percent' ],
\              [ 't_filetype', 't_fileencoding', 't_fileformat' ]]
\}

let g:lightline.inactive = {
\   'left': [ [ 't_inactive_mode', 't_filename' ] ],
\   'right': [ [ 't_lineinfo' ,'t_percent' ] ],
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

" let g:lightline#coc#indicator_warnings = nr2char('0xf071')  " 
" let g:lightline#coc#indicator_errors = nr2char('0xffb8a')   " 󿮊
" let g:lightline#coc#indicator_ok = nr2char('0xf00c')        " 

" call lightline#coc#register()

function! VisibleRightComponent() abort
    return winwidth('.') > 70 &&
    \       &filetype !~# '\v^zsh|vaffle'
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
\   't_gitbranch': 'L_gitBranch',
\   't_eskk_mode': 'L_sKKMode',
\   't_gitfetch': 'gitstatus#fetch_status',
\   't_browsersync': 'L_browserSync',
\   't_sasswatch': 'L_sassWatch',
\}

function! L_mode() abort
    return &filetype ==# 'vaffle' ? 'Vaffle' :
    \       lightline#mode()
endfunction

function! L_filename() abort
    " 無名ファイルは %:t が '' となる
    return &filetype ==# 'molder' ? '[MOLDER] ' . expand('%:t') :
    \       &filetype ==# 'qf' ? '[QuickFix]' :
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

function! L_gitBranch() abort
    return exists('*FugitiveHead') && !empty(FugitiveHead())  ? ''.FugitiveHead() : ''
endfunction

function! L_browserSync() abort
    " return !empty(browsersync#port()) ? '󿤺:'.browsersync#port() : ''
    if !exists('*browsersync#port') | return '' | endif
    return !empty(browsersync#port()) ? ':'.browsersync#port() : ''
endfunction

function! L_sassWatch() abort
    if !exists('*sasswatch#is_watching') | return '' | endif
    return sasswatch#is_watching(expand('%:p')) ? '' : ''
endfunction

