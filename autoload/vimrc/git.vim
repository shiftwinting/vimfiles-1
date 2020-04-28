scriptencoding utf-8

let s:Path = vital#vital#import('System.Filepath')

" from gina
function! vimrc#git#get_worktree(path) abort
    let l:path = s:Path.remove_last_separator(a:path)
    let l:dirpath = isdirectory(l:path) ? l:path : fnamemodify(l:path, ':p:h')
    let l:dirpath = simplify(s:Path.abspath(s:Path.realpath(l:dirpath)))

    " ディレクトリを検索
    let l:dgit = finddir('.git', fnameescape(l:dirpath) . ';')
    let l:dgit = empty(dgit) ? '' : fnamemodify(dgit, ':p:h')
    " ファイルを検索
    " let l:fgit = findfile('.git', fnameescape(l:dirpath) . ';')
    " let l:fgit = empty(fgit) ? '' : fnamemodify(fgit, ':p')
    " let l:worktree = len(dgit) > len(fgit) ? dgit : fgit
    let l:worktree = empty(l:dgit) ? '' : fnamemodify(l:dgit, ':h')
    return l:worktree
endfunction

function! vimrc#git#worktree() abort
    return empty(expand('%'))
    \       ? vimrc#git#get_worktree(getcwd())
    \       : vimrc#git#get_worktree(expand('%'))
endfunction
