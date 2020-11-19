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
autocmd MyAutoCmd FileType vim          setlocal sw=4 sts=4 ts=4 et
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


" 拡張子をもとにファイルタイプを設定
autocmd MyAutoCmd BufRead,BufWinEnter *.ini set filetype=dosini
autocmd MyAutoCmd BufRead,BufWinEnter *.csv set filetype=csv
autocmd MyAutoCmd BufRead,BufWinEnter *.jsx set filetype=javascript.jsx
autocmd MyAutoCmd BufRead,BufWinEnter *.pl0 set filetype=pl0
autocmd MyAutoCmd BufRead,BufWinEnter *.ml  set filetype=smlnj

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
    setlocal signcolumn=no
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


" ====================
" diffthis しているときにテキスト更新したら diffupdate
" http://bit.ly/2wxMnCa
" ====================
function! s:auto_diffupdate() abort
    if &diff
        diffupdate
    endif
endfunction
autocmd MyAutoCmd TextChanged * call s:auto_diffupdate()


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
" help
" ====================
function! s:my_ft_help() abort
    " help を q で閉じれるようにする
    nnoremap <buffer> q <C-w>c
endfunction
autocmd MyAutoCmd FileType help call <SID>my_ft_help()


" ====================
" quickfix
" ====================
function! s:my_ft_qf() abort
    nnoremap <buffer>         p         <CR>zz<C-w>p
    nnoremap <buffer><silent> q         :<C-u>quit<CR>
    nnoremap <buffer><silent> <C-q>     :<C-u>quit<CR>
    resize 20

    nnoremap <buffer><silent> j  j
    nnoremap <buffer><silent> k  k
    nnoremap <buffer><silent> gj gj
    nnoremap <buffer><silent> gk gk
endfunction
autocmd MyAutoCmd FileType qf call <SID>my_ft_qf()



" ====================
" json
" ====================
function! s:my_ft_json() abort
    " // をコメントとする
    syntax match Comment +\/\/.\+$+
endfunction
autocmd MyAutoCmd FileType json call <SID>my_ft_json()


" ====================
" gitconfig
" ====================
function! s:my_ft_gitconfig() abort
    setlocal noexpandtab
endfunction
autocmd MyAutoCmd FileType gitconfig call <SID>my_ft_gitconfig()


" ====================
" scheme
" ====================
function! s:my_ft_scheme() abort
    let g:paredit_mode = 1
    call PareditInitBuffer()
endfunction
autocmd MyAutoCmd FileType scheme call <SID>my_ft_scheme()


" ====================
" markdown
" ====================
function! s:my_ft_markdown() abort
    function! s:markdown_space() abort
        let l:col = getpos('.')[2]
        " 先頭でリストではなかったら、* とする
        if l:col ==# 1 && getline('.') !~# '^\s*\* .*'
            return '* '
        endif

        " インデント
        let l:line = getline('.')[:l:col]
        if l:line =~# '\v^\s*\* \s*$'
            return "\<C-t>"
        endif
        return "\<Space>"
    endfunction

    inoremap <buffer>        <Tab>   <C-t>
    inoremap <buffer>        <S-Tab> <C-d>
    inoremap <buffer> <expr> <Space> <SID>markdown_space()
    " inoremap <buffer> <expr> <CR>    <SID>cr()

    function! s:markdown_cr() abort
        let l:line = getline('.')
        let l:col = getpos('.')[2]
        " 先頭が * and 末尾にカーソルがあるとき
        if l:line =~# '\v^\s*\*' && l:line[l:col:] ==# ''
            return "\<C-o>:InsertNewBullet\<CR>"
        endif
        return "\<CR>"
    endfunction

    if exists('g:loaded_bullets_vim')
        inoremap <silent> <buffer> <expr> <CR> <SID>markdown_cr()
        nnoremap <silent> <buffer> o    :<C-u>InsertNewBullet<CR>
        " vnoremap <silent> <buffer> gN   <C-u>:RenumberSelection<CR>
        " nnoremap <silent> <buffer> gN   <C-u>:RenumberList<CR>
        " nnoremap <silent> <buffer> <Space>x <C-u>:ToggleCheckbox<CR>
    endif
endfunction

autocmd MyAutoCmd FileType markdown call s:my_ft_markdown()


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
autocmd MyAutoCmd FileType python call s:my_ft_python()


" ====================
" sql
" ====================
function! s:my_ft_sql() abort
    nnoremap <Space>bl :<C-u>SQLFmt<CR>

    if !empty(globpath(&rtp, 'autoload/nrrwrgn.vim'))
        vnoremap <Space>bl :NR<CR> \| :SQLFmt<CR> \| :write<CR> \| :close<CR>
    endif
endfunction
autocmd MyAutoCmd FileType sql call s:my_ft_sql()


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


function! s:my_ft_sml() abort
    nnoremap <buffer>         <Space>bl :<C-u>SmlFormat<CR>
    vnoremap <silent><buffer> <Space>bl :<C-u>VSmlFormat<CR>
    nnoremap <silent><buffer> <Space>re :<C-u>call <SID>start_sml()<CR>

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

autocmd MyAutoCmd FileType smlnj call s:my_ft_sml()


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
autocmd MyAutoCmd FileType c,cpp call s:my_ft_c()


" ====================
" diff
" ====================
function! s:my_ft_diff() abort
    nnoremap <buffer><silent> <A-j> :<C-u>call search('^--- a', 'W')<CR>
    nnoremap <buffer><silent> <A-k> :<C-u>call search('^--- a', 'Wb')<CR>
    nnoremap <silent><buffer> ? :<C-u>LeaderfPatchFiles<CR>
endfunction
autocmd MyAutoCmd FileType diff call s:my_ft_diff()


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
autocmd MyAutoCmd FileType git call s:my_ft_git()

function! s:my_ft_lua() abort
    nnoremap <buffer><silent> <Space>vs. :<C-u>luafile %<CR>
    " nnoremap <buffer><silent> <Space>rr  :<C-u>luafile %<CR>
endfunction
autocmd MyAutoCmd FileType lua call s:my_ft_lua()


" ====================
" neosnippet
" ====================
function! s:my_ft_neosnippet() abort
    setlocal noexpandtab
    nnoremap ? :<C-u>h neosnippet<CR> \| <C-w>L<CR>
endfunction
autocmd MyAutoCmd Filetype neosnippet call <SID>my_ft_neosnippet()

" " 自動で読み込む
" autocmd MyAutoCmd BufWritePost plugins.vim exec 'source ' .. expand('<afile>')


function! s:my_ft_lir() abort
    nnoremap <buffer> l     <cmd>lua require'vimrc.lir.actions'.edit()<CR>
    nnoremap <buffer> o     <cmd>lua require'vimrc.lir.actions'.edit()<CR>
    nnoremap <buffer> <C-s> <cmd>lua require'vimrc.lir.actions'.split()<CR>
    nnoremap <buffer> <C-v> <cmd>lua require'vimrc.lir.actions'.vsplit()<CR>

    nnoremap <buffer> h     <cmd>lua require'vimrc.lir.actions'.up()<CR>
    nnoremap <buffer> q     <cmd>lua require'vimrc.lir.actions'.quit()<CR>
    nnoremap <buffer> <C-e> <cmd>lua require'vimrc.lir.actions'.quit()<CR>

    nnoremap <buffer> K     <cmd>lua require'vimrc.lir.actions'.mkdir()<CR>
    nnoremap <buffer> N     <cmd>lua require'vimrc.lir.actions'.newfile()<CR>
    nnoremap <buffer> R     <cmd>lua require'vimrc.lir.actions'.rename()<CR>
    nnoremap <buffer> @     <cmd>lua require'vimrc.lir.actions'.cd()<CR>
    nnoremap <buffer> Y     <cmd>lua require'vimrc.lir.actions'.yank_path()<CR>
    nnoremap <buffer> .     <cmd>lua require'vimrc.lir.actions'.toggle_show_hidden()<CR>
endfunction

augroup my-ft-lauir
    autocmd!
    autocmd FileType lir call <SID>my_ft_lir()
    autocmd BufEnter * lua require'vimrc.lir'.init()
augroup END
