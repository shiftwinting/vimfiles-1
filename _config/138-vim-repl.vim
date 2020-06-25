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
\   'py': 'exit()',
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
function! s:send_last_sexp() abort
    " 保存
    let l:save_pos = getcurpos()

    " s式を送信する
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
        call s:highlight_yank_toggle()
        execute 'silent! normal! v%"' . l:reg . 'y'
        call s:highlight_yank_toggle()
    else
        " カーソル下の文字を取得
        execute 'silent! normal! "' . l:reg . 'yiW'
    endif 

    " 復元
    call setpos('.', l:save_pos)

    " 送信
    for l:line in getreg(l:reg, v:false, v:true)
        if repl#REPLWin32Return()
            exe "call term_sendkeys('" . repl#GetConsoleName() . ''', l:line . "\r\n")'
        else
            exe "call term_sendkeys('" . repl#GetConsoleName() . ''', l:line . "\n")'
        endif
        exe 'call term_wait("' . repl#GetConsoleName() . '", 50)'
    endfor

    if repl#REPLWin32Return()
        exe "call term_sendkeys('" . repl#GetConsoleName() . ''', "\r\n")'
    else
        exe "call term_sendkeys('" . repl#GetConsoleName() . ''', "\n")'
    endif
endfunction

command! SendLastSexp call s:send_last_sexp()

augroup MyVimRepl
    autocmd!
    autocmd Filetype r7rs,scheme,lisp nnoremap <C-c><C-e> :<C-u>SendLastSexp<CR>
augroup END
