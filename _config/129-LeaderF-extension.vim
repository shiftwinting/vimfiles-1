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
    nnoremap <silent> <Space>;t :<C-u>Leaderf sonictemplate --popup<CR>
endif
