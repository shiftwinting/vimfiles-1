scriptencoding utf-8

" 書き方は以下を参照
" * https://github.com/Yggdroot/LeaderF/issues/144#issuecomment-540008950
" * http://bit.ly/2NdiX1x

" packadd
" git_switch
" mrw
" sonictemplate
" vim-nayvy
" ghq


let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})

function! s:func(func_name) abort
    " function('<SNR>476_sample_func') -> <SNR>476_sample_func
    return string(function(a:func_name))[10:-3]
endfunction

" ============================================================================
" packadd
" ============================================================================
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

let g:Lf_Extensions.packadd = {
\   'source': 'LfExt_packadd_source',
\   'accept': 'LfExt_packadd_accept',
\}
command! Tpackadd Leaderf packadd



" ============================================================================
" git switch
" ============================================================================
" ---------------------
" accept
" ---------------------
function! s:git_switch_accept(line, args) abort
    call system('git switch ' . a:line)
    echo printf(" Switched to branch '%s'", a:line)
endfunction

" ---------------------
" format_list
" ---------------------
function! s:git_switch_format_list(list, args) abort
    return filter(copy(a:list), 'v:val[0] !=# "*"')
endfunction

" ---------------------
" format_line
" ---------------------
function! s:git_switch_format_line(line, args) abort
    return trim(a:line)
endfunction

let g:Lf_Extensions.git_switch = {
\   'source': {'command': 'git branch'},
\   'accept':      s:func('s:git_switch_accept'),
\   'format_list': s:func('s:git_switch_format_list'),
\   'format_line': s:func('s:git_switch_format_line'),
\}
command! LfGitSwitch Leaderf git_switch --popup



" ============================================================================
" mrw
" ============================================================================

function! s:mrw_source(args) abort
    let l:files = mrw#read_cachefile(expand('%'))
    let l:result = []
    " from mrw.vim
    let l:max_filename_len = max(map(copy(l:files), {i,x -> strdisplaywidth(fnamemodify(x, ':p:t'))}) + [0])
    for l:file in l:files
        let l:name = fnamemodify(l:file, ':p:t')
        let l:space = l:max_filename_len - strdisplaywidth(l:name)
        call add(l:result, printf('%s%s "%s"', l:name, repeat(' ', l:space), fnamemodify(l:file, ':p:h')))
    endfor
    return l:result
endfunction

function! s:mrw_get_digest(line, mode) abort
    if a:mode ==# 0
        return [a:line, 0]
    elseif a:mode ==# 1
        let l:end = stridx(a:line, ' ')
        return [a:line[:l:end-1], 0]
    else
        let l:start = stridx(a:line, ' "')
        return [a:line[l:start+2: -1], strlen(a:line) - 1]
    endif
endfunction

function! s:mrw_accept(line, args) abort
    let l:path = s:mrw_get_digest(a:line, 2)[0][:-2]
    \           . '/'
    \           . s:mrw_get_digest(a:line, 1)[0]
    exec 'drop ' . l:path
endfunction

let g:Lf_Extensions.mrw = {
\   'source':     s:func('s:mrw_source'),
\   'accept':     s:func('s:mrw_accept'),
\   'get_digest': s:func('s:mrw_get_digest'),
\   'supports_name_only': 1,
\}


" " ============================================================================
" " todo
" " ============================================================================
" let s:todo_dict = {
" \   'cancel':           'call todo#ToggleMarkAsDone("Cancelled")',
" \   'done':             'call todo#ToggleMarkAsDone("")',
" \   'add_due':          "normal! A due:\<C-R>=strftime('%Y-%m-%d')\<CR>\<Esc>0"
" \}
"
" function! LfExt_todo_source(args) abort
"     return keys(s:todo_dict)
" endfunction
"
" function! LfExt_todo_accept(line, args) abort
"     silent execute s:todo_dict[a:line]
" endfunction
"
" let g:Lf_Extensions.todo = {
" \   'source': 'LfExt_todo_source',
" \   'accept': 'LfExt_todo_accept',
" \}



" ============================================================================
" sonictemplate
" ============================================================================
function! LfExt_sonictemplate_source(args) abort
    return sonictemplate#complete('', '', '')
endfunction

function! LfExt_sonictemplate_accept(line, args) abort
    execute 'Template '.a:line
endfunction

let g:Lf_Extensions.sonictemplate = {
\   'source': 'LfExt_sonictemplate_source',
\   'accept': 'LfExt_sonictemplate_accept',
\}




" ============================================================================
" vim-nayvy
" ============================================================================


if !empty(globpath(&rtp, 'autoload/nayvy.vim'))


py3 << EOF

import vim
from nayvy_vim_if import *

def nayvy_list_imports_no_color() -> List[str]:
    ''' List all available imports
    '''
    filepath = vim.eval('expand("%")')
    stmt_map = init_import_stmt_map(filepath)
    if stmt_map is None:
        return []
    return [
        single_import.to_line(color=False)
        for _, single_import in stmt_map.items()
    ]

EOF


function! LfExt_nayvy_source(args) abort
    return py3eval('nayvy_list_imports_no_color()')
endfunction


function! LfExt_nayvy_accept(line, args) abort
    let l:names = [split(a:line, ' : ')[0]]
    let l:py_expr = 'nayvy_import(' . string(l:names) . ')'
    call py3eval(l:py_expr)
endfunction


function! LfExt_nayvy_get_digest(line, mode) abort
    if a:mode ==# 0
        return [a:line, 0]
    elseif a:mode ==# 1
        let l:end = stridx(a:line, ' : ')
        return [a:line[:l:end-1], 0]
    else
        let l:start = stridx(a:line, ' : ')
        return [a:line[l:start : -1], strlen(a:line)]
    endif
endfunction


let g:Lf_Extensions.nayvy = {
\   'source': 'LfExt_nayvy_source',
\   'accept': 'LfExt_nayvy_accept',
\   'supports_name_only': 1,
\   'get_digest': 'LfExt_nayvy_get_digest'
\}

endif


" ============================================================================
" ghq
" ============================================================================
function! LfExt_ghq_accept(line, args) abort
    let l:path = $GHQ_ROOT . '/github.com/' . a:line
    execute 'tabe | tcd ' . l:path
endfunction

function! LfExt_ghq_format_line(line, args) abort
    " 'github.com ' 以降を取得
    return a:line[11:]
endfunction

let g:Lf_Extensions.ghq = {
\   'source': {'command': 'ghq list'},
\   'accept': 'LfExt_ghq_accept',
\   'format_line': 'LfExt_ghq_format_line',
\}
