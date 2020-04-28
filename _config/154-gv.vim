scriptencoding utf-8

if empty(globpath(&rtp, 'plugin/gv.vim'))
    finish
endif

let s:V = vital#vital#new()
let s:Process = s:V.import('System.Process')

function! s:settings() abort
    command!          CherryPick   call <SID>cherrypick()
    command! -nargs=? CreateBranch call <SID>create_branch(<f-args>)

    nnoremap ? :<C-u>Leaderf gv --popup<CR>
endfunction

" ====================
" cherry-pick
" ====================
function! s:cherrypick() abort
    let l:res = s:Process.execute(['git', 'cherry-pick', gv#sha()])
    if l:res.success
        echomsg ' [GV] Success cherry-pick'
        return
    endif

    call vimrc#echoerr(l:res.output)
endfunction


" ====================
" create branch
" ====================
function! s:create_branch(...) abort
    let l:name = 
    \   a:0 == 1
    \       ? a:1
    \       : input(' New [ranch: ', '')
    if empty(l:name)
        call vimrc#echoerr(' [GV] Canceled.')
        return
    endif
    let l:res = s:Process.execute(['git', 'switch', '-c', l:name, gv#sha()])

    if l:res.success
        echomsg ' [GV] Success create branch'
        return
    endif

    call vimrc#echoerr(l:res.output)
endfunction


augroup MyGV
    autocmd!
    autocmd FileType GV call s:settings()
augroup END


nnoremap <Space>gl :<C-u>GV --branches<CR>
vnoremap <Space>gl :GV --branches<CR>
