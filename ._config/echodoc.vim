scriptencoding utf-8

let g:echodoc#enable_at_startup = 1
if has('nvim')
    let g:echodoc#type = 'virtual'
else
    let g:echodoc#type = 'popup'
endif
