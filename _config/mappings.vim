scriptencoding utf-8


" " insert mode で細かく undo できるようにする
" inoremap <Del> <C-g>u<Del>
" inoremap <C-w> <C-g>u<C-w>
" inoremap <C-u> <C-g>u<C-u>

" like emacs
inoremap <C-a> <C-o>_
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" 選択範囲で . を実行
xnoremap . :normal! .<CR>

" シンボリックリンクの先に移動する
nnoremap cd <Cmd>exec 'lcd ' .. fnamemodify(resolve(expand('%:p')), ':h') \| pwd<CR>

nnoremap <silent><expr> <Space>vs. (&filetype ==# 'lua' ? '<Cmd>luafile %<CR>' : '<Cmd>source %<CR>')

" update は変更があったときのみ保存するコマンド
nnoremap <Space>w <Cmd>update<CR>
nnoremap <Space>W <Cmd>update!<CR>
nnoremap <Space>q <Cmd>quit<CR>
nnoremap <Space>Q <Cmd>quit!<CR>

" window 操作
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L

nnoremap sn <Cmd>new<CR>
nnoremap sp <Cmd>split<CR>
nnoremap sv <Cmd>vsplit<CR>

" カレントウィンドウを新規タブで開く
nnoremap st <C-w>T

" 新規タブ
nnoremap so <Cmd>tabedit<CR>

" タブ間の移動
nnoremap gt <Nop>
nnoremap gT <Nop>
nnoremap <C-l> gt
nnoremap <C-h> gT

" 先頭と末尾
nnoremap <Space>h ^
xnoremap <Space>h ^
nnoremap <Space>l $
xnoremap <Space>l $h

" 上下の空白に移動
" https://twitter.com/Linda_pp/status/1108692192837533696
nnoremap <silent> <C-j> <Cmd>keepjumps normal! '}<CR>
nnoremap <silent> <C-k> <Cmd>keepjumps normal! '{<CR>
xnoremap <silent> <C-j> '}
xnoremap <silent> <C-k> '{

" 見た目通りに移動
nnoremap j gj
nnoremap k gk

" 中央にする
nnoremap G Gzz

" カーソル位置から行末までコピー
nnoremap Y y$

" 全行コピー
nnoremap <Space>ay <Cmd>%y<CR>

" 最後にコピーしたテキストを貼り付ける
nnoremap <Space>p "0p
xnoremap <Space>p "0p

" 直前に実行したマクロを実行する
nnoremap Q @@

" ハイライトの消去
nnoremap <Esc><Esc> <Cmd>noh<CR>

" <C-]> で Job mode に移行
tnoremap <Esc> <C-\><C-n>

" コマンドラインで emacs っぽく
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" / -> \/ にする
cnoremap <expr> / getcmdtype() ==# '/' ? '\/' : '/'

" :h magic
nnoremap / /\v

" クリップボード内の文字列をそのまま検索
nnoremap <Space>/ /\V<C-r>+<CR>

" vimgrep でカレントバッファを検索
nnoremap <Space>gg :vimgrep /\v/ %:p<Left><Left><Left><Left><Left>

" 全行で置換
nnoremap <Space>s<Space> :<C-u>%s///g<Left><Left>

" help
xnoremap <A-h> "hy:help <C-r>h<CR>
nnoremap <A-h> :h
xnoremap K     <Nop>

" クリップボードの貼り付け
inoremap <C-r><C-r> <C-r>+
cnoremap <C-o>      <C-r>+

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

" plugins.vim を開く
nnoremap <Space>v, <Cmd>call vimrc#drop_or_tabedit(g:plug_script)<CR>

" new tempfile
nnoremap sf <Cmd>call <SID>new_tmp_file()<CR>
function! s:new_tmp_file() abort
  let l:ft = input('FileType: ', '', 'filetype')
  if l:ft ==# ''
    echo 'Cancel.'
    return
  endif

  " もし空ならそのバッファを使う
  let l:cmd = line('$') ==# 1 && getline(1) && !&modified ? 'e' : 'new'
  exec l:cmd .. ' '.. tempname()
  exec 'setfiletype ' .. l:ft
endfunction

" 再描画
nnoremap <Space>e <Cmd>call <SID>reopen()<CR>
function! s:reopen() abort
  let l:winview = winsaveview()
  e!
  call winrestview(l:winview)
endfunction

" quickfix をトグル
nnoremap <A-q> <Cmd>call <SID>toggle_quickfix()<CR>
function! s:toggle_quickfix() abort
  let l:is_show_qf = v:false
  for l:win in nvim_tabpage_list_wins(0)
    let l:buf = nvim_win_get_buf(l:win)
    if nvim_buf_get_option(l:buf, 'buftype') ==# 'quickfix'
      let l:is_show_qf = v:true
      break
    endif
  endfor

  if l:is_show_qf
    if &buftype ==# 'quickfix'
      exec 'wincmd p'
    endif
    exec 'cclose'
  else
    exec 'botright copen'
  endif
endfunction

nnoremap [q <Cmd>cprev<CR>
nnoremap ]q <Cmd>cnext<CR>

" toggle option
function! s:toggle_option(key, opt) abort
  exec printf('nnoremap %s <Cmd>setlocal %s!<CR> \| <Cmd>set %s?<CR>', a:key, a:opt, a:opt)
endfunction
call s:toggle_option('<F2>', 'wrap')
call s:toggle_option('<F3>', 'readonly')
