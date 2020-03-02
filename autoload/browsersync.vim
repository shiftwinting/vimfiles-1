scriptencoding utf-8

let s:job = v:null
let s:info = ''
let s:port = v:null

function! s:start_job(cmd, options)
    let s:job = job_start([&shell, &shellcmdflag, a:cmd], {
    \   'out_cb': { job_id, data -> a:options.on_out(data)},
    \   'err_cb': { job_id, data -> a:options.on_err(data)},
    \   'cwd': a:options.cwd,
    \})
endfunction

function! s:echo_error(msg) abort
    echohl errormsg
    echomsg a:msg
    echohl None
endfunction

function! s:on_out(line) abort
    let s:info = s:info . a:line . '\n'
    if a:line !~# 'Local'
        return
    endif
    let s:port = matchstr(a:line, '\v:\zs\d+$')
endfunction

function! s:echo_msg(msg) abort
    echohl Identifier
    echomsg a:msg
    echohl None
endfunction

function! browsersync#running() abort
    if s:job == v:null
        return v:false
    endif
    return job_status(s:job) ==# 'run'
endfunction


" browser-sync を起動 (cwd で起動する)
function! browsersync#start() abort
    if browsersync#running()
        call browsersync#stop()
    endif
    " let l:cmd = printf('browser-sync start --server --files="%s"',
    " \                   join(s:patterns, ', '))
    let l:cmd = 'browser-sync start --server --watch --no-open'

    let l:opts = {
    \   'on_out': function('s:on_out'),
    \   'on_err': function('s:echo_error'),
    \   'cwd': getcwd(),
    \}
    call s:start_job(l:cmd, l:opts)

    if browsersync#running()
        echohl Identifier
        echomsg ' [browser-sync] start'
        echohl None
    else
        call s:echo_error(' [browser-sync] start failed')
    endif

endfunction

" browser-sync を停止
function! browsersync#stop() abort
    if browsersync#running()
        call job_stop(s:job)
        echohl Identifier
        echomsg ' [browser-sync] stoped'
        echohl None
    endif
endfunction

function! s:open(port) abort
    if !browsersync#running()
        call s:echo_error(' [browser-sync] Not running')
        return
    endif
    call openbrowser#open('localhost:'.a:port)
endfunction

function! browsersync#open() abort
    call s:open(s:port)
endfunction

function! browsersync#open_ui() abort
    call s:open(str2nr(s:port) + 1)
endfunction

" You can use for lightline
function! browsersync#port() abort
    if !browsersync#running()
        return ''
    endif
    return s:port
endfunction
