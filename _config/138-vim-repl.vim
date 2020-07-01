scriptencoding utf-8

" REPL を右に表示
let g:repl_position = 3

" visual mode で送信したら、カーソルを下に移動
let g:repl_cursor_down = 1

" REPL を開いた時、カレントバッファにとどまる
let g:repl_stayatrepl_when_open = 0

nnoremap <Space>re :<C-u>REPLToggle<CR>

" <Enter> で送信
let g:sendtorepl_invoke_key = '<Enter>'

" py -3 は py となるため
let g:repl_exit_commands = {
\   'py': 'quit()',
\   'python': 'exit()',
\   'scheme': '(exit)',
\}

" 変数の表示
let g:repl_sendvariable_template = {
\   'python': 'print(<input>)',
\}

" この行を送信したら、そのブロックをまとめて送信
let g:repl_auto_sends = [
\   'class ',
\   'def ',
\   'for ',
\   'if ',
\   'while ',
\   'with '
\]

let g:repl_program = {
\   'python': 'py -3',
\   'scheme': 'gosh',
\   'r7rs': 'gosh',
\}


function! s:highlight_yank_toggle() abort
    if exists(':HighlightedyankToggle') ==# 2
        HighlightedyankToggle
    endif
endfunction

" カーソルの後ろの S式を REPL に送る
function! s:get_last_sexp() abort
    " 保存
    let l:save_pos = getcurpos()

    " 空行なら、直前の ) を探す
    if empty(trim(getbufline(bufnr(), line('.'))[0])) 
        " b: 上に検索
        " n: カーソルを移動しない
        call search(')', 'b')
    endif

    let l:reg = 'e'

    " カーソル下が ( or ) なら、そのカッコの範囲の文字列を取得する
    execute 'silent! normal! v"' . l:reg . 'y'
    let l:cur_char = getreg(l:reg)

    if l:cur_char ==# ')' || l:cur_char ==# '('
        " ハイライトしちゃうから
        " call s:highlight_yank_toggle()
        execute 'silent! normal! v%"' . l:reg . 'y'
        " call s:highlight_yank_toggle()
    else
        " カーソル下の文字を取得
        execute 'silent! normal! "' . l:reg . 'yiW'

        let l:str = getreg(l:reg, v:false)
        if l:str !~# '\v^\(.+\)$'
            if l:str =~# '^('
                " (1| 2 3) -> (1 となってしまうため
                call setreg(l:reg, l:str[1:])
            elseif l:str =~# ')$'
                " (1 2 |3) -> 3) となってしまうため
                call setreg(l:reg, l:str[:-2])
            endif
        endif
    endif 

    " 復元
    call setpos('.', l:save_pos)

    return getreg(l:reg, v:false, v:true)
endfunction

" " 関数を評価
" function! s:get_define() abort
"     " 保存
"     let l:save_pos = getcurpos()
"
"     let l:reg = 'e'
"
"     " define を探す
"     "   '(define' になるまで normal! ( を繰り返す
"     "   ( を押しても、pos が変わらなければ、終わり
"     let l:last_pos = [0, 0, 0, 0, 0]
"     let l:is_define = v:false
"
"     while l:last_pos !=# getcurpos()
"         let l:last_pos = getcurpos()
"
"         exec 'normal ('
"
"         let l:line = getbufline(bufnr(), line('.'))[0]
"         let l:col = l:last_pos[2]
"         let l:find_define = l:line[l:col :] =~# '^define\s'
"     endwhile
"
"     if !l:find_define
"         " 見つからなかったら、終わり
"         call setreg(l:reg, '')
"     else
"         call s:highlight_yank_toggle()
"         execute 'silent! normal! v%"' . l:reg . 'y'
"         call s:highlight_yank_toggle()
"     endif
"
"     " 復元
"     call setpos('.', l:save_pos)
"
"     return getreg(l:reg, v:false, v:true)
" endfunction

function! s:send_repl(lines) abort
    if a:lines ==# ['']
        return
    endif
    " 送信
    for l:line in a:lines
        if repl#REPLWin32Return()
            exe "call term_sendkeys('" . repl#GetConsoleName() . ''', l:line . "\r\n")'
        else
            exe "call term_sendkeys('" . repl#GetConsoleName() . ''', l:line . "\n")'
        endif
        " exe 'call term_wait("' . repl#GetConsoleName() . '", 5)'
    endfor

    if repl#REPLWin32Return()
        exe "call term_sendkeys('" . repl#GetConsoleName() . ''', "\r\n")'
    else
        exe "call term_sendkeys('" . repl#GetConsoleName() . ''', "\n")'
    endif

endfunction

function! s:eval_smart() abort
    " いい感じに評価する

    " 空行の場合
    if empty(trim(getbufline(bufnr(), line('.'))[0])) 
        " 直前の S式
        call s:send_repl(s:get_last_sexp())
        return
    endif

    " カーソル位置がカッコの中
    let l:save_pos = getcurpos()
    let l:reg = 'e'

    " ノーマルモード
    let l:last_pos = [0, 0, 0, 0, 0]

    "   normal! ( を繰り返す
    "   ( を押しても、pos が変わらなければ、終わり
    while l:last_pos !=# getcurpos()
        let l:last_pos = getcurpos()

        exec 'normal ('

        let l:line = getbufline(bufnr(), line('.'))[0]
        let l:col = l:last_pos[2]
    endwhile

    " call s:highlight_yank_toggle()
    execute 'silent! normal! v%"' . l:reg . 'y'
    " call s:highlight_yank_toggle()

    " カーソル位置の調整
    if s:is_auto_move_cursor_down()
        " 下に移動
        normal! %
        " 最終行じゃなければ、j
        if line('.') !=# line('$')
            normal! j
        endif
        normal! 0
    else
        " 復元
        call setpos('.', l:save_pos)
    endif
    " 送信
    call s:send_repl(getreg(l:reg, v:false, v:true))

endfunction

" 選択範囲を評価
function! s:eval_visual() abort
    let l:save_pos = getcurpos()
    let l:reg = 'e'

    " call s:highlight_yank_toggle()
    execute 'silent! normal! gv"' . l:reg . 'y'
    " call s:highlight_yank_toggle()

    " 復元
    call setpos('.', l:save_pos)
    " 送信
    call s:send_repl(getreg(l:reg, v:false, v:true))
endfunction

" " 最後のS式を評価
" command! EvalLastSexp call s:send_repl(s:get_last_sexp())
" " カーソル位置のDefineを評価
" command! EvalDefine call s:send_repl(s:get_define())

" command! EvalSmart call s:eval_smart()

function! s:is_auto_move_cursor_down() abort
    " 最終行なら、移動しない
    return get(b:, 'vimrc_auto_move_cursor_down', v:false)
endfunction

function! s:lisp_settings() abort
    let b:vimrc_auto_move_cursor_down = v:true

    nnoremap <buffer><silent> ,f :<C-u>call <SID>eval_smart()<CR>
    vnoremap <buffer><silent> ,f :call      <SID>eval_visual()<CR>
endfunction

augroup MyVimRepl
    autocmd!
    autocmd Filetype r7rs,scheme,lisp call s:lisp_settings()
augroup END
