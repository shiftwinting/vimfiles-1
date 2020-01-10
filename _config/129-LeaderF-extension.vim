scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf.vim'))
    finish
endif

" 書き方は以下を参照
" * https://github.com/Yggdroot/LeaderF/issues/144#issuecomment-540008950
" * http://bit.ly/2NdiX1x

" ============================================================================
" packadd
function! LfExt_packadd_source(args) abort
    let l:result = []
    for path in split(globpath(&packpath, '/pack/*/opt/*'))
        if isdirectory(path)
            call add(l:result, fnamemodify(path, ':t'))
        endif
    endfor
    return l:result
endfunction

function! LfExt_packadd_accept(line, args) abort
    execute 'packadd '.a:line
endfunction
" ============================================================================

" ============================================================================
" sonictemplate
function! LfExt_sonictemplate_source(args) abort
    return sonictemplate#complete('', '', '')
endfunction

function! LfExt_sonictemplate_accept(line, args) abort
    execute 'Template '.a:line
endfunction
" ============================================================================

" ============================================================================
" openbrowser

" ブックマーク
" g:openbrowser_bookmarks = { name: url }

" TODO: 辞書ではなく、リストに変換したい
" engines と bookmarks で name が重複する可能性があるため
function! LfExt_openbrowser_source(args) abort
    let l:openbrowser_bookmarks = get(g:, 'openbrowser_bookmarks', {})
    let l:bookmarks =
    \       extend(copy(g:openbrowser_search_engines), l:openbrowser_bookmarks)
    let l:max_name_len =
    \       max(map(keys(l:openbrowser_bookmarks),'strdisplaywidth(v:val)'))

    let l:lines = []
    for [l:name, l:url] in items(l:bookmarks)
        let l:space_num = l:max_name_len - strdisplaywidth(l:name)
        let l:lines = add(l:lines,
        \       printf('%s%s "%s"',l:name, repeat(' ', l:space_num), l:url))
    endfor

    return l:lines
endfunction

function! LfExt_openbrowser_accept(line, args) abort
    let l:name = s:openbrowser_get_digest(a:line, 1)
    let l:url = s:openbrowser_get_digest(a:line, 2)

    " {query} が url に入っていたら、engine を入れる
    let l:engine = l:url =~# '{query}' ? printf('-%s ', l:name) : ' '
    call feedkeys(printf(':OpenBrowserSmartSearch %s', l:engine), 'n')
endfunction

" モードごとにマッチさせる文字列を返す
"     mode: 0, return the full path
"           1, return the name only
"           2, return the directory name
function! s:openbrowser_get_digest(line, mode) abort
    if a:mode ==# 0
        return a:line
    elseif a:mode ==# 1
        let l:start_pos = stridx(a:line, ' "')
        return trim(a:line[: l:start_pos])
    else
        let l:start_pos = stridx(a:line, ' "')
        return a:line[l:start_pos+2 : -2]
    endif
endfunction

" モードごとにマッチさせる開始位置を返す
"     mode: 0, return the full path
"           1, return the name only
"           2, return the directory name
function! s:openbrowser_get_digest_start_pos(line, mode) abort
    if a:mode ==# 2
        let l:start_pos = stridx(a:line, ' "')
        " バイトの長さを取得
        return strchars(a:line[: l:start_pos + 2])
    else
        return 0
    endif
endfunction

" リストを返す
" [マッチさせる文字列, 文字列内の開始位置 (バイト単位)]
function! LfExt_openbrowser_get_digest(line, mode) abort
    return [s:openbrowser_get_digest(a:line, a:mode),
    \       s:openbrowser_get_digest_start_pos(a:line, a:mode)]
endfunction

" ============================================================================

let g:Lf_Extensions = {}

let g:Lf_Extensions.packadd = {
\   'source': 'LfExt_packadd_source',
\   'accept': 'LfExt_packadd_accept',
\}
command! LeaderfPackAdd Leaderf packadd --popup

if !empty(globpath(&rtp, 'autoload/sonictemplate.vim'))
    let g:Lf_Extensions.sonictemplate = {
    \   'source': 'LfExt_sonictemplate_source',
    \   'accept': 'LfExt_sonictemplate_accept',
    \}

    command! LeaderfSonictemplate Leaderf sonictemplate
    nnoremap <silent> <Space>fi :<C-u>Leaderf sonictemplate --popup<CR>
endif

if !empty(globpath(&rtp, 'autoload/openbrowser.vim'))
    let g:Lf_Extensions.openbrowser = {
    \   'source': 'LfExt_openbrowser_source',
    \   'accept': 'LfExt_openbrowser_accept',
    \   'supports_name_only': 1,
    \   'get_digest': 'LfExt_openbrowser_get_digest',
    \   'highlights_def': {
    \       'Lf_hl_openbrowserUrl': '\s\+\zs".\+',
    \   },
    \   'highlights_cmd': [
    \       'hi link Lf_hl_openbrowserUrl Comment',
    \   ]
    \}

    command! LeaderfOpenBrowser Leaderf openbrowser
    nnoremap <silent> <A-o><A-o> :<C-u>Leaderf openbrowser --popup<CR>
endif
