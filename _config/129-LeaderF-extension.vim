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
" git checkout
function! LfExt_git_checkout_source(args) abort
    let l:source = filter(systemlist('git branch'), 'v:val[0] !=# "*"')
    if empty(source)
        echohl ErrorMsg
        echo 'no other branch'
        echohl None
        return []
    endif
    return l:source
endfunction

function! LfExt_git_checkout_accept(line, args) abort
    call system('git checkout ' . a:line)
endfunction
" ============================================================================

" ============================================================================
" mrw
function! LfExt_mrw_source(args) abort
    return mrw#read_cachefile(expand('%'))
endfunction

function! LfExt_mew_accept(line, args) abort
    exec 'drop ' . a:line
endfunction
" ============================================================================

let g:Lf_Extensions = {}

let g:Lf_Extensions.packadd = {
\   'source': 'LfExt_packadd_source',
\   'accept': 'LfExt_packadd_accept',
\}
command! Tpackadd Leaderf packadd

let g:Lf_Extensions.git_checkout = {
\   'source': 'LfExt_git_checkout_source',
\   'accept': 'LfExt_git_checkout_accept',
\}
command! LfGitCheckout Leaderf git_checkout --popup

let g:Lf_Extensions.mrw = {
\   'source': 'LfExt_mrw_source',
\   'accept': 'LfExt_mrw_accept',
\}
