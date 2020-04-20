scriptencoding utf-8

let s:aliases = []

" setlocal completefunc=CompleteGitAlias
function! tmg#git#aliases#complete(findstart, base) abort
    if a:findstart
        return matchstrpos(getline('.'), '^\s*git ')[2]
    else
        let l:res = []
        for l:line in filter(copy(s:get_aliases()), 'v:val =~# "^". a:base')
            let l:matches = matchlist(l:line, '\v^(\S+) (.*)')
            if !empty(l:matches)
                let [l:word, l:info] = l:matches[1:2]
                call add(l:res, {
                \   'word': l:word,
                \   'info': l:info,
                \})
            endif
        endfor
        return l:res
    endif
endfunction

function! s:get_aliases() abort
    if empty(s:aliases)
        let s:aliases = map(systemlist('git config --get-regexp "^alias\."'), 'v:val[6:]')
    endif
    return s:aliases
endfunction
