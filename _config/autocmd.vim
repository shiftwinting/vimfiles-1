scriptencoding utf-8

augroup MyAutoCmd
  autocmd!
augroup END

" 自動でコメント開始文字を挿入しないようにする
autocmd MyAutoCmd FileType * setlocal formatoptions-=r formatoptions-=o


"   expandtab   タブ入力を複数の空白入力に置き換える
"   tabstop     実際に挿入されるスペースの数
"   shiftwidth  (auto)indent、<<,>> で使われるスペースの数
"   softtabstop <Tab> <BS> を押したときのカーソル移動の幅
autocmd MyAutoCmd FileType css          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType ctp          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType html         setlocal sw=2 sts=2 ts=4 et
autocmd MyAutoCmd FileType htmldjango   setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType javascript   setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType js           setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType json         setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType org          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType php          setlocal sw=4 sts=4 ts=4 et
autocmd MyAutoCmd FileType python       setlocal sw=4 sts=4 ts=4 et
autocmd MyAutoCmd FileType scss         setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType typescript   setlocal sw=2 sts=2 ts=2 et
" autocmd MyAutoCmd FileType vim          setlocal sw=4 sts=4 ts=4 et
autocmd MyAutoCmd FileType vim          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType yaml         setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType markdown     setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType nim          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType vue          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType firestore    setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType java         setlocal sw=4 sts=4 ts=4 noexpandtab
autocmd MyAutoCmd FileType pl0          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType c            setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType lua          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType smlnj        setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType sml          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType sql          setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType ocaml        setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType sh           setlocal sw=2 sts=2 ts=2 et


" 拡張子をもとにファイルタイプを設定
autocmd MyAutoCmd BufRead,BufWinEnter *.ini set filetype=dosini
autocmd MyAutoCmd BufRead,BufWinEnter *.csv set filetype=csv
autocmd MyAutoCmd BufRead,BufWinEnter *.jsx set filetype=javascript.jsx
autocmd MyAutoCmd BufRead,BufWinEnter *.pl0 set filetype=pl0
autocmd MyAutoCmd BufRead,BufWinEnter *.ml  set filetype=sml

" ファイル名を元にファイルタイプを設定
autocmd MyAutoCmd BufRead,BufWinEnter Vagrantfile set ft=ruby

" xxx-xxx もキーワードとして認識させる
autocmd MyAutoCmd FileType scss setlocal iskeyword+=-

" ====================
" cmdline-window コマンドラインウィンドウ
" ====================
function! s:save_global_options(...) abort
  let s:save_opts = {}
  let l:opt_names = a:000

  for l:name in l:opt_names
    execute 'let s:save_opts[l:name] = &'.l:name
  endfor
endfunction

function! s:restore_global_options() abort
  " global じゃないときはどうしよっかって感じだけど
  for [l:key, l:val] in items(s:save_opts)
    execute 'set '.l:key.'='.l:val
  endfor
endfunction

function! CmdlineEnterSettings() abort
  " いらない
  nnoremap <buffer> <C-l> <Nop>
  nnoremap <buffer> <C-i> <Nop>

  " 移動
  inoremap <buffer> <C-j> <Esc>j
  inoremap <buffer> <C-k> <Esc>k
  nnoremap <buffer> <C-j> j
  nnoremap <buffer> <C-k> k

  " 終了
  nnoremap <buffer> q     :<C-u>quit<CR>
  inoremap <buffer> <C-q> <Esc>:<C-u>quit<CR>
  nnoremap <buffer> <C-q> :<C-u>quit<CR>

  inoremap <buffer> <CR>  <C-c><CR>

  " global options
  call s:save_global_options(
  \ 'backspace',
  \ 'completeopt'
  \)
  " insertモード開始位置より左を削除できるようにする
  set backspace=start

  set completeopt=menu

  " local options
  " setlocal signcolumn=no
  setlocal nonumber

  " insertモードで開始
  " startinsert!
endfunction

function! CmdlineLeaveSettings() abort
  call s:restore_global_options()
endfunction

" 明日から使える Command-line window テクニック @monaqa
" https://bit.ly/2qybcv3
function! CmdlineRemoveLinesExec() abort
  " いらないものを消す
  let l:patterns = [
  \   '\v^wq?!?',
  \   '\v^qa?!?',
  \]

  for l:pattern in l:patterns
    call execute('g/'.l:pattern.'/"_d', 'silent')
  endfor

  " 一番下に移動
  silent normal! G
  if !has('nvim')
    call cursor(line('.'), s:cmdline_cursor_pos)
  endif
endfunction


augroup MyCmdWinSettings
  autocmd!
  autocmd CmdwinEnter * call CmdlineEnterSettings()
  autocmd CmdwinLeave * call CmdlineLeaveSettings()
  autocmd CmdwinEnter : call CmdlineRemoveLinesExec()
augroup END


" ====================
" カーソルラインの位置を保存する
" from skanehira/dotfiles (http://bit.ly/2N82age)
" ====================
autocmd MyAutoCmd BufReadPost *
\   if line("'\"") > 0 && line("'\"") <= line("$") |
\     exe "normal! g'\"" |
\   endif


" " ====================
" " diffthis しているときにテキスト更新したら diffupdate
" " http://bit.ly/2wxMnCa
" " ====================
" function! s:auto_diffupdate() abort
"   if &diff
"     diffupdate
"   endif
" endfunction
" autocmd MyAutoCmd TextChanged * call s:auto_diffupdate()


" ====================
" ディレクトリ自動生成
"   https://github.com/skanehira/dotfiles/blob/1a311030cbd201d395d4846b023156f346c6a1aa/vim/vimrc#L384-L394
" ====================
function! s:auto_mkdir(dir)
  if !isdirectory(a:dir)
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
augroup my-auto-mkdir
  au!
  au BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
augroup END


" ====================
" ファイル閉じても、undoできるようにする
" ====================
if has('persistent_undo')
  if !isdirectory($HOME.'/.vim/undo')
    call mkdir($HOME.'/.vim/undo')
  endif
  set undodir=$HOME/.vim/undo
  augroup MyAutoCmdUndofile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif


" ====================
" IME を自動で OFF
" ====================
let s:ahk_exe_path = '/mnt/c/Program Files/AutoHotkey/AutoHotkeyU64.exe'
let s:im_disable_script_path = expand('<sfile>:h:h') .. '/ahk/imDisable.ahk'

function! s:isWSL() abort
  return filereadable('/proc/sys/fs/binfmt_misc/WSLInterop')
endfunction

if s:isWSL() && executable(s:ahk_exe_path)
  augroup my-InsertLeave-ImDisable
    autocmd!
    autocmd InsertLeave * :call system(printf('%s "%s"', shellescape(s:ahk_exe_path), s:im_disable_script_path))
  augroup END
endif




" =============================================================================
" FileType
"   from https://zenn.dev/rapan931/articles/081a302ed06789
" =============================================================================
augroup my_filetypes
  autocmd!
  autocmd FileType * call <SID>autocmd_filetypes(expand('<amatch>'))
augroup END
function! s:autocmd_filetypes(ft) abort
  if !empty(a:ft) && exists(printf('*s:my_ft_%s', a:ft))
    execute printf('call s:my_ft_%s()', a:ft)
  endif
endfunction


" ====================
" help
" ====================
function! VimDocFormat() abort
  for l:lnum in range(1, line('$'))
    let l:line = getline(l:lnum)
    if l:line =~# '\*$'
      let l:space_cnt = &textwidth - strdisplaywidth(substitute(l:line, '\v\s+', '', 'g'))
      let l:new_line = substitute(l:line, '\v^[[:graph:]]+\zs\s+', repeat(' ', l:space_cnt), '')
      call setline(l:lnum, l:new_line)
    endif
  endfor
  echo '[VimDocFormat] Formatted!'
endfunction

function! s:my_ft_help() abort
  " help を q で閉じれるようにする
  nnoremap <buffer> q <C-w>c
  nnoremap <buffer> <Space>bl :<C-u> call VimDocFormat()<CR>
endfunction


" ====================
" quickfix
" ====================
" https://github.com/neovim/neovim/pull/13079 がマージされないといけない...
function! s:colder() abort
  if getqflist({'nr': 0}).nr ==# 1
    " execute getqflist({'nr': '$'}).nr .. 'chistory'
  else
    execute 'colder'
  endif
endfunction

function! s:cnewer() abort
  if getqflist({'nr': 0}).nr ==# getqflist({'nr': '$'}).nr
    " execute '1chistory'
  else
    execute 'cnewer'
  endif
endfunction

function! s:my_ft_qf() abort
  nnoremap <buffer>         p         <CR>zz<C-w>p
  nnoremap <buffer><silent> q         :<C-u>quit<CR>
  nnoremap <buffer><silent> <C-q>     :<C-u>quit<CR>

  nnoremap <buffer><silent> j  j
  nnoremap <buffer><silent> k  k
  nnoremap <buffer><silent> gj gj
  nnoremap <buffer><silent> gk gk

  nnoremap <buffer><silent> <A-l> :<C-u>call <SID>cnewer()<CR>
  nnoremap <buffer><silent> <A-h> :<C-u>call <SID>colder()<CR>

  " nnoremap <Plug>(qfpreview-toggle-auto-show) :<C-u>lua require'vimrc.qfpreview'.toggle_auto_preview()<CR>
  " nnoremap <Plug>(qfpreview-show)             :<C-u>lua require'vimrc.qfpreview'.show()<CR>
  " nnoremap <Plug>(qfpreview-goto-preview-win) :<C-u>noautocmd call win_gotoid(bufwinid(t:qfpreview_bufnr))<CR>
  "
  " nmap <buffer>         <A-k> <Plug>(qfpreview-toggle-auto-show)
  " nmap <buffer><silent> <A-f> <Plug>(qfpreview-show)
  " nmap <buffer><silent> <A-p> <Plug>(qfpreview-goto-preview-win)
  "
  " command! -buffer ToggleQfPreview lua require'vimrc.qfpreview'.toggle_auto_preview()<CR>
  "
  " nnoremap <buffer><silent> <CR> :<C-u>lua require'vimrc.qfpreview'.edit()<CR>

  resize 20
  setlocal signcolumn=no
  setlocal cursorline
  setlocal number
endfunction



" ====================
" json
" ====================
function! s:my_ft_json() abort
  " // をコメントとする
  syntax match Comment +\/\/.\+$+
  setlocal concealcursor=nc
endfunction


" ====================
" gitconfig
" ====================
function! s:my_ft_gitconfig() abort
  setlocal noexpandtab
endfunction


" ====================
" scheme
" ====================
function! s:my_ft_scheme() abort
  let g:paredit_mode = 1
  call PareditInitBuffer()
endfunction


" lexima を使ってやることにした
" " ====================
" " markdown
" " ====================
" function! s:my_ft_markdown() abort
"   function! s:markdown_space() abort
"     let l:col = getpos('.')[2]
"     " 先頭でリストではなかったら、* とする
"     if l:col ==# 1 && getline('.') !~# '^\s*\* .*'
"       return '* '
"     endif
"
"     " インデント
"     let l:line = getline('.')[:l:col]
"     if l:line =~# '\v^\s*\* \s*$'
"       return "\<C-t>"
"     endif
"     return "\<Space>"
"   endfunction
"
"   inoremap <buffer>        <Tab>   <C-t>
"   inoremap <buffer>        <S-Tab> <C-d>
"   inoremap <buffer> <expr> <Space> <SID>markdown_space()
"   " inoremap <buffer> <expr> <CR>    <SID>cr()
"
"   function! s:markdown_cr() abort
"     let l:line = getline('.')
"     let l:col = getpos('.')[2]
"     " 先頭が * and 末尾にカーソルがあるとき
"     if l:line =~# '\v^\s*\*' && l:line[l:col:] ==# ''
"       return "\<C-o>:InsertNewBullet\<CR>"
"     endif
"     return "\<CR>"
"   endfunction
"
"   if exists('g:loaded_bullets_vim')
"     inoremap <silent> <buffer> <expr> <CR> <SID>markdown_cr()
"     nnoremap <silent> <buffer> o    :<C-u>InsertNewBullet<CR>
"     " vnoremap <silent> <buffer> gN   <C-u>:RenumberSelection<CR>
"     " nnoremap <silent> <buffer> gN   <C-u>:RenumberList<CR>
"     " nnoremap <silent> <buffer> <Space>x <C-u>:ToggleCheckbox<CR>
"   endif
" endfunction
" ====================
" markdown
" ====================
function! s:my_ft_markdown() abort
  setlocal concealcursor=n
endfunction


" ====================
" python
" ====================
function! s:python_send_lines() abort
  let l:colon = v:false
  let l:lines = getline(getpos("'<")[1], getpos("'>")[1])
  for l:line in l:lines
    call deol#send(l:line)
    sleep 50ms
  endfor
endfunction

function! s:my_ft_python() abort
  " " from jedi-vim
  " function! s:smart_auto_mappings() abort
  "     let l:line = line('.')
  "     let l:completion_start_key = "\<C-Space>"
  "     if search('\m^\s*from\s\+[A-Za-z0-9._]\{1,50}\%#\s*$', 'bcn', l:line)
  "         return "\<Space>import\<Space>"
  "     return "\<Space>"
  " endfunction
  "
  " imap <silent> <buffer> <expr> <Space> <SID>smart_auto_mappings()

  nnoremap <buffer><silent> ,f :<C-u>call deol#send(getline('.'))<CR>
  vnoremap <buffer><silent> ,f :<C-u>call <SID>python_send_lines()<CR>
endfunction


" ====================
" sql
" ====================
function! s:my_ft_sql() abort
  nnoremap <Space>bl :<C-u>SQLFmt<CR>

  if !empty(globpath(&rtp, 'autoload/nrrwrgn.vim'))
    vnoremap <Space>bl :NR<CR> \| :SQLFmt<CR> \| :write<CR> \| :close<CR>
  endif
endfunction


" ====================
" sml
" ====================

" --------------------
" 複数行送信
" --------------------
function! s:sml_send_lines() abort
  let l:colon = v:false
  let l:lines = getline(getpos("'<")[1], getpos("'>")[1])
  for l:line in l:lines
    call deol#send(l:line)
    sleep 50ms
  endfor
  if l:lines[-1] !~# ';$'
    call deol#send(';')
  endif
endfunction

" --------------------
" 選択範囲でフォーマット
" --------------------
function! s:vsmlformat() abort
  let l:cmd = winrestcmd()
  :'<,'>NarrowRegion
  SmlFormat
  wq
  exec l:cmd
endfunction
command! -range VSmlFormat call <SID>vsmlformat()

function! s:start_sml() abort
  new
  Deol -command=sml -no-start-insert -no-edit
  wincmd w
endfunction


function! s:my_ft_smlnj() abort
  nnoremap <buffer>         <Space>bl :<C-u>SmlFormat<CR>
  vnoremap <buffer><silent> <Space>bl :<C-u>VSmlFormat<CR>
  nnoremap <buffer><silent> <Space>re :<C-u>call <SID>start_sml()<CR>

  iabbrev <buffer> func fun

  " deol.nvim との連携
  " send all
  nnoremap <buffer><silent> ,a :<C-u>call deol#send('use "' . expand("%:p:t") . '";')<CR>
  " send line
  nnoremap <buffer><silent> ,f :<C-u>call deol#send('' . getline('.') . (getline('.') =~# ';$' ? '' : ';'))<CR>
  vnoremap <buffer><silent> ,f :<C-u>call <SID>sml_send_lines()<CR>

  " off autopairs
  inoremap <buffer> ' '
endfunction

function! s:my_ft_sml() abort
  call s:my_ft_smlnj()
endfunction


" ====================
" c
" ====================
function! s:my_ft_c() abort
  nnoremap <buffer> - :<C-u>A<CR>

  " https://github.com/neovim/neovim/blob/master/CONTRIBUTING.md#style
  " Neovim のため
  if !empty(findfile('.clang-format', ';'))
    setlocal formatprg=clang-format\ -style=file
  endif
endfunction
function! s:my_ft_cpp() abort
  call s:my_ft_c()
endfunction


" ====================
" diff
" ====================
function! s:my_ft_diff() abort
  nnoremap <buffer><silent> <A-j> :<C-u>call search('^--- a', 'W')<CR>
  nnoremap <buffer><silent> <A-k> :<C-u>call search('^--- a', 'Wb')<CR>
  nnoremap <buffer><silent> ? :<C-u>LeaderfPatchFiles<CR>
endfunction


" ====================
" patch
" ====================
augroup MyLfPatch
  autocmd!
  autocmd BufEnter *.patch nnoremap <silent><buffer> ? :<C-u>LeaderfPatchFiles<CR>
augroup END


" ====================
" git
" ====================
function! s:my_ft_git() abort
  nnoremap <silent><buffer> ? :<C-u>LeaderfPatchFiles<CR>
endfunction


" ====================
" lua
" ====================
function! s:my_ft_lua() abort
  nnoremap <buffer><silent> <Space>vs. :<C-u>luafile %<CR>
  " nnoremap <buffer><silent> <Space>rr  :<C-u>luafile %<CR>
  nnoremap <buffer><silent> <Space>bl <Cmd>call <SID>equal_format()<CR>
  xnoremap <buffer><silent> <Space>bl <Cmd>call <SID>equal_format()<CR>

  nnoremap <buffer><silent> <Space>bf :<C-u>silent lmake\| lopen<CR>

  " if exists(':AlterCommand')
  "   call altercmd#define('<buffer>', 'so', 'luaf')
  " endif
endfunction


" ====================
" neosnippet
" ====================
function! s:my_ft_neosnippet() abort
  " setlocal noexpandtab
  nnoremap <buffer> ? :<C-u>h neosnippet<CR> \| <C-w>L<CR>
endfunction


" ====================
" gitcommit
" ====================
function! s:my_ft_gitcommit() abort
  setlocal textwidth=72
  " 自動で折り返しを行う
  setlocal formatoptions+=t
  setlocal spell spelllang=en_us
  startinsert!
endfunction

" ====================
" vim
" ====================
function! s:equal_format() abort
  let l:winview = winsaveview()
  if mode() =~? 'v'
    normal! =
  else
    normal! ggVG=
  endif
  call winrestview(l:winview)
endfunction
function! s:my_ft_vim() abort
  nnoremap <buffer><silent> <Space>bl <Cmd>call <SID>equal_format()<CR>

  " if exists(':AlterCommand')
  "   call altercmd#define('<buffer>', 'so', 'so %')
  " endif

endfunction



" ====================
" rust
" ====================
command! QCargoRun call QCrun()
command! QCargoTest call QCrun({'type': 'test'})
function! QCrun(...) abort
  let l:opts = get(a:, 1, {})

  let l:curwin = win_getid()
  let l:result_bufnr = v:null
  for l:win in nvim_tabpage_list_wins(0)
    let l:bufnr = nvim_win_get_buf(l:win)

    " 100:cargo run みたいなバッファを探す
    if bufname(l:bufnr) =~# '\v\d+:cargo '
      " もし、あれば移動する
      let l:result_bufnr = l:bufnr
      break
    endif
  endfor

  let l:cmd = 'run'
  let l:args = ''

  " cmd
  if get(l:opts, 'type', '') ==# 'test'
    let l:cmd = 'test'
  else
    " args
    if expand('%:p:h:t') ==# 'examples'
      let l:args = ' --example ' .. substitute(expand('%:p:t'), '.rs', '', '')
    endif
  endif

  if l:result_bufnr == v:null
    execute '15 new'
  else
    execute printf('noautocmd %d wincmd w', bufwinnr(l:bufnr))
  endif

  execute printf('terminal cargo %s %s', l:cmd, l:args)
  call win_gotoid(l:curwin)
endfunction

function! s:my_ft_rust() abort
  nnoremap <buffer>         <Space>bl :<C-u>RustFmt<CR>
  nnoremap <buffer><silent> <Space>rr :<C-u>QCargoRun<CR>
  nnoremap <buffer><silent> <Space>rt :<C-u>QCargoTest<CR>

  xnoremap <buffer> <A-d> :<C-u>execute printf('OpenBrowserSmartSearch -rust_doc_std %s', vimrc#getwords_last_visual())<CR>
  nnoremap <buffer> <A-d> :<C-r>=printf('OpenBrowserSmartSearch -rust_doc_std ')<CR>
endfunction


" ====================
" zsh
" ====================
function! s:my_ft_zsh() abort
  " treesitter を使ってしまうと、入らないため
  " setlocal iskeyword+=-
endfunction


" ====================
" make
" ====================
function! s:my_ft_make() abort
  setlocal iskeyword+=-
endfunction
