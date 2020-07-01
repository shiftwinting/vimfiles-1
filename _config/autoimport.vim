scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/autoimport.vim'))
    finish
endif

" augroup MyAutoImport
"     autocmd!
"     autocmd User ALELintPost if &ft ==# 'python' | call <SID>autoimport() | endif
" augroup END

command! AutoImport call <SID>autoimport()

function! s:autoimport() abort
    augroup MyAutoImport
        autocmd!
        autocmd User ALELintPost ++once if &ft ==# 'python' | call <SID>import_symbol() | endif
    augroup END

    ALELint
endfunction

function! s:import_symbol() abort
    let l:loclist = getloclist(winnr())
    if len(l:loclist) == 0
        return
    endif
    for l:info in l:loclist
        let l:module = matchstr(l:info['text'], '\v^F821: undefined name ''\zs(\w+)\ze''$')
        unsilent echomsg l:info['text'] l:module
        if !empty(l:module)
            exec 'ImportSymbol ' . l:module
        endif
    endfor
endfunction
