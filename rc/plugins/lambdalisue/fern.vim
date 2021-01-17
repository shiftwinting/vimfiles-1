UsePlugin 'fern.vim'
scriptencoding utf-8

function! s:fern_init() abort
  if !exists('$SSH_CONNECTION')
    let g:fern#renderer = 'nerdfont'
  endif
  " 代替バッファをFern バッファに書き換えない
  let g:fern#keepalt_on_edit = 1
  " jumplist を変更しない
  let g:fern#keepjumps_on_edit = 1
  let g:fern#smart_cursor = 'hide'
  " let g:fern#disable_default_mappings = 1
endfunction

function! s:fern_local_init() abort
  nnoremap <buffer><nowait> ~ :<C-u>Fern ~<CR>
  nmap <buffer> l <Plug>(fern-action-open)
  nmap <buffer> h <Plug>(fern-action-leave)

  nmap <buffer> o <Plug>(fern-action-open-or-expand)
  nmap <buffer> H <Plug>(fern-action-collapse)
  nmap <buffer> I <Plug>(fern-action-hidden-toggle)
  " nmap <buffer> <C-s> <Plug>(fern-action-)
  " nmap <buffer>  <Plug>(fern-action-)
  " nmap <buffer>  <Plug>(fern-action-)
  " nmap <buffer>  <Plug>(fern-action-)
  " nmap <buffer>  <Plug>(fern-action-)
  " nmap <buffer>  <Plug>(fern-action-)
  " nmap <buffer>  <Plug>(fern-action-)
endfunction

augroup vimrc-fern
  autocmd!
  autocmd VimEnter * call s:fern_init()
  autocmd FileType fern call s:fern_local_init()
augroup END
