scriptencoding utf-8

UsePlugin 'defx.nvim'

" nnoremap <silent> <C-e> :<C-u>Defx -listed -resume
" \   -buffer-name=`'defx' . tabpagenr()`
" \   -search=`expand('%:p')`
" \   `expand('%:p:h')`
" \   <CR>

call defx#custom#column('icon', {
\   'directory_icon': '▸',
\   'opened_icon': '▾',
\   'root_icon': ' ',
\})

call defx#custom#option('_', {
\   'columns': 'mark:indent:icons:filename',
\})

let g:defx_icons_column_length = 1

function! s:my_ft_defx() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>    defx#do_action('drop')
    nnoremap <silent><buffer><expr> o       defx#do_action('drop')
    nnoremap <silent><buffer><expr> C       defx#do_action('copy')
    " nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
    " nnoremap <silent><buffer><expr> & defx#do_action('execute_command', ['', 'async'])
    nnoremap <silent><buffer><expr> M       defx#do_action('move')
    nnoremap <silent><buffer><expr> P       defx#do_action('paste')
    nnoremap <silent><buffer><expr> l       defx#do_action('open')
    nnoremap <silent><buffer><expr> <C-v>   defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> <C-s>   defx#do_action('open', 'split')
    nnoremap <silent><buffer><expr> <C-t>   defx#do_action('open', 'tabedit')
    nnoremap <silent><buffer><expr> P       defx#do_action('preview')
    nnoremap <silent><buffer><expr> o       defx#do_action('open_tree', ['nested', 'toggle'])
    nnoremap <silent><buffer><expr> O       defx#do_action('open_tree', 'recursive')
    nnoremap <silent><buffer><expr> K       defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N       defx#do_action('new_file')
    " nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
    " nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'mark:filename:type:size:time')
    " nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'Time')
    " nnoremap <silent><buffer><expr> se defx#do_action('add_session')
    " nnoremap <silent><buffer><expr> sl defx#do_action('load_session')
    nnoremap <silent><buffer><expr> D       defx#do_action('remove_trash')
    nnoremap <silent><buffer><expr> R       defx#do_action('rename')
    " nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> .       defx#do_action('toggle_ignored_files')
    " nnoremap <silent><buffer><expr> <       defx#do_action('change_ignored_files')
    " nnoremap <silent><buffer><expr> .       defx#do_action('repeat')
    nnoremap <silent><buffer><expr> yy      defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> h       defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> @       defx#do_action('change_vim_cwd')
    nnoremap <silent><buffer><expr> cd      defx#do_action('cd', getcwd())
    nnoremap <silent><buffer><expr> q       defx#do_action('quit')
    nnoremap <silent><buffer><expr> <C-e>   defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> <C-a>   defx#do_action('toggle_select_all')
    " nnoremap <silent><buffer><expr> j       line('.') == line('$') ? 'gg' : 'j'
    " nnoremap <silent><buffer><expr> k       line('.') == 1 ? 'G' : 'k'
    " nnoremap <silent><buffer><expr> <C-l>   defx#do_action('redraw')
    " xnoremap <silent><buffer><expr> <CR>    defx#do_action('toggle_select_visual')
    nnoremap <silent><buffer><expr> <C-g>   defx#do_action('print')
    " nnoremap <silent><buffer><expr> <Tab>   winnr('$') != 1 ?
    " \ ':<C-u>wincmd w<CR>' :
    " \ ':<C-u>Defx -buffer-name=temp -split=vertical<CR>'

    " nnoremap <silent><buffer> <Tab> :<C-u>Fin<CR>
    " nnoremap <silent><buffer> i     :<C-u>Fin<CR>
endfunction

augroup my-ft-defx
    autocmd!
    autocmd FileType defx call s:my_ft_defx()
augroup END
