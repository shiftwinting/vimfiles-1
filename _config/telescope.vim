scriptencoding utf-8

if empty(globpath(&rtp, 'plugin/telescope.vim'))
    finish
endif

lua << EOF


EOF

" see https://github.com/nvim-lua/telescope.nvim#api
nnoremap <A-x> :<C-u>lua require'telescope.builtin'.command{}<CR>
nnoremap <Space>fv :<C-u>exec printf("lua require'telescope.builtin'.find_files{ cwd = '%s'}", g:vimfiles_path)<CR>
