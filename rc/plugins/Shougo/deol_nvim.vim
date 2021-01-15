scriptencoding utf-8

UsePlugin 'deol.nvim'

" \%(\) : 部分正規表現として保存しない :help /\%(\)
let g:deol#prompt_pattern = 
\   '^\%(PS \)\?' .
\   '[^#>$ ]\{-}' .
\   '\%(' .
\       '> \?'  . '\|' .
\       '# \? ' . '\|' . 
\       '\$' .
\       '\$ ' .
\   '\)'

" コマンドの履歴
let g:deol#shell_history_path = has('nvim') ? expand('~/.zsh_history') : expand('~/deol_history')

" job_start() へのオプション
let g:deol#extra_options = {
\   'term_kill': 'kill',
\}

nnoremap <silent><A-t> :<C-u>call DeolToggle()<CR>
tnoremap <silent><A-t> <C-\><C-n>:<C-u>call DeolToggle()<CR>


" ====================
" deol の表示をトグル
" ====================
function! DeolToggle() abort
  if s:is_show_deol()
    " close
    execute 'Deol -toggle'
  else
    " open
    botright 25new
    setlocal winfixheight
    execute 'Deol -toggle -edit -no-start-insert -edit-filetype=deoledit -command=' . &shell
  endif
endfunction

augroup MyDeol
    autocmd!
augroup END

autocmd MyDeol Filetype   deol     call <SID>deol_settings()
autocmd MyDeol Filetype   deoledit call <SID>deol_editor_settings()
" autocmd MyDeol DirChanged *        call <SID>deol_cd()

" function! s:deol_cd() abort
"     call deol#cd(fnamemodify(expand('<afile>'), ':p:h'))
" endfunction

function! s:deol_settings() abort
    if has('nvim')
        tnoremap <buffer><silent> <A-e> <C-\><C-N>:call deol#edit()<CR>
        inoremap <buffer><silent> <A-e> <C-\><C-N>:call deol#edit()<CR>
    else
        tnoremap <buffer><silent>   <A-e> <C-w>:call deol#edit()<CR>
    endif
    nnoremap <buffer><silent>       <A-e> <Esc>:<C-u>call deol#edit()<CR>

    " 不要なマッピングを削除
    nnoremap <buffer>               <C-o> <Nop>
    nnoremap <buffer>               <C-i> <Nop>
    " nnoremap <buffer>               <C-e> <Nop>
    nnoremap <buffer>               <C-z> <Nop>
    nnoremap <buffer>               e     e

    " git dirty とかで飛べるようにするため
    " setlocal path+=FugitiveWorkTree()
endfunction


function! s:exec_line(new_line) abort
  exec "normal \<Plug>(deol_execute_line)"
  if a:new_line
    " 行挿入 (o)
    call feedkeys('o', 'n')
  endif

  " 最終行に移動する (この関数の実行が終わるまで、スクロールされない？)
  " From https://github.com/hrsh7th/vim-vital-vs/blob/b27285abeefa55bc6cdc90e59e496b28ea5053c4/autoload/vital/__vital__/VS/Vim/Window.vim#L24
  let l:curwin = nvim_get_current_win()
  noautocmd keepalt keepjumps call win_gotoid(bufwinid(t:deol.bufnr))
  try
    normal! G
  catch /.*/
    echomsg string({ 'exception': v:exception, 'throwpoint': v:throwpoint })
  endtry
  noautocmd keepalt keepjumps call win_gotoid(l:curwin)

endfunction

function! s:tldr_line() abort
  if !executable('tldr')
    echomsg '[deol] require tldr'
    return
  endif

  call deol#send('tldr ' .. getline('.'))
endfunction

function! s:deol_editor_settings() abort
    command! -buffer -bang DeolExecuteLine call <SID>exec_line(<bang>0)

    inoremap <buffer><silent> <A-e> <Esc>:call <SID>deol_kill_editor()<CR>
    nnoremap <buffer><silent> <A-e> :<C-u>call <SID>deol_kill_editor()<CR>
    inoremap <buffer><silent> <A-t> <Esc>:call <SID>hide_deol()<CR>
    nnoremap <buffer><silent> <A-t> :<C-u>call <SID>hide_deol()<CR>

    nnoremap <buffer>         <C-o> <Nop>
    nnoremap <buffer>         <C-i> <Nop>

    nnoremap <buffer><silent> <CR> :<C-u>DeolExecuteLine<CR>
    inoremap <buffer><silent> <CR>  <Esc>:DeolExecuteLine!<CR>

    nnoremap <buffer><silent> <A-h> :<C-u>call <SID>tldr_line()<CR>

    inoremap <buffer><silent><expr> <TAB> pumvisible() ? "\<C-n>" : compe#complete()

    resize 5
    setlocal winfixheight
    setlocal filetype=zsh
endfunction


" ====================
" deol-edit を削除
" ====================
function! s:deol_kill_editor() abort
    if !exists('t:deol')
        return
    endif

    " バッファがあれば削除
    call s:bufdelete_if_exists(t:deol.edit_bufnr)

    call win_gotoid(bufwinid(t:deol.bufnr))
endfunction


" ====================
" deol を非表示にする
" ====================
function! s:hide_deol() abort
    if !exists('t:deol')
        " まだ、作られていない場合、終わり
        return
    endif

    if s:is_show_deol_edit()
        call s:deol_kill_editor()
    endif

    call win_gotoid(bufwinid(t:deol.bufnr))
    if t:deol.bufnr ==# bufnr()
        execute 'hide'
    endif
endfunction


" ====================
" deol-edit が表示されているか
"
" s:is_show_deol_edit([tabnr])
" ====================
function! s:is_show_deol_edit() abort
    if !exists('t:deol')
        " まだ、作られていない場合、終わり、表示すらされないため
        return v:false
    endif

    " バッファが表示されているウィンドウが見つかったら true
    return !empty(win_findbuf(t:deol.edit_bufnr))
endfunction


" ====================
" バッファがあれば、削除する
" ====================
function! s:bufdelete_if_exists(bufnr) abort
    if bufexists(a:bufnr)
        execute 'silent! bdelete! ' . a:bufnr
    endif
endfunction


" ====================
" Deol が表示されているか
" ====================
function! s:is_show_deol() abort
    if !exists('t:deol')
        " まだ、作られていない場合、終わり、表示すらされないため
        return v:false
    endif

    " バッファが表示されているウィンドウが見つかったら true
    return !empty(win_findbuf(t:deol.bufnr))
endfunction


" " ====================
" " editor の行を送信
" " 
" " s:send_editor([insert_mode])
" " ====================
" function! s:send_editor(line1, line2, new_line) abort
"     let l:lines = getline(a:line1, a:line2)
"
"     if !has('nvim')
"         for l:line in l:lines
"             call s:save_history_line(l:line)
"         endfor
"     endif
"
"     exec printf("%d,%dnormal \<Plug>(deol_execute_line)", a:line1, a:line2)
"
"     " 複数行なら、最後の行にジャンプ
"     if !empty(visualmode()) && a:line1 !=# a:line2
"         normal! '>
"     endif
"
"     if a:new_line
"         " 行挿入 (o)
"         call feedkeys('o', 'n')
"     else
"         if !empty(visualmode()) && a:line1 !=# a:line2
"             normal! '>j
"         endif
"     endif
" endfunction
"
"
" " ====================
" " 履歴に保存
" " ====================
" function! s:save_history_line(line) abort
"     if empty(a:line)
"         return
"     endif
"
"     " すでに履歴にあったら末尾に移動する
"     let l:history = readfile(g:deol#shell_history_path)
"     if len(l:history) > g:deol#shell_history_max
"         " [1, 2, 3, 4, 5][-3:] ==# [3, 4, 5]
"         let l:history = l:history[-g:deol#shell_history_max:]
"     endif
"     let l:idx = index(l:history, a:line)
"     if l:idx > -1
"         " 削除
"         call remove(l:history, l:idx)
"     endif
"     call add(l:history, a:line)
"     call writefile(l:history, g:deol#shell_history_path)
" endfunction
