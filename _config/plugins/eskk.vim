scriptencoding utf-8
UsePlugin 'eskk.vim'

if has('vim_starting')
    let g:eskk#dictionary = {'path': '~/.skk-jisyo', 'sorted': 0, 'encoding': 'utf-8'}
    let g:eskk#large_dictionary = {'path': '~/.eskk/SKK-JISYO.L', 'sorted': 1, 'encoding': 'euc-jp'}
endif

" let g:eskk#debug = 1

" let g:eskk#egg_like_newline = 0
let g:eskk#enable_completion = 1
let g:eskk#show_annotation = 1
let g:eskk#rom_input_style = 'msime'
" 変換結果を確定するときに<CR>を押しても改行しないようにする
" let g:eskk#egg_like_newline_completion = 1

let g:eskk#start_completion_length = 1

" デフォルトの設定をしない
let g:eskk#no_default_mappings = 1
imap <C-j> <Plug>(eskk:enable)
cmap <C-j> <Plug>(eskk:enable)

" deoplete.nvim がうまく動かなくなってしまうため、だめ...
" buffer ごとで状態をキープする?
" let g:eskk#keep_state_beyond_buffer = 1
" let g:eskk#keep_state = 1
