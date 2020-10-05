scriptencoding utf-8

noremap ZZ <Nop>
noremap ZQ <Nop>
noremap <C-z> <Nop>
" nnoremap ; <Nop>

" insert mode で細かく undo できるようにする
inoremap <CR> <C-g>u<CR>
inoremap <C-h> <Nop>
inoremap <C-h> <C-g>u<C-h>
inoremap <BS> <C-g>u<BS>
inoremap <Del> <C-g>u<Del>
" inoremap <C-d> <C-g>u<Del>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>

" Insert mode を emacs 風にする
inoremap <C-a> <C-o>_
inoremap <C-e> <Nop>
inoremap <C-e> <END>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" 選択範囲で . を実行
vnoremap <silent> . :normal! .<CR>

" シンボリックリンクの先に移動する
nnoremap <silent> cd :<C-u>exec 'lcd '.resolve(expand('%:p:h'))<CR>

" 前にいたバッファを表示. めっちゃ好きこれ
" nnoremap 6 

" vimrc
nnoremap <silent> <Space>v.  :<C-u>call vimrc#drop_or_tabedit($MYVIMRC)<CR>
nnoremap <silent> <Space>v,  :<C-u>call vimrc#drop_or_tabedit(g:plug_script)<CR>

" nnoremap <silent> <Space>vs. :<C-u>source $MYVIMRC<CR> :call vimrc#echoinfo(' $MYVIMRC loaded!')<CR>
nnoremap <silent> <Space>vs. :<C-u>source %<CR>        :call vimrc#echoinfo(' source %')<CR>
" nnoremap <silent> <Space>vs, :<C-u>exec 'source '.g:plug_script<CR> :call vimrc#echoinfo(' plug_script loaded!')<CR>

" 保存、終了
" 変更があったときのみ、保存される
nnoremap <silent> <Space>w :<C-u>update<CR>
nnoremap <silent> <Space>W :<C-u>update!<CR>
nnoremap <silent> <Space>q :<C-u>quit<CR>
nnoremap <silent> <Space>Q :<C-u>quit!<CR>

" window ウィンドウ操作
" s の無効化
nnoremap s <Nop>
vnoremap s <Nop>

nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L

" カレントウィンドウを新規タブで開く
nnoremap st <C-w>T
" カレントウィンドウを複製し、タブで開く
nnoremap sT <C-w>s<C-w>T
" タブを閉じる
nnoremap <silent> sc :<C-u>tabclose<CR>

" 新規ウィンドウ
nnoremap <silent> sn :<C-u>new<CR>
nnoremap <silent> sv :<C-u>vnew<CR>

" <C-w>n,v 無効化
nnoremap <C-w><C-n> <Nop>
nnoremap <C-w>n <Nop>
nnoremap <C-w><C-v> <Nop>
nnoremap <C-w>v <Nop>

" 新規タブ
nnoremap <silent> so :<C-u>tabedit<CR>

" 一時ファイルの作成
nnoremap <silent> sf :<C-u>NewTempFile<CR>

" 見た目通りに移動
nnoremap j gj
nnoremap k gk

nnoremap <Space>h ^
vnoremap <Space>h ^
nnoremap <Space>l $
vnoremap <Space>l $h

" 上下の空白に移動
" https://twitter.com/Linda_pp/status/1108692192837533696
nnoremap <C-j> }
nnoremap <C-k> {
vnoremap <C-j> }
vnoremap <C-k> {

nnoremap G Gzz

" cmdline コマンドライン
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" カーソルから行末までコピー
nnoremap Y y$
" 全行コピー
nnoremap <Space>ay :<C-u>%y<CR>

" paste 貼り付け
" 最後にコピーしたテキストを貼り付ける
" 選択し、貼り付けると、 "* が更新されてしまうため
nnoremap <Space>p "0p
vnoremap <Space>p "0p

" マクロ
" Q でマクロを再実行
nnoremap Q @@
" 選択範囲で マクロ繰り返し
vnoremap <silent> @q :normal! @q<CR>

" タブ
nnoremap tg <Nop>
nnoremap gt <Nop>
nnoremap <C-l> gt
nnoremap <C-h> gT

" terminal
tnoremap <C-r> <Nop>
execute 'tnoremap <C-r><C-r> ' . &termwinkey . '"*'
execute 'tnoremap ' . '&termwinkey' . 'p <Nop>'
" C-[ でTerminal Job モードへ移行
tnoremap <Esc> <C-\><C-n>


" search 検索
nnoremap <silent> <Esc><Esc> :noh<CR>
" / => \/ とする
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
" :help magic を参照
nnoremap / /\v

" XXX: あまり使っていない...
" 選択範囲内の検索
" 選択しているところで、一旦抜けて(<Esc>)、/%Vで(gvで直前に選択した範囲を検索している)
" :help \%V に詳細がある
vnoremap / <Esc>/\%V

" クリップボード内の内容で検索
" TODO エスケープ必要なものはエスケープする '\' => '\\' みたいな
nnoremap <Space>/ /\V<C-R>*<CR>

" from arecarn's vimrc (ttp://bit.ly/33bxPUV)
nnoremap # :<C-U>call AddToSearch('n')<CR>
xnoremap # :<C-U>call AddToSearch('x')<CR>
function! AddToSearch(mode) abort
    let l:save_reg = @@
    if @/ !=# ''
        if @/ ==# '^\v'
            let @/ .= '|'
        else
            let @/ .= '\|'
        endif
    endif
    if a:mode ==# 'x'
        normal! gvy
    elseif a:mode ==# 'n'
        normal! yiw
    else
        let @@ = l:save_reg
    endif
    let @/ .= @@
    let @@ = l:save_reg
endfunction

" 選択文字列を指定の文字で置換
" 1. `"hy`で選択した範囲の文字列を`h`レジスタに格納
" 2. `:%s/\V<C-R>h//g`で`h`レジスタにある文字列を検索文字として挿入
" 3. `<left><left>`で置換後の文字列を入力しやすいようにしている
" vnoremap <C-R>s "hy:%s/\v(<C-R>h)//g<left><left>
vnoremap <C-R>      "hy:%s/\v(<C-R>h)//g<left><left>
vnoremap <C-R><C-d> "hy:%s/\V\(<C-R>h\)//g<left><left>
nnoremap <C-R><C-d> v"hy:%s/\V\(<C-R>h\)//g<left><left>

" diff
nnoremap <silent> <Space>dt :<C-u>windo diffthis<CR>
nnoremap <silent> <Space>do :<C-u>windo diffoff<CR>
nnoremap <silent> <Space>dp :diffput<CR>
vnoremap <silent> <Space>dp :diffput<CR>
nnoremap <silent> <Space>dg :diffget<CR>
vnoremap <silent> <Space>dg :diffget<CR>

" toggle option
function! MapToggleOption(key, opt) abort
    exec 'nnoremap <silent> '.a:key.' :<C-u>setlocal '.a:opt.'!<CR> :echo "toggle '.a:opt.'"<CR>'
endfunction
" :help set-!
call MapToggleOption('<F2>', 'wrap')
call MapToggleOption('<F3>', 'readonly')

" helpをqで閉じる
" 選択している文字列をhelpで引く
vnoremap <A-h> "hy:help <C-R>h<CR>
nnoremap <A-h> :<C-u>h 
vnoremap K <Nop>

" クリップボード貼り付け
inoremap <C-r><C-r> <C-r>*
cnoremap <C-o> <C-r>*

" " 挿入モードから抜けるときに IME をOFFにする
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" 対応するカッコの移動
" nmap 5 %
" vmap 5 %
" nmap t <Nop>
" xmap t <Nop>

nmap tj %
xmap tj %

" 置換を再実行
" nmap 7 &

" tyru さんのマッピング
" https://github.com/tyru/config/blob/master/home/volt/rc/vimrc-only/vimrc.vim#L618
inoremap <C-l><C-l> <C-x><C-l>
inoremap <C-l><C-n> <C-x><C-n>
inoremap <C-l><C-k> <C-x><C-k>
inoremap <C-l><C-t> <C-x><C-t>
inoremap <C-l><C-i> <C-x><C-i>
inoremap <C-l><C-]> <C-x><C-]>
inoremap <C-l><C-f> <C-x><C-f>
inoremap <C-l><C-d> <C-x><C-d>
inoremap <C-l><C-v> <C-x><C-v>
inoremap <C-l><C-u> <C-x><C-u>
inoremap <C-l><C-o> <C-x><C-o>
inoremap <C-l><C-s> <C-x><C-s>
inoremap <C-l><C-p> <C-x><C-p>

" 置換
nnoremap <Space>s<Space> :%s///g<Left><Left>

" from https://github.com/wass88/dotfiles/blob/62ad8bca0a494c45294164fb9df27ee440b23e87/.vimrc#L876
vnoremap <C-a> <C-a>gv
vnoremap <C-X> <C-X>gv

nnoremap <space>i i_<ESC>r
