scriptencoding utf-8


" * TODO: タブごとに管理する
" * ディレクトリを指定
"   * とりあえず cwd
" sass --watch scss:css

let s:job = v:null
let s:watch_targets = []

function! s:start_job(cmd, options)
    let s:job = job_start([&shell, &shellcmdflag, a:cmd], {
    \   'err_cb': { channel, data -> a:options.on_err(data)},
    \   'cwd': a:options.cwd,
    \})
endfunction

function! s:echo_error(msg) abort
    echohl errormsg
    echomsg a:msg
    echohl None
endfunction

function! s:echo_msg(msg) abort
    echohl Identifier
    echomsg a:msg
    echohl None
endfunction

" from neomru.vim
function! s:get_path(path) abort
    return has('win32') ? substitute(a:path, '\\', '/', 'g') : a:path
endfunction

" function! s:getvar(name, ...) abort
"     if exists('sasswatch#'.a:name)
"         return 'sasswatch#'.a:name
"     else
"         return a:0 > 0 ? a:1 : v:null
"     endif
" endfunction
"
" function! s:setvar(name, val) abort
"     let sasswatch#{a:name} = a:val
" endfunction

function! s:add_watch_targets(cwd, targets) abort
    for l:target in a:targets
        " 'scss:css' => '{cwd}/scss'
        let l:input_path = a:cwd.'/'.matchstr(l:target, '\v^[^:]+')
        call add(s:watch_targets, s:get_path(l:input_path))
    endfor
endfunction

" targets は ['scss:css', 'template:css'] のようなリスト
function! s:start(cwd, targets) abort
    if sasswatch#is_running()
        call sasswatch#stop()
    endif

    let l:cmd = printf('sass --watch %s', join(a:targets, ' '))

    let l:opts = {
    \   'on_err': function('s:echo_error'),
    \   'cwd': a:cwd,
    \}
    call s:start_job(l:cmd, l:opts)

    if sasswatch#is_running()
        echohl Identifier
        echomsg ' [sass-watch] start'
        echohl None
        call s:add_watch_targets(a:cwd, a:targets)
    else
        call s:echo_error(' [sass-watch] start failed')
    endif

endfunction

function! sasswatch#is_running() abort
    if s:job ==# v:null
        return v:false
    endif
    return job_status(s:job) ==# 'run'
endfunction

" 渡されたパスが watch されているかを返す
" lightline に表示に使える
function! sasswatch#is_watching(path) abort
    for l:target in s:watch_targets
        " watch されていれば true を返す
        if match(s:get_path(a:path), '\v^'.l:target) != -1
            return v:true
        endif
    endfor
    return v:false
endfunction

" 以下のように呼び出す
" sasswatch#start(getcwd(), 'scss:css')
" sasswatch#start(getcwd(), '1.scss:1.css', '2.scss:2.css')
function! sasswatch#start(cwd, targets, ...) abort
    call s:start(a:cwd, [a:targets] + a:000)
endfunction

function! sasswatch#stop() abort
    if sasswatch#is_running()
        call job_stop(s:job)
        let s:job = v:null
        echohl Identifier
        echomsg ' [sass-watch] stoped'
        echohl None
    endif
endfunction
