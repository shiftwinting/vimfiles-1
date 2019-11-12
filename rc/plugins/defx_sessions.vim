scriptencoding utf-8

let s:ctx = {}


function! DefxSessions(session_file) abort " {{{
    let l:sessions = s:defx_read_sessions(a:session_file)

    let s:ctx = {
        \   'texts': function('s:defx_create_session_ilst'),
        \   'sessions': l:sessions,
        \   'items': function('s:session_items')
        \}

    let l:opts = {
        \   'callback': function('s:defx_sessions_handler'),
        \   'title': ' defx sessions ',
        \   'padding': [0, 1, 0, 1],
        \   'filter': function('s:defx_sessions_filter'),
        \   'zindex': 100,
        \   'minheight': 15,
        \   'minwidth': 75,
        \}

    let s:ctx.id = popup_menu(s:ctx.texts(), l:opts)
endfunction


function! s:session_items() dict abort
    return keys(self.sessions)
endfunction


" {path: name} の dict
function! s:defx_read_sessions(path) abort
    let l:json_text = join(readfile(expand(a:path)), '\n')
    let l:dct = json_decode(l:json_text)
    let l:sessions = {}

    for [l:key, l:value] in items(l:dct.sessions)
        let l:sessions[l:key] = l:value.name
    endfor
    return l:sessions
endfunction


function! s:defx_create_session_ilst() dict abort
    let l:session_list = []
    let max_len = s:get_maxlen(values(self.sessions))

    for [k, v] in items(self.sessions)
        " name  path
        let l:path = fnamemodify(k, ':p:~')
        call add(l:session_list, printf('%-'.max_len.'s', v).'    '.l:path)
    endfor

    return l:session_list
endfunction


function! s:defx_sessions_filter(winid, key) abort
    if a:key ==# 'd'
        " カーソル行のインデックスを取得し、その行のitemを渡す
        call win_execute(a:winid, 'let g:popup_idx = line(".")')
        let l:idx = g:popup_idx - 1
        unlet! g:popupidx

        call s:confirm_delete(l:idx)
    endif

    return popup_filter_menu(a:winid, a:key)
endfunction


function! s:defx_sessions_handler(winid, idx) abort
    if a:idx != -1
        " idx は 1 始まりのため -1 する
        let l:defx_winid = s:get_defx_winid_of_curtab()
        if l:defx_winid ==# -1
            execute 'Defx '.s:ctx.items()[a:idx-1]
        else
            call win_gotoid(l:defx_winid)
        endif
        call defx#call_action('cd', s:ctx.items()[a:idx-1])
        execute 'tcd '.s:ctx.items()[a:idx-1]
    endif
endfunction


function! s:confirm_delete(idx) abort
    let l:texts = [
    \    'Delete '.s:ctx.items()[a:idx].'? (y/n)',
    \]

    call popup_dialog(l:texts, {
    \   'filter': 'popup_filter_yesno',
    \   'callback': function('s:dialog_handler', [a:idx]),
    \   'zindex': 200,
    \   'highlight': 'ErrorMsg',
    \})
endfunction


function! s:dialog_handler(idx, winid, yes) abort
    if a:yes ==# 1
        let l:target = s:ctx.items()[a:idx]
        " 削除
        call defx#call_action('delete_session', l:target)
        call remove(s:ctx.sessions, l:target)
        call popup_settext(s:ctx.id, s:ctx.texts())
        " カーソルを1つ上に移動
    endif
endfunction


" カレントタブの defx の winid を取得する
function! s:get_defx_winid_of_curtab() abort
    " カレントタブの winid のリスト
    for l:win in gettabinfo(tabpagenr())[0].windows
        " getbufvar(bufid, '&filetype') でファイルタイプを取得
        let l:ft = getbufvar(winbufnr(l:win), '&filetype')
        if l:ft ==# 'defx'
            return l:win
        endif
    endfor
    return -1
endfunction

function! s:get_maxlen(list) abort
    let maxlen = 0
    for val in a:list
        let length = len(val)
        if maxlen < length
            let maxlen = length
        endif
    endfor
    return maxlen
endfunction
