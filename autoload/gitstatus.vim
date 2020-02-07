scriptencoding utf-8

" from https://github.com/APZelos/gitline.vim

let s:timer_fetch_status = v:null
let s:git_fetch_status = ''

function! s:start_job(cmd, options)
    let s:job = job_start(a:cmd, {
    \   'out_cb': { job_id, data -> a:options.on_out(data)},
    \   'err_cb': { job_id, data -> a:options.on_err(data)}
    \})
endfunction

function! s:echoerr(msg) abort
    echohl errormsg
    echomsg a:msg
    echohl None
endfunction

function! s:on_err(data) abort
    let l:lines =  type(a:data) ==# v:t_list ? join(a:data) : a:data
    if l:lines ==# 'fatal: not a git repository (or any of the parent directories): .git'
        return
    endif
    call s:echoerr(l:lines)
endfunction

" =========================
" リモートとのコミットの差分
" '󿗶1 󿗹1' のようになる

function! s:on_fetch_status(data) abort
    let l:lines =  type(a:data) ==# v:t_list ? a:data : [a:data]
    let l:branch = filter(l:lines, 'v:val =~# "*"')
    if len(l:branch) == 0
        return
    endif
    let l:current_branch_info = l:branch[0]

    " \m : マジックをオン
    " \C : 大文字小文字を区別
    " \{-} : 最短一致
    let l:fetch_info = split(matchstr(l:current_branch_info, '\m\C\[\zs.\{-}\ze\]'), ', ')

    let l:ret_list = []
    for l:item in l:fetch_info
        let l:splited = split(l:item, ' ')

        if len(l:splited) != 2
            continue
        endif
        let l:type = l:splited[0]
        let l:cnt = l:splited[1]

        if l:type ==# 'ahead'
            let l:val = '󿗶' . l:cnt
        else
            let l:val = '󿗹' . l:cnt
        endif

        call add(l:ret_list, l:val)
    endfor

    let s:git_fetch_status = join(l:ret_list, ' ')
endfunction

function! gitstatus#fetch_job_start() abort
    if !exists('*FugitiveHead') || len(FugitiveHead()) == 0
        return
    endif

    let l:cmd = 'git branch -v'
    let l:options = {
    \   'on_out': function('s:on_fetch_status'),
    \   'on_err': function('s:on_err')
    \}
    call s:start_job(l:cmd, l:options)
endfunction

function! gitstatus#fetch_status() abort
    if !exists('*FugitiveHead') || len(FugitiveHead()) == 0
        return ''
    endif
    return s:git_fetch_status
endfunction
" =========================

function! gitstatus#init() abort
    if s:timer_fetch_status != v:null
        call timer_stop(s:timer_fetch_status)
    endif
    let s:timer_fetch_status = timer_start(1000, {timer_id -> gitstatus#fetch_job_start()}, { 'repeat': -1 })
endfunction

call gitstatus#init()