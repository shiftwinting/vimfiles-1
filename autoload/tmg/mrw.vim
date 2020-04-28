scriptencoding utf-8

let s:Filepath = vital#vital#import('System.Filepath')

let g:vimrc#mrw#cache_path = expand('~/.mrw/cache')
let s:mrw_limit = 3000

" from rbtnn/vim-mrw
function! vimrc#mrw#bufwritepost() abort
    let path = expand('<afile>')
    if filereadable(path)
        let fullpath = s:Filepath.to_slash(path)
        " キャッシュファイルではない場合
        if fullpath != s:mrw_cache_path
            let head = []
            if filereadable(s:mrw_cache_path)
                let head = readfile(s:mrw_cache_path, '', 1)
            endif
            " 空 or 先頭行が今回のファイルではない
            if empty(head) || (fullpath != s:Filepath.to_slash(get(head, 0, '')))
                let xs = [fullpath] + mrw#read_cachefile(fullpath)
                call writefile(xs, s:mrw_cache_path)
            endif
        endif
    endif
endfunction

function! vimrc#mrw#read_cachefile(fullpath) abort
    if filereadable(s:mrw_cache_path)
        return filter(readfile(s:mrw_cache_path, '', s:mrw_limit), { i,x ->
            \ (a:fullpath != x) && filereadable(x)
            \ })
    else
        return []
    endif
endfunction
