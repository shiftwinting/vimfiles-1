scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf/Filer.vim'))
    finish
endif

let g:Lf_NormalMap = get(g:, 'Lf_NormalMap', {})
let g:Lf_NormalMap.Filer = [
\   ['<C-E>', ':exec g:Lf_py "filerExplManager.quit()"<CR>'],
\   ['<C-Q>', ':exec g:Lf_py "filerExplManager.quit()"<CR>'],
\   ['i',     ':exec g:Lf_py "filerExplManager.input()"<CR>'],
\]

let g:Lf_FilerShowDevIcons = 1
