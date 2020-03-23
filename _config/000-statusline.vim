scriptencoding utf-8

finish

augroup StatusLine
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
    autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
augroup END


function! s:hi(group, fg, bg, attr, bang=v:false) abort
    let l:bang = a:bang ? '!' : ''
    exec printf('hi%s %s guifg=%s guibg=%s gui=%s', l:bang, a:group, a:fg, a:bg, a:attr)
endfunction


" from lightline one.vim
let s:blue   = '#61afef'
let s:green  = '#98c379'
let s:purple = '#c678dd'
let s:red1   = '#e06c75'
let s:red2   = '#be5046'
let s:yellow = '#e5c07b'

let s:fg     = '#494b53'

let s:glay2  = '#f0f0f0'
let s:glay3  = '#d0d0d0'

" group, fg, bg, attr
call s:hi('Base',     '#494b53', s:glay2, 'none')
call s:hi('Filename_stl', '#494b53', s:glay3, 'none')

" mode() : [表示, highlightの種類]
let g:stl_mode_map = {
\   'n':      ['N ',   'N'],
\   'i':      ['I ',   'I'],
\   'R':      ['R ',   'R'],
\   'v':      ['V ',   'V'],
\   'V':      ['V-L ', 'V'],
\   "\<C-v>": ['V-B ', 'V'],
\   'c':      ['C ',   'C'],
\   's':      ['S ',   'S'],
\   'S':      ['S-L ', 'S'],
\   "\<C-s>": ['S-B ', 'S'],
\   't':      ['T ',   'T'],
\}

" =============================
" active
" =============================
function! ActiveLine() abort
    let l:statusline = ""

    " %#ハイライト# % とするとハイライトでカラーリングされる
    " %{関数()} とすると実行した結果が設定される

    let l:statusline .= "%#Base#"

    " モード
    let l:statusline .= "%#Mode# %{ModeCurrent_stl()}"

    " ファイル名
    let l:statusline .= "%#Filename_stl# %{Filename_stl()} "

    let l:statusline .= "%#Base#"
    " git
    let l:statusline .= " %{GitInfo_stl()}"

    " browsersync
    let l:statusline .= " %{BrowserSync_stl()}"

    " sass watch
    let l:statusline .= " %{SassWatch_stl()}"

    " --------------------
    " 区切り
    " --------------------
    let l:statusline .= "%#Base#"
    let l:statusline .= "%="

    let l:statusline .= "%{Filetype_stl()}"

    let l:statusline .= " %{FileFormat_stl()}"
    let l:statusline .= " %{FileEncoding_stl()} "

    let l:statusline .= "%#LineInfo#"
    let l:statusline .= " %{Percent_stl()}"
    let l:statusline .= " : %{LineInfo_stl()}"

    return l:statusline
endfunction


" =============================
" inactive
" =============================
function! InactiveLine() abort
    let l:statusline = ""
    return l:statusline
endfunction


" =============================
" mode
" =============================
function! ModeCurrent_stl() abort
    let l:mode = mode()
    let l:mode_info = get(g:stl_mode_map, l:mode, ['? ', 'NMode'])
    let l:mode_str = toupper(l:mode_info[0])
    let l:mode_hi = l:mode_info[1]

    " ハイライトを変える
    let l:bg = ''

    if l:mode_hi ==# 'N'
        let l:bg = s:green
    elseif l:mode_hi ==# 'I'
        let l:bg = s:blue
    elseif l:mode_hi ==# 'V'
        let l:bg = s:purple
    elseif l:mode_hi ==# 'S'
        let l:bg = s:purple
    elseif l:mode_hi ==# 'T'
        let l:bg = s:blue
    endif

    call s:hi('Mode', '#f0f0f0', l:bg,  'bold', v:true)
    call s:hi('LineInfo', '#fefefe', l:bg,  'bold', v:true)

    return l:mode_str
endfunction


" =============================
" git
" =============================
function! GitInfo_stl() abort
    let l:branch = exists('*FugitiveHead') && !empty(FugitiveHead())  ? ''.FugitiveHead() : ''
    if empty(l:branch)
        return ''
    endif

    let l:fetch_info = gitstatus#fetch_status()

    return l:branch . ' '. gitstatus#fetch_status()
endfunction


" =============================
" browsersync
" =============================
function! BrowserSync_stl() abort
    " return !empty(browsersync#port()) ? '󿤺:'.browsersync#port() : ''
    if !exists('*browsersync#port') | return '' | endif
    return !empty(browsersync#port()) ? ':'.browsersync#port() : ''
endfunction


" =============================
" Filename:
" =============================
function! Filename_stl() abort
    " 無名ファイルは %:t が '' となる
    let l:icon = exists('*WebDevIconsGetFileTypeSymbol') ? trim(WebDevIconsGetFileTypeSymbol()) : ''
    return (expand('%:t') !=# '' ? l:icon . expand('%:t') : l:icon . 'No Name') .
    \       (&modifiable && &modified ? '[+]' : '')
endfunction


" =============================
" SassWatch:
" =============================
function! SassWatch_stl() abort
    if !exists('*sasswatch#is_watching') | return '' | endif
    return sasswatch#is_watching(expand('%:p')) ? '' : ''
endfunction


" =============================
" Filetype:
" =============================
function! Filetype_stl()
    return empty(&filetype) ? 'no ft' : &filetype
endfunction


" =============================
" FileEncoding:
" =============================
function! FileEncoding_stl()
    return empty(&fileencoding) ? '' : &fileencoding
endfunction


" =============================
" Fileformat:
" =============================
function! FileFormat_stl()
    return exists('*WebDevIconsGetFileFormatSymbol') ? trim(WebDevIconsGetFileFormatSymbol()) :
    \       empty(&fileformat) ? '' : &fileformat
endfunction


" =============================
" Percent:
" =============================
function! Percent_stl()
    return printf('%3d', line('.') * 100 / line('$')) . '%'
endfunction


" =============================
" LineInfo:
" =============================
function! LineInfo_stl() abort
    return line('.') . '/' . line('$') . ' : ' . printf('%-3d', col('.'))
endfunction
