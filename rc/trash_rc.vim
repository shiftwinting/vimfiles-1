
" Plug 'jiangmiao/auto-pairs'
" Plug 'jremmen/vim-ripgrep'

" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'yami-beta/asyncomplete-omni.vim'
" Plug 'prabirshrestha/asyncomplete-necosyntax.vim'

" Plug 'Shougo/defx.nvim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'Shougo/neopairs.vim'

" " denite
" Plug 'Shougo/denite.nvim'
" Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
" Plug 'Shougo/unite.vim'
" Plug 'Shougo/neomru.vim'



" ==============================================================================
" jremmen/vim-ripgrep 

" nnoremap <Space>rg :<C-u>Rg 
" nnoremap <Space>fgr :<C-u>RgRoot 

" let g:rg_format = ''


" ==============================================================================
" " LeafCage/yankround.vim 
"
" nmap p      <Plug>(yankround-p)
" xmap p      <Plug>(yankround-p)
" nmap P      <Plug>(yankround-P)
" nmap <C-p>  <Plug>(yankround-prev)
" nmap <C-n>  <Plug>(yankround-next)
"
" let g:yankround_use_region_hl = 1

" " ==============================================================================
" " defx
"
" augroup MyDefx
"     autocmd!
"     autocmd FileType defx call s:defx_my_settings()
" augroup END
"
" function! DefxTcdDown(ctx) abort
"     if defx#is_directory()
"         execute 'tcd '.a:ctx.targets[0]
"         call deol#cd(getcwd())
"         call defx#call_action('open')
"     endif
" endfunction
"
" function! DefxTcdUp(ctx) abort
"     call defx#call_action('cd', ['..'])
"     execute 'tcd '.fnamemodify(a:ctx.cwd, ':p:h:h')
"     call deol#cd(getcwd())
" endfunction
"
"
" function! s:defx_my_settings() abort
"
"     setlocal cursorline
"     setlocal statusline=\ 
"
"     " file 作成
"     nnoremap <silent><buffer><expr> N
"     \ defx#do_action('new_file')
"
"     " copy
"     nnoremap <silent><buffer><expr> c
"     \ defx#do_action('copy')
"
"     " move
"     nnoremap <silent><buffer><expr> m
"     \ defx#do_action('move')
"
"     " paste
"     nnoremap <silent><buffer><expr> p
"     \ defx#do_action('paste')
"
"     " rename
"     nnoremap <silent><buffer><expr> r
"     \ defx#do_action('rename')
"
"     nnoremap <silent><buffer><expr> <CR>
"     \ defx#do_action('drop')
"
"     " 階層を下に移動
"     nnoremap <silent><buffer><expr> l
"     \ defx#do_action('call', 'DefxTcdDown')
"
"     " 階層を上に移動
"     nnoremap <silent><buffer><expr> u
"     \ defx#do_action('call', 'DefxTcdUp')
"
"     " treeの開閉
"     nnoremap <silent><buffer><expr> o
"     \ defx#is_directory() ?
"     \ defx#do_action('open_or_close_tree') :
"     \ defx#do_action('drop')
"
"     " 垂直分割で開く
"     nnoremap <silent><buffer><expr> <C-i>
"     \ defx#do_action('drop', 'vsplit')
"
"     " 分割で開く
"     nnoremap <silent><buffer><expr> <C-s>
"     \ defx#do_action('drop', 'split')
"
"     " タブで開く
"     nnoremap <silent><buffer><expr> t
"     \ defx#do_action('open', 'tabnew')
"
"     nnoremap <silent><buffer><expr> cd
"     \ defx#do_action('change_vim_cwd')
"
"     nnoremap <silent><buffer><expr> I
"     \ defx#do_action('toggle_ignored_files')
"
"     nnoremap <silent><buffer><expr> R
"     \ defx#do_action('redraw')
"
"     " 再帰で開く
"     nnoremap <silent><buffer><expr> O
"     \ defx#do_action('open_tree_recursive')
"
"     " システムで設定しているプログラムで実行する
"     nnoremap <silent><buffer><expr> x
"     \ defx#do_action('execute_system')
"
"     nnoremap <silent><buffer> H
"     \ :<C-u>HereOpen<CR>
"
"     nnoremap <silent><buffer> B
"     \ :<C-u>BookmarkList<CR>
"
"     command! -buffer BAdd call defx#call_action('add_session')
"     command! -buffer BookmarkList call DefxSessions(g:defx_session_file)
"
"     nnoremap <buffer> <C-k> <Nop>
"     nnoremap <buffer> <C-j> <Nop>
" endfunction
"
" function! DefxCurrentFileOpen() abort
"     execute "Defx -no-toggle `expand('%:p:h')` -search=`expand('%:p')`"
"     call defx#call_action('change_vim_cwd')
"     call deol#cd(getcwd())
" endfunction
"
" nnoremap <silent><C-e> :<C-u>Defx<CR>
" nnoremap <silent><Space>cdn :<C-u>call DefxCurrentFileOpen()<CR>
"
" " DefxSessions
" execute 'source '.expand('~/vimfiles/rc/plugins/defx_sessions.vim')
"
" " icon を変える
" call defx#custom#column('icon', {
" \   'directory_icon': "\uf44a",
" \   'opened_icon': "\uf44b",
" \   'root_icon': ' ',
" \})
"
" let g:defx_session_file = expand('~/.defx_sessions')
"
" " 共通のオプション
" call defx#custom#option('_', {
" \   'split': 'vertical',
" \   'winwidth': 30,
" \   'direction': 'leftabove',
" \   'toggle': 1,
" \   'show_ignored_files': 0,
" \   'root_marker': '.. ',
" \   'session_file': g:defx_session_file,
" \   'columns': 'indent:icon:filename:type',
" \})


" " ==============================================================================
" " neopairs
" let g:neopairs#enable = 1


" " ==============================================================================
" " Shougo/denite.nvim
"
" " nnoremap <silent> <Space>ff :<C-u>DeniteBufferDir file/rec -default-action=split<CR>
" " nnoremap <silent> <Space>fh :<C-u>Denite help -default-action=<CR>
" " nnoremap <silent> <Space>fb :<C-u>Denite buffer -default-action=split<Cr>
" " nnoremap <silent> <Space>fl :<C-u>Denite line -auto-action=highlight -winheight=25<CR>
" " nnoremap <silent> <Space>fk :<C-u>Denite file_mru -default-action=split<CR>
" " nnoremap <silent> <Space>fm :<C-u>Denite menu -no-start-filter<CR>
" " nnoremap <silent> <Space>fj :<C-u>Denite jump<CR>
" " nnoremap <silent> <Space>fg :<C-u>Denite unite:giti<CR>
" " https://github.com/raghur/vimfiles/blob/1a6720126308f96acf31384965c10c1ce5783a6e/vimrc#L492-L493
" " nnoremap <silent> <Space>fg :<C-u>Denite grep:::!<CR>
" " nnoremap <silent> <Space>fq :<C-u>Denite ghq -default-action=open<CR>
" " nnoremap <silent> <Space>fc :<C-u>Denite command_history<CR>
" " nnoremap <silent> <Space>fs :<C-u>Denite unite:sonictemplate<CR>
"
" " menu
" " nnoremap <silent> <Space>fmg :<C-u>Denite menu -input=gutter -no-start-filter<CR>
"
" " " 再表示
" nnoremap <silent> <Space>f[ :<C-u>Denite -resume<CR>
"
"
" call denite#custom#option('_', {
" \   'prompt': '>',
" \   'source_names': 1,
" \   'vertical_preview': 1,
" \   'direction': 'botright',
" \   'start_filter': 1,
" \   'winheight': 20,
" \   'matchers': 'matcher/fruzzy',
" \   'auto_resize': 1,
" \   'winminheight': 1,
" \   'filter-updatetime': 10,
" \   'statusline': 0,
" \})
"
"
" " rg の設定
" if executable('rg')
"   call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
"   call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
"   call denite#custom#var('grep', 'recursive_opts', [])
"   call denite#custom#var('grep', 'final_opts', [])
"   call denite#custom#var('grep', 'separator', ['--'])
"   call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep', '--no-heading'])
" endif
"
" " buffer
" " timestamp を非表示
" call denite#custom#var('buffer', 'date_format', '')
"
" " mru
" " 以下のような表示となる
" " pwd:  ~\src\
" " もと: ~\src\python\sample\main.py
" " 結果:       python\sample\main.py
" let g:neomru#filename_format = ':~:.'
" let g:neomru#file_mru_limit = 500 " default is 1000
" let g:neomru#directory_mru_limit = 500 " default is 1000
"
" function! s:denite_my_settings() abort
"     nnoremap <silent><buffer><expr> <CR>     denite#do_map('do_action')
"     nnoremap <silent><buffer><expr> d        denite#do_map('do_action', 'delete')
"     nnoremap <silent><buffer><expr> p        denite#do_map('do_action', 'preview')
"     nnoremap <silent><buffer><expr> <C-c>    denite#do_map('quit')
"     nnoremap <silent><buffer><expr> <C-q>    denite#do_map('quit')
"     nnoremap <silent><buffer><expr> i        denite#do_map('open_filter_buffer')
"     nnoremap <silent><buffer><expr> I        denite#do_map('open_filter_buffer')
"     nnoremap <silent><buffer>       <C-j>    j
"     nnoremap <silent><buffer>       <C-k>    k
"     nnoremap <silent><buffer><expr> <C-o>    denite#do_map('choose_action')
"     nnoremap <silent><buffer>       <Space>q <Nop>
"     nnoremap <silent><buffer><expr> <C-i>    denite#do_map('do_action', 'vsplit')
"     nnoremap <silent><buffer><expr> <C-s>    denite#do_map('do_action', 'split')
"
"     nnoremap <silent><buffer><expr> <A-e>    denite#do_map('do_action', 'edit_cmdlinewin')
" endfunction
"
" function! s:denite_filter_my_settigns() abort
"     nnoremap <silent><buffer>       <Space>q <Nop>
"     inoremap <silent><buffer><expr> <C-q>
"     \   denite#do_map('quit')
"     inoremap <silent><buffer><expr> <C-c>
"     \   denite#do_map('quit')
"     nnoremap <silent><buffer><expr> <C-q>
"     \   denite#do_map('quit')
"     nnoremap <silent><buffer><expr> <C-c>
"     \   denite#do_map('quit')
"
"     " <C-w>p で最後にいたウィンドウに移動できる
"     inoremap <silent><buffer> <C-k>
"     \   <Esc><C-w>p
"     inoremap <silent><buffer> <C-j>
"     \   <Esc><C-w>p:call cursor(line('.')+1,0)<CR>
"
"     nnoremap <silent><buffer><expr> <C-l>
"     \   denite#do_map('toggle_matchers', 'matcher/regexp')
"     inoremap <silent><buffer><expr> <C-l>
"     \   denite#do_map('toggle_matchers', 'matcher/regexp')
"
"     nnoremap <silent><buffer><expr> <C-i>
"     \   denite#do_map('nop')
" endfunction
"
" augroup MyDeniteSettings
"     autocmd!
"     autocmd FileType denite         call s:denite_my_settings()
"     autocmd FileType denite-filter  call s:denite_filter_my_settigns()
" augroup END
"
"
" " action
" function! s:denite_command_history_edit_cmdlinewin(context) abort
"     let l:ctx = a:context.targets[0]
"     if get(l:ctx, 'source_name', '') !=# 'command_history'
"         return
"     endif
"     " あたかも、ユーザーが入力したかのように動作する
"     let l:command = get(l:ctx, 'action__command', '')
"     call feedkeys('q:' . l:command , 'n')
" endfunction
"
" call denite#custom#action('command/history', 'edit_cmdlinewin',
" \       function('s:denite_command_history_edit_cmdlinewin'))
"
"
" " menu
" let s:denite_menus = {}
"
" " let s:denite_menus.gutter = {
" " \   'description': 'gutter commands',
" " \}
" "
" " " 以下の3つがある
" " " file_candidates       -> kind: file
" " " command_candidates    -> kind: command
" " " directory_candidates  -> kind: directory
"
" " call denite#custom#var('menu', 'menus', s:denite_menus)


" ==============================================================================
" raghur/fruzzy

let g:fruzzy#usenative = 1
let g:fruzzy#sortonempty = 0


" " ==============================================================================
" " prabirshrestha/asyncomplete.vim
" set shortmess+=c
"
" augroup MyAsyncompleteVerdin
"     autocmd!
"     autocmd User asyncomplete_setup call asyncomplete#register_source(
"     \   asyncomplete#sources#Verdin#get_source_options({
"     \      'name': 'Verdin',
"     \      'whitelist': ['vim', 'help'],
"     \      'completor': function('asyncomplete#sources#Verdin#completor'),
"     \}))
" augroup END
"
"
" augroup MyAsyncompleteOmni
"     autocmd!
"     autocmd User asyncomplete_setup call asyncomplete#register_source(
"     \   asyncomplete#sources#omni#get_source_options({
"     \       'name': 'omni',
"     \       'whitelist': ['*'],
"     \       'blacklist': ['help', 'sql'],
"     \       'completor': function('asyncomplete#sources#omni#completor')
"     \   })
"     \)
" augroup END
"
"
" " augroup MyAsyncompleteNeosnippet
" "     autocmd!
" "     autocmd User asyncomplete_setup call asyncomplete#register_source(
" "     \   asyncomplete#sources#neosnippet#get_source_options({
" "     \       'name': 'neosnippet',
" "     \       'whitelist': ['*'],
" "     \       'completor': function('asyncomplete#sources#neosnippet#completor'),
" "     \   })
" "     \)
" " augroup END
"
" " augroup MyAsyncompleteNecosyntax
" "     autocmd!
" "     autocmd User asyncomplete_setup call asyncomplete#register_source(
" "     \   asyncomplete#sources#necosyntax#get_source_options({
" "     \       'name': 'necosyntax',
" "     \       'whitelist': ['python'],
" "     \       'blacklist': ['vim', 'help', 'sql', 'html'],
" "     \       'completor': function('asyncomplete#sources#necosyntax#completor'),
" "     \   })
" "     \)
" " augroup END

