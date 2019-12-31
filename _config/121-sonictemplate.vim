scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/sonictemplate.vim'))
    finish
endif

let g:sonictemplate_vim_template_dir = [
\   expand('~/vimfiles/template'),
\   expand('~/vimfiles/work/template'),
\]

nnoremap <Space>;t :<C-u>Template 
