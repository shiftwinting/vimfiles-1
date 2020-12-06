scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/youcompleteme.vim'))
    finish
endif

" clangd を使う
let g:ycm_use_clangd = 1

let g:ycm_clangd_binary_path = 'C:\Program Files\LLVM\bin\clangd.exe'

" ycm の設定ファイル
let g:ycm_global_ycm_extra_conf = expand('~\vimfiles\.ycm_extras_conf.py')

" 1文字から開始
let g:ycm_min_num_of_chars_for_completion = 1

let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'vim,cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }


" lsp-sample
source ~/vimfiles/plugged/lsp-examples/vimrc.generated

" list を実行しない
let g:ycm_show_diagnostics_ui = 0
let g:ycm_echo_current_diagnostic = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_enable_diagnostic_signs = 0

" echodoc を使うため
let g:ycm_disable_signature_help = 1

function! s:my_ycm() abort
    " 関数の情報を表示
    nmap ? <plug>(YCMHover)
endfunction

augroup my-ft-a
    autocmd!
    autocmd FileType c,cpp,python call s:my_ycm()
augroup END

" YCMHover
" let g:ycm_auto_hover = 'CursorHold'
let g:ycm_auto_hover = ''

" 自動でポップアップを表示しない
let g:ycm_auto_trigger = 0
