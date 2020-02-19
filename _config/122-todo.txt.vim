scriptencoding utf-8

" [タスク管理メソッド todo.txt が面白そう - Qiita https://qiita.com/sta/items/0f72c9c956cf05df8141]
" [todotxt/todo.txt: ‼️ A complete primer on the whys and hows of todo.txt. https://github.com/todotxt/todo.txt]
" [dbeniamine/todo.txt-vim: Efficient Todo.txt management in vim https://github.com/dbeniamine/todo.txt-vim]

" マッピングはここを見る
" ~\ghq\github.com\tamago324\vimfiles\plugged\todo.txt-vim\ftplugin\todo.vim

" done.txt の名前
let g:TodoTxtForceDoneName='done.txt'
" デフォルトのマッピングを OFF
let g:Todo_txt_do_not_map = 1

" @  コンテキスト(状況で管理するため)
" due:yyyy-mm-dd 期限(due)

augroup MyTodo
    autocmd!
    autocmd FileType todo setlocal omnifunc=todo#Complete
    autocmd FileType todo call TodoMappings()
augroup END

function! TodoMappings() abort
    nnoremap <buffer> [Todo]   <Nop>
    nmap     <buffer> <Space>t [Todo]

    nnoremap <silent><buffer> o o<C-R>=strftime("%Y-%m-%d")<CR> 
    inoremap <silent><buffer> date<Tab> <C-R>=strftime("%Y-%m-%d")<CR>

    imap     <silent><buffer> + +<C-X><C-O>
    imap     <silent><buffer> @ @<C-X><C-O>

    nmap     <silent><buffer> [Todo]x <Plug>DoToggleMarkAsDone

    " 優先順位
    noremap  <silent><buffer> [Todo]a :<C-u>call todo#PrioritizeAdd('A')<CR>
    noremap  <silent><buffer> [Todo]j :<C-u>call todo#PrioritizeIncrease()<CR>
    noremap  <silent><buffer> [Todo]k :<C-u>call todo#PrioritizeDecrease()<CR>

    " 期限
    nmap     <silent><buffer> [Todo]p <Plug>TodotxtIncrementDueDateNormal
    nmap     <silent><buffer> [Todo]n <Plug>TodotxtDecrementDueDateNormal
    nnoremap <silent><buffer> [Todo]d A due:<C-R>=strftime("%Y-%m-%d")<CR><Esc>0

    " Done
    nnoremap <silent><buffer> [Todo]d :<C-u>call todo#RemoveCompleted()<CR>
    " Cancel
    nmap     <silent><buffer> [Todo]c <Plug>DoCancel
endfunction

nnoremap <silent> <Space>td :<C-u>Todo<CR>
command! Todo call tmg#DropOrTabedit('~/memo/todo/todo.txt')
