scriptencoding utf-8
" UsePlugin 'is.vim'
UsePlugin 'vim-asterisk'
UsePlugin 'vim-search-pulse'

" https://github.com/tsuyoshicho/vimrc-reading/blob/ad6df8bdac68ccbba4c0457797a1f9db56fcdca1/.vim/rc/dein.toml#L723-L847

" asterisk
let g:asterisk#keeppos = 1

" pulse
let g:vim_search_pulse_disable_auto_mappings = 1

" " is
" let g:is#do_default_mappings = 0

" nmap * <Plug>(asterisk-gz*)<Plug>(is-nohl)<Plug>Pulse
" xmap * <Plug>(asterisk-gz*)<Plug>(is-nohl)
" omap * <Plug>(asterisk-gz*)<Plug>(is-nohl)
" nmap g* <Plug>(asterisk-z*)<Plug>(is-nohl)<Plug>Pulse
" xmap g* <Plug>(asterisk-z*)<Plug>(is-nohl)
" omap g* <Plug>(asterisk-z*)<Plug>(is-nohl)

nmap * <Plug>(asterisk-gz*)<Plug>Pulse
xmap * <Plug>(asterisk-gz*)
omap * <Plug>(asterisk-gz*)
nmap g* <Plug>(asterisk-z*)<Plug>Pulse
xmap g* <Plug>(asterisk-z*)
omap g* <Plug>(asterisk-z*)

snoremap * *
snoremap g* g*

" はじめにマッチしたものをパルス
cmap <silent><expr> <CR> search_pulse#PulseFirst()

nmap n n<Plug>Pulse
nmap N N<Plug>Pulse

