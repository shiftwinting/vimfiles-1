set encoding=utf-8
scriptencoding utf-8

syntax enable
filetype plugin indent on

set nocompatible

call plug#begin('~/vimfiles/plugged')

" use plugins

call plug#end()

" no backup
set nobackup
set nowritebackup

" no swap
set noswapfile
set updatecount=0

nnoremap <silent> <Space>q :<C-u>quit<CR>
nnoremap <silent> <Space>Q :<C-u>quit!<CR>
