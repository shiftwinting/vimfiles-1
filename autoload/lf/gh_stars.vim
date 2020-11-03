scriptencoding utf-8

let s:HTTP = vital#vital#import('Web.HTTP')
let s:JSON = vital#vital#import('Web.JSON')

let s:base_url = 'https://api.github.com'

" https://docs.github.com/en/free-pro-team@latest/rest/overview/resources-in-the-rest-api

" Accept について
"   https://docs.github.com/en/free-pro-team@latest/rest/overview/media-types#request-specific-version


function! lf#gh_stars#source(...) abort
    let l:url = s:base_url . '/user/starred?page=1&per_page=10'
    let l:res = s:HTTP.request('GET', l:url, {
    \   'headers': {
    \       'Accept': 'application/vnd.github.v3+json',
    \       'Authorization': 'token ' . $GH_TOKEN
    \   },
    \   'client': 'curl',
    \})
    if !l:res.success
        echohl ErrorMsg
        echomsg 'error'
        echohl
        return []
    endif
    return map(s:JSON.decode(l:res.content), 'v:val["full_name"]')
endfunction

function! lf#gh_stars#accept(line, args) abort
    call system('ghq get ' . a:line)
endfunction
