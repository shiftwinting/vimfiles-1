UsePlugin 'vim-findroot'
scriptencoding utf-8

let g:findroot_patterns = get(g:, 'findroot_patterns', [])
let g:findroot_patterns += [
\ 'Cargo.toml'
\]
