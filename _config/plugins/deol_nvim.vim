scriptencoding utf-8

UsePlugin 'deol.nvim'

" " \%(\) : 部分正規表現として保存しない :help /\%(\)
" let g:deol#prompt_pattern = 
" \   '^\%(PS \)\?' .
" \   '[^#>$ ]\{-}' .
" \   '\%(' .
" \       '> \?'  . '\|' .
" \       '# \? ' . '\|' . 
" \       '\$ \?' . '\|' . 
" \       '❯ \?' .
" \   '\)'


" ウィンドウを閉じたら、完全に消される
let $GIT_EDITOR = 'nvr --remote-tab-wait-silent +"set bufhidden=wipe"'

" p10k
let g:deol#prompt_pattern = '^❯ \?'

" コマンドの履歴
let g:deol#shell_history_path = has('nvim') ? expand('~/.zsh_history') : expand('~/deol_history')

" job_start() へのオプション
let g:deol#extra_options = {
\   'term_kill': 'kill',
\}

nnoremap <silent><A-t> <Cmd>call DeolToggle()<CR>
tnoremap <silent><A-t> <C-\><C-n><Cmd>call DeolToggle()<CR>


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
    " execute 'Deol -toggle -edit-filetype=deoledit -command=' . &shell
  endif
endfunction

augroup MyDeol
    autocmd!
augroup END

autocmd MyDeol Filetype   deol     call <SID>deol_settings()
autocmd MyDeol Filetype   deoledit call <SID>deol_editor_settings()

" dstein64/nvim-scrollview を使っていると、deol バッファで再描画してしまうため、対策
if exists(':ScrollView*')
  " pause
  function! s:scrollview_pause(bufnr) abort
    if !exists('t:deol')
      return
    endif

    if t:deol.bufnr ==# a:bufnr
      ScrollViewDisable
    endif
  endfunction

  " restart
  function! s:scrollview_restart(bufnr) abort
    if !exists('t:deol')
      return
    endif

    if t:deol.bufnr ==# a:bufnr
      ScrollViewEnable
    endif
  endfunction

  autocmd MyDeol WinEnter * call <SID>scrollview_pause(expand('<abuf>'))
  autocmd MyDeol WinLeave * call <SID>scrollview_restart(expand('<abuf>'))
endif


function! s:deol_settings() abort
    tnoremap <buffer><silent> <A-e> <C-\><C-N><Cmd>call deol#edit()<CR>
    inoremap <buffer><silent> <A-e> <C-\><C-N><Cmd>call deol#edit()<CR>
    nnoremap <buffer><silent> <A-e> <Cmd>call deol#edit()<CR>

    tnoremap <buffer><silent> <A-w> <C-\><C-N><Cmd>normal! <C-w>_<CR>
    nnoremap <buffer><silent> <A-w> <Cmd>normal! <C-w>_<CR>

    nmap <buffer><silent> <A-k> <Plug>(deol_previous_prompt)
    nmap <buffer><silent> <A-j> <Plug>(deol_next_prompt)
    nmap <buffer><silent> <C-k> <Plug>(deol_previous_prompt)
    nmap <buffer><silent> <C-j> <Plug>(deol_next_prompt)


    " 不要なマッピングを削除
    nnoremap <buffer>               <C-o> <Nop>
    nnoremap <buffer>               <C-i> <Nop>
    " nnoremap <buffer>               <C-e> <Nop>
    nnoremap <buffer>               <C-z> <Nop>
    nnoremap <buffer>               e     e

    " git dirty とかで飛べるようにするため
    " setlocal path+=FugitiveWorkTree()
endfunction


" 最終行に移動する (呼び出し元の関数の実行が終わるまで、スクロールされない？)
function! s:goto_bottom() abort
  " From https://github.com/hrsh7th/vim-vital-vs/blob/b27285abeefa55bc6cdc90e59e496b28ea5053c4/autoload/vital/__vital__/VS/Vim/Window.vim#L24
  let l:curwin = win_getid()
  noautocmd keepalt keepjumps call win_gotoid(bufwinid(t:deol.bufnr))
  try
    normal! G
  catch /.*/
    echomsg string({ 'exception': v:exception, 'throwpoint': v:throwpoint })
  endtry
  noautocmd keepalt keepjumps call win_gotoid(l:curwin)
endfunction

" deol#send() して、そのあと、末尾に移動
function! s:send(cmd) abort
  call deol#send(a:cmd)
  call s:goto_bottom()
endfunction

function! s:exec_line() abort
  exec "normal \<Plug>(deol_execute_line)"
  if mode() ==# 'i'
    " 行挿入 (o)
    call feedkeys("\<C-o>o", 'n')
  endif

  call s:goto_bottom()
endfunction

function! s:set_line(cmd) abort
  call append(line('$'), a:cmd)
  normal! G$
endfunction

function! s:tldr_line() abort
  if !executable('tldr')
    echomsg '[deol] require tldr'
    return
  endif

  call deol#send('tldr ' .. getline('.'))
endfunction

let s:shortcuts = {
\ 'gcc': 'git commit',
\ 'gca': 'git commit --ammend',
\ 'gp':  'git push',
\ 'gP':  'git push --force',
\ 'gl':  'git pull'
\}

function! s:apply_shortcut_mappings() abort
  for [l:lhs, l:cmd] in items(s:shortcuts)
    exec printf('nnoremap <buffer><silent> %s <Cmd>call <SID>send("%s")<CR>', l:lhs, l:cmd)
  endfor
endfunction

function! s:deol_editor_settings() abort

    inoremap <buffer><silent> <A-e> <Esc>:call <SID>deol_kill_editor()<CR>
    nnoremap <buffer><silent> <A-e> <Cmd>call <SID>deol_kill_editor()<CR>
    inoremap <buffer><silent> <A-t> <Esc>:call <SID>hide_deol()<CR>
    nnoremap <buffer><silent> <A-t> <Cmd>call <SID>hide_deol()<CR>

    nnoremap <buffer><silent> <CR> <Cmd>call <SID>exec_line()<CR>
    inoremap <buffer><silent> <CR> <Cmd>call <SID>exec_line()<CR>

    nnoremap <buffer><silent> <A-h> <Cmd>call <SID>tldr_line()<CR>

    inoremap <buffer><silent> <C-k> <Esc>k
    inoremap <buffer><silent> <C-j> <Esc>:noautocmd keepalt keepjumps call win_gotoid(bufwinid(t:deol.bufnr))<CR>
    nnoremap <buffer><silent> <C-j> :noautocmd keepalt keepjumps call win_gotoid(bufwinid(t:deol.bufnr))<CR>

    " nvim-compe
    inoremap <buffer><silent><expr> <TAB> pumvisible() ? "\<C-n>" : compe#complete()

    call s:apply_shortcut_mappings()

    nnoremap <buffer><silent> ? <Cmd>call <SID>open_help()<CR>

    " もとに戻す
    nnoremap <buffer> <C-o> <Nop>
    nnoremap <buffer> <C-i> <Nop>
    
    inoremap <buffer> <C-h> <C-h>
    nnoremap <buffer> <C-h> <C-h>
    inoremap <buffer> <BS>  <BS>
    nnoremap <buffer> <BS>  <BS>

    nnoremap <buffer> <C-k> k
    " nnoremap <buffer> <C-j> j

    resize 5
    setlocal winfixheight
    setlocal syntax=zsh
    " setlocal filetype=deol-edit
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
