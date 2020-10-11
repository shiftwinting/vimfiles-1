scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/molder.vim'))
    finish
endif

function! s:molder_tcd() abort
    execute 'tcd ' .. molder#curdir()
    echo 'cd: ' .. molder#curdir()
endfunction

function! s:molder_tab_open() abort
    execute 'tabe ' .. molder#curdir() .. '/' .. molder#current()
endfunction

function! s:molder_newfile() abort
    let l:name = input('Create file: ')
    if empty(l:name)
        return
    endif
    execute ('e ' .. molder#curdir() .. '/' .. l:name)
call molder#reload()
endfunction

function! s:molder_close() abort
    echomsg 'buffer ' .. getwinvar(winnr(), 'molder_last_bufnr', -1)
    exec 'buffer ' .. getwinvar(winnr(), 'molder_last_bufnr', -1)
endfunction

function! s:my_ft_molder() abort
    nmap          <buffer> l <plug>(molder-open)
    nmap          <buffer> h <plug>(molder-up)
    nmap <silent> <buffer> <nowait> t :<C-u>call <SID>molder_tab_open()<CR>
    nmap <silent> <buffer> <C-k> :<C-u>normal! k<CR>
    nmap <silent> <buffer> <C-j> :<C-u>normal! j<CR>
    nmap          <buffer> ,r <plug>(molder-reload)
    nmap          <buffer> ~ <plug>(molder-home)
    nmap          <buffer> . <plug>(molder-toggle-hidden)

    nmap <silent> <buffer> gn :<C-u>call <SID>molder_newfile()<CR>
    nmap          <buffer> gk <plug>(molder-operations-newdir)
    nmap          <buffer> gd <plug>(molder-operations-delete)
    nmap          <buffer> gr <plug>(molder-operations-rename)
    nmap          <buffer> g! <plug>(molder-operations-command)
    nmap          <buffer> gs <plug>(molder-operations-shell)

    " cd
    nmap          <buffer> cd :<C-u>call <SID>molder_tcd()<CR>

    " close
    nmap <silent> <buffer> q     :<C-u>call <SID>molder_close()<CR>
    nmap <silent> <buffer> <C-e> :<C-u>call <SID>molder_close()<CR>
endfunction

augroup my-ft-molder
    autocmd!
    autocmd FileType molder call s:my_ft_molder()
    " 戻れるようにするため
    autocmd BufLeave * if &filetype !=# 'molder' | let w:molder_last_bufnr = bufnr() | endif
augroup END

nnoremap <C-e> :<C-u>exec 'e ' .. (empty(bufname()) ? '.' : '%:h')<CR>

function! s:molder_start(path) abort
    exec 'new ' .. a:path
endfunction

command! -nargs=? Molder call <SID>molder_start(<f-args>)
