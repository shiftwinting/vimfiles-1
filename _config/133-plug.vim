scriptencoding utf-8

function! s:close_if_done(cmd, timer) abort
    let l:done = v:false
    for l:line in getbufline(s:term_bufnr, 1, '$')
        if !l:done && l:line =~# '- Finishing ... Done!'
            let l:done = v:true
            call timer_stop(a:timer)
            break
        endif
    endfor

    if l:done
        let l:lines = getbufline(s:term_bufnr, 1, '$')
        " 内側の Vim を終了する
        call term_sendkeys(s:term_bufnr, ':qa!')
        exec s:term_bufnr . 'bdelete!'

        let l:error = v:false
        for l:line in l:lines
            " 先頭が ~ の行で終了だから
            if l:line =~# '^\~'
                break
            endif

            " エラーの場合、以下のようになる
            " x LeaderF:
            "   ^^^^^^^
            let l:error_plug = matchstr(l:line, '\vx \zs[^:]+\ze:')
            if !empty(l:error_plug)
                " echomsg l:error_plug
                let l:error = v:true
            endif
        endfor

        let l:opt = {
        \   'highlight': l:error ? 'ErrorMsg' : 'Todo'
        \}
        call tmg#popup_notification_botright('Done ' . a:cmd, l:opt)
    endif
endfunction

function! s:exec_plug_cmd(cmd) abort
    let l:cmd = 'vim -c ' . a:cmd
    let s:term_bufnr = term_start(l:cmd, {
    \   'hidden': 1,
    \})
    call tmg#popup_notification_botright('Start ' . a:cmd)
    let s:timer = timer_start(300, function('s:close_if_done', [a:cmd]), {
    \   'repeat': -1
    \})
endfunction

command! TPlugInstall call <SID>exec_plug_cmd('PlugInstall')
command! TPlugUpdate call <SID>exec_plug_cmd('PlugUpdate')
