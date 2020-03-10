scriptencoding utf-8


augroup MyGit
    autocmd!
augroup END



" =================================================
" git commit
" =================================================
function! git#commit() abort
    call s:open_commit_buffer(join(['', '', '# Commit messages']))
endfunction



" =================================================
" git commit --amend -m
" =================================================
function! git#commit_amend() abort
    call s:open_commit_buffer()
endfunction



" =================================================
" git push
" =================================================
function! git#push(...) abort
    let l:opts = {
    \   'cmd': 'push',
    \   'args': a:000,
    \}
    call tmg#term_exec('git', l:opts)
endfunction



" =================================================
" git pull
" =================================================
function! git#pull() abort
    let l:opts = {
    \   'cmd': 'pull',
    \}
    call tmg#term_exec('git', l:opts)
endfunction



" -------------------------------------------------
" private

function! s:open_commit_buffer(...) abort
    let l:lines = a:0 > 0 ? a:1 : []

    " バッファを開く
    let l:tempname = tempname()
    exec '10new '.l:tempname
    let l:buf = bufnr()
    setlocal filetype=gitcommit
    call s:set_lines(l:buf, l:lines)

    let b:writed = v:false
    let b:quited = v:false

    " expand() で <afile> とかが展開できる
    " 詳しくは :h expand() をみて
    autocmd MyGit BufWriteCmd <buffer> call s:BufWriteCmd()
    autocmd MyGit QuitPre <buffer> call s:QuitPre()
    autocmd MyGit WinLeave <buffer> call s:do_commit()

    startinsert
endfunction


" バッファにテキストをセット
function! s:set_lines(bufnr, lines) abort
    
endfunction


" 最後のコミットメッセージを取得
function! s:get_last_commit_messages() abort
    
endfunction


" gina.vim に書いてあった
" NOTE:
" :w      -- BufWriteCmd
" <C-w>p  -- WinLeave
" :wq     -- QuitPre -> BufWriteCmd -> WinLeave
" :q      -- QuitPre -> WinLeave

function! s:BufWriteCmd() abort
    let b:writed = v:true
endfunction

function! s:QuitPre() abort
    let b:quited = v:true
endfunction


function! s:do_commit() abort
    if !b:writed || !b:quited
        " :q or :w を使っていないときは何もしない
        let b:quited = v:false
        return
    endif

    let l:res = input(' Commit? (y/n) ')
    if l:res !~? '^y$'
        call tmg#echoerr(' Cancel.')
        return
    endif

    let l:lines = getline(1, '$')

    " 1行目: タイトル
    let l:title = l:lines[0]

    " ３行目以降: 詳細 (コメントは無視する)
    let l:details = ''
    for l:line in filter(l:lines[2:], 'trim(v:val) !~# "^#"')
        l:details = l:details . printf(' -m "%s"', l:line)
    endfor

    let l:opts = {
    \   'cmd': printf('commit -m "%s" %s', l:title, l:details),
    \}
    call tmg#term_exec('git', l:opts)
endfunction
" =================================================
