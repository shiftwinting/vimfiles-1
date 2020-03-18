scriptencoding utf-8

augroup MyAutoCmd
    autocmd!
augroup END


" XXX: これいらない？デフォルトで ro は含まれていないため
" 自動でコメント開始文字を挿入しないようにする
" autocmd MyAutoCmd FileType * setlocal formatoptions-=r formatoptions-=o

autocmd MyAutoCmd VimEnter,WinEnter * call matchadd('Tab', '\t')
autocmd MyAutoCmd VimEnter,WinEnter * call matchadd('Eol', '$')

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

" 拡張子をもとにファイルタイプを設定
autocmd MyAutoCmd BufRead,BufWinEnter *.ini set filetype=dosini
autocmd MyAutoCmd BufRead,BufWinEnter *.csv set filetype=csv
autocmd MyAutoCmd BufRead,BufWinEnter *.jsx set filetype=javascript.jsx

" omnifunc
" https://github.com/vim/vim/tree/master/runtime/autoload
autocmd MyAutoCmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" すぐに quickfixwidow を開く
autocmd MyAutoCmd QuickFixCmdPost *grep* botright cwindow

function! TerminalSettings() abort
    setlocal nolist
    setlocal signcolumn=no
    setlocal cursorline
endfunction
autocmd MyAutoCmd TerminalWinOpen * call TerminalSettings()

" <script type="text/x-template"> のハイライトを正しくする
" https://github.com/yuezk/vim-js/issues/1
" XXX: matchgroup が理解できない...
"       matchgroup で指定したハイライトは、start ~ end の間では使わないようにする?
" start ~ end の間で @htmlTop を入れられるよー
autocmd MyAutoCmd FileType html syn region htmlTemplate matchgroup=htmlScriptTag
\           start=+<script\s*type="text/x-template"\_[^>]*>+ keepend end=+</script\_[^>]*>+ contains=@htmlTop



" cmdline-window コマンドラインウィンドウ
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
    call cursor(line('.'), s:cmdline_cursor_pos)
endfunction

function! CmdlineSaveCursorPos() abort
    let s:cmdline_cursor_pos = getcmdpos()
endfunction

augroup MyCmdWinSettings
    autocmd!
    autocmd CmdwinEnter * call CmdlineEnterSettings()
    autocmd CmdwinLeave * call CmdlineLeaveSettings()
    autocmd CmdlineChanged * call CmdlineSaveCursorPos()
    autocmd CmdwinEnter : call CmdlineRemoveLinesExec()
augroup END

" help を q で閉じれるようにする
autocmd MyAutoCmd FileType help nnoremap <buffer> q <C-w>c

" quickfix
function! QfSettings() abort
    nnoremap <buffer>         p         <CR>zz<C-w>p
    nnoremap <buffer><silent> q         :<C-u>quit<CR>
    nnoremap <buffer><silent> <C-q>     :<C-u>quit<CR>
    setlocal winheight=20

    nnoremap <buffer><silent> j  j
    nnoremap <buffer><silent> k  k
    nnoremap <buffer><silent> gj gj
    nnoremap <buffer><silent> gk gk
endfunction

autocmd MyAutoCmd FileType qf call QfSettings()

" カーソルラインの位置を保存する
" from skanehira/dotfiles (http://bit.ly/2N82age)
autocmd MyAutoCmd BufReadPost *
\   if line("'\"") > 0 && line("'\"") <= line("$") |
\     exe "normal! g'\"" |
\   endif

" // をコメントとする
autocmd MyAutoCmd FileType json syntax match Comment +\/\/.\+$+

autocmd MyAutoCmd BufRead,BufNewFile Vagrantfile set ft=ruby

" help
" http://bit.ly/2VQFGWr
function! s:ft_help() abort
    wincmd L
    82wincmd |
    setlocal winfixwidth
endfunction
autocmd MyAutoCmd BufEnter * if &buftype ==# 'help' | call <SID>ft_help() | endif

" diffthis しているときにテキスト更新したら diffupdate
" http://bit.ly/2wxMnCa
function! s:auto_diffupdate() abort
    if &diff
        diffupdate
    endif
endfunction
autocmd MyAutoCmd TextChanged * call s:auto_diffupdate()

" xxx-xxx もキーワードとして認識させる
autocmd MyAutoCmd FileType scss set iskeyword+=-


" ====================
" format
" ====================
function! s:format_vim() abort
    " カーソル位置の保存と復元
    let l:pos = getcurpos()
    normal! gg=G
    call setpos('.', l:pos)
endfunction
autocmd MyAutoCmd FileType vim nnoremap <buffer> <Space>bl :call <SID>format_vim()<CR>
