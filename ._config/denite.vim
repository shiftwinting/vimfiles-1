scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/denite.vim'))
    finish
endif

" icon表示
let g:webdevicons_enable_denite = 1

" nnoremap <silent> <A-x> :<C-u>Denite command<CR>
" nnoremap <silent> <Space>ft :<C-u>Denite filetype<CR>
" nnoremap <silent> <Space>fq :<C-u>Denite ghq<CR>
" nnoremap <silent> <Space>fk :<C-u>Denite file_mru<CR>
" nnoremap <silent> <Space>fj :<C-u>Denite buffer -default-action=drop<CR>
" nnoremap <silent> <Space>ff :<C-u>Denite file/rec<CR>
" nnoremap <silent> <Space>fh :<C-u>Denite help<CR>
" nnoremap <silent> <Space>fn :<C-u>Denite neosnippet<CR>
" nnoremap <silent> <Space>fs :<C-u>Denite outline<CR>
" nnoremap <silent> <Space>fg :<C-u>exec printf('Denite -winwidth=%d grep', <SID>nice_width(150))<CR>
" nnoremap <silent> <Space>f; :<C-u>Denite command_history<CR>
" nnoremap <silent> <Space>fl :<C-u>Denite line/external<CR>

function! s:nice_width(maxwidth) abort
    return min([&columns - 10, a:maxwidth - 10])
endfunction


augroup My-denite
    autocmd!
    autocmd FileType denite call s:denite_my_settings()

    function! s:denite_my_settings() abort
        nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
        nnoremap <silent><buffer><expr> D       denite#do_map('do_action', 'delete')
        nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> q       denite#do_map('quit')
        nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Tab>   denite#do_map('open_filter_buffer')
        " nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
        nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
    endfunction

    autocmd FileType denite-filter call s:denite_filter_my_settings()
    function! s:denite_filter_my_settings() abort
        inoremap <silent><buffer><expr> <C-j> denite#increment_parent_cursor(1)
        inoremap <silent><buffer><expr> <C-k> denite#increment_parent_cursor(-1)
        nnoremap <silent><buffer><expr> <C-j> denite#increment_parent_cursor(1)
        nnoremap <silent><buffer><expr> <C-k> denite#increment_parent_cursor(-1)
        nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
        nnoremap <silent><buffer><expr> q     denite#do_map('quit')
        nmap     <silent><buffer>       <Tab> <Plug>(denite_filter_quit)
        imap     <silent><buffer>       <C-c> <Plug>(denite_filter_quit)
        imap     <silent><buffer>       <Tab> <Plug>(denite_filter_quit)

        inoremap <silent><buffer><expr> <CR>  denite#do_map('do_action')
        inoremap <silent><buffer><expr> <C-t>  denite#do_map('do_action', 'tabopen')
        nnoremap <silent><buffer><expr> <C-t>  denite#do_map('do_action', 'tabopen')
        inoremap <silent><buffer><expr> <C-s>  denite#do_map('do_action', 'split')
        nnoremap <silent><buffer><expr> <C-s>  denite#do_map('do_action', 'split')
        inoremap <silent><buffer><expr> <C-v>  denite#do_map('do_action', 'vsplit')
        nnoremap <silent><buffer><expr> <C-v>  denite#do_map('do_action', 'vsplit')
    endfunction
augroup END


" ====================
" option
" ====================
" denite-filter の背景色を変更する
call denite#custom#option('default', 'highlight_filter_background', 'CursorLine')
call denite#custom#option('default', 'highlight_matched_char', 'CursorLine')
call denite#custom#option('default', 'prompt', 'CursorLine')
" source の名前を表示する方法
call denite#custom#option('default', 'source_names', 'short')
call denite#custom#option('default', 'split', 'floating')
call denite#custom#option('default', 'filter_split_direciton', 'floating')
call denite#custom#option('default', 'floating_preview', v:true)
" 横にプレビュー表示する
call denite#custom#option('default', 'vertical_preview', v:true)
" filter から開始する
call denite#custom#option('default', 'start_filter', v:true)
call denite#custom#option('default', 'prompt', "> ")

" ====================
" source
" ====================
call denite#custom#source('_', 'matchers', ['matcher/clap'])

" ====================
" var
" ====================
if executable('rg')
    call denite#custom#var('file/rec', 'command',
    \   ['rg', '--files', '--glob', '!.git', '--color', 'never', '--smart-case'])

    call denite#custom#var('grep,line/external', {
    \   'command': ['rg', '--threads', '1'],
    \   'recursive_opts': [],
    \   'final_opts': [],
    \   'separator': ['--'],
    \   'default_opts': ['-i', '--vimgrep', '--no-heading'],
    \})
endif

call denite#custom#var('directory_rec', 'command',
\   ['fd', '--type', 'directory', '--color', 'never', ''])
call denite#custom#var('file/rec', 'command',
\ ['fd', '--follow', '--color', 'never', '--type', 'file', ''])

" ====================
" filter
" ====================
call denite#custom#filter('matcher/clap', 'clap_path', expand('~/.ghq/github.com/liuchengxu/vim-clap'))


" ====================
" action
" ====================
function! s:ghq_open(context) abort
    tabe
    exec 'tcd ' . a:context['targets'][0]['action_path']
endfunction
call denite#custom#action('ghq', 'tabe_tcd', function('s:ghq_open'))


" ====================
" kind
" ====================
call denite#custom#kind('ghq', 'default_action', "tabe_tcd")
