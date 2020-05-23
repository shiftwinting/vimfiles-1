scriptencoding utf-8

finish

" REPL を右に表示
let g:repl_position = 3

" visual mode で送信したら、カーソルを下に移動
let g:repl_cursor_down = 1

" REPL を開いた時、カレントバッファにとどまる
let g:repl_stayatrepl_when_open = 0

nnoremap <Space>re :<C-u>REPLToggle<CR>

" <Space>rl で送信
let g:sendtorepl_invoke_key = '<Enter>'

" py -3 は py となるため
let g:repl_exit_commands = {
\   'py': 'exit()',
\   'python': 'exit()',
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
\   'python': 'py -3'
\}
