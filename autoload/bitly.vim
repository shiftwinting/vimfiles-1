scriptencoding utf-8

" bitly を使って URL を短くする
" https://dev.bitly.com/v4_documentation.html

let s:HTTP = vital#vital#import('Web.HTTP')
let s:JSON = vital#vital#import('Web.JSON')
let s:base_url = 'https://api-ssl.bitly.com/v4'

let s:default_token = '4c0464b927dc17e9c824ca0f2e01695adf3d26cc'
let s:use_default_token = get(g:, 'bitly#use_default_token', 1)

function! s:get_groupid(token) abort
    let l:url = s:base_url . '/groups'
    let l:res = s:HTTP.request('GET', l:url, {
    \   'headers': {
    \       'Host': 'api-ssl.bitly.com',
    \       'Accept': 'application/json',
    \       'Authorization': 'Bearer '.a:token,
    \   },
    \})
    if !l:res.success
        echohl ErrorMsg
        echomsg '[bitly.vim] Could not get group id.'
        echohl
        return -1
    endif
    return s:JSON.decode(l:res.content)['groups'][0]['guid']
endfunction

function! s:get_shorten_url(token, groupid, long_url) abort
    let l:url = s:base_url . '/shorten'
    let l:res = s:HTTP.request('POST', l:url, {
    \   'headers': {
    \       'Host': 'api-ssl.bitly.com',
    \       'Authorization': 'Bearer '.a:token,
    \       'Content-Type': 'application/json',
    \   },
    \   'data': s:JSON.encode({
    \       'group_guid': a:groupid,
    \       'long_url': a:long_url,
    \   }),
    \   'client': 'curl'
    \})
    if !l:res.success
        echohl ErrorMsg
        echomsg '[bitly.vim] Could not shorten url.'
        echohl
        return ''
    endif
    return s:JSON.decode(l:res.content)['link']
endfunction

function! bitly#shorten_url(long_url) abort
    if s:use_default_token
        let l:token = s:default_token
    elseif exists('$BITLY_TOKEN')
        let l:token = $BITLY_TOKEN
    elseif !exists('$BITLY_TOKEN')
        echohl ErrorMsg
        echomsg '[bitly.vim] Set bitly#use_default_tokenSet to 1 or set the environment variable $BITLY_TOKEN.'
        echomsg 'See https://dev.bitly.com/v4_documentation.html'
        echohl
        return
    endif

    let l:groupid = s:get_groupid(l:token)
    if l:groupid == -1
        return
    endif

    let l:short_url = s:get_shorten_url(l:token, l:groupid, a:long_url)
    if l:short_url ==# ''
        return
    endif
    return l:short_url
endfunction

