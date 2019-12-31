scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/vaffle.vim'))
    finish
endif

function! s:my_vaffle_settings() abort
    nmap <buffer> u         <Plug>(vaffle-open-parent)
    nmap <buffer> h         <Plug>(vaffle-open-parent)
    nmap <buffer> l         <Plug>(vaffle-open-current)
    nmap <buffer> t         <Plug>(vaffle-open-current-tab)
    nmap <buffer> I         <Plug>(vaffle-toggle-hidden)
    nmap <buffer> <CR>      <Plug>(vaffle-open-selected)|
    nmap <buffer> o         <Plug>(vaffle-open-selected)|
    nmap <buffer> m         <Plug>(vaffle-move-selected)
    " nmap <buffer> d         <Plug>(vaffle-delete-selected)
    nmap <buffer> r         <Plug>(vaffle-rename-selected)
    nmap <buffer> R         <Plug>(vaffle-refresh)
    nmap <buffer> <C-s>     <Plug>(vaffle-open-selected-split)
    nmap <buffer> <C-v>     <Plug>(vaffle-open-selected-vsplit)
    nmap <buffer> cd        <Plug>(vaffle-chdir-here)
    nmap <buffer> N         <Plug>(vaffle-new-file)
    nmap <buffer> ~         <Plug>(vaffle-open-home)
    nmap <buffer> q         <Plug>(vaffle-quit)
    nmap <buffer> <C-e>     <Plug>(vaffle-quit)
    nmap <buffer> K         <Plug>(vaffle-mkdir)
endfunction

augroup MyVaffle
    autocmd!
    autocmd FileType vaffle call s:my_vaffle_settings()
augroup END

let g:vaffle_use_default_mappings = 0
let g:vaffle_auto_cd = 1

nnoremap <silent><C-e> :<C-u>Vaffle<CR>
