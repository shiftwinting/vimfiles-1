scriptencoding utf-8

let g:ale_linters = {
\   'vim': [
\       'vint'
\   ],
\   'nim': [
\       'nimcheck'
\   ],
\   'python': [
\       'flake8', 'mypy'
\   ],
\   'c': [
\       'clang'
\   ]
\}

let g:ale_fixers = {
\   'nim': 'nimpretty',
\   'python': ['isort', 'black'],
\   'c': ['clang-format'],
\}

let g:ale_enabled = 1
" テキスト変更時にlintを実行しない
let g:ale_lint_on_text_changed = 'normal'
" 読み込み時には実行しない
let g:ale_lint_on_enter = 0
" insertモードから抜けたら実行する
let g:ale_lint_on_insert_leave = 1

" let g:ale_sign_error = '>>'
let g:ale_sign_error = ''
" let g:ale_sign_warning = '=='
let g:ale_sign_warning = ''

nmap <silent> <A-j> <Plug>(ale_next_wrap_error)
nmap <silent> <A-k> <Plug>(ale_previous_wrap_error)
" nmap <silent> <A-u> <Plug>(ale_next_wrap_warning)
" nmap <silent> <A-i> <Plug>(ale_previous_wrap_warning)

function! s:nrr_alefix() abort
    if !empty(globpath(&rtp, 'autoload/nrrwrgn.vim'))
        function! s:fix() abort
            NR
            ALEFix
            write
            close
        endfunction
        command! NRALEFix call <SID>fix()
        vnoremap <buffer> <Space>bl NRALEFix
    endif
endfunction

augroup MyALE
    autocmd!
    autocmd FileType python,c nnoremap <buffer> <Space>bl :<C-u>ALEFix<CR>
    autocmd FileType python,c call <SID>nrr_alefix()
    " isort の文字化け対応
    autocmd FileType python let $PYTHONIOENCODING = "utf-8"
augroup END

"
" python
"
" mypyのoption => https://mypy.readthedocs.io/en/latest/command_line.html
let g:ale_python_mypy_options = '--ignore-missing-imports --follow-imports=skip --namespace-packages'

" blackに合わせる
let g:ale_python_flake8_options = '--max-line-length=99'

" Default (E121,E123,E126,E226,E24,E704,W503,W504)
" E101: スペースとタブの両方が使われてますよー(文字列に含まれてるかも)
" E501: １行の長さが超えてしまうのは Black で修正するから、無視してOK
" F403: * やめてねー
" F405: 定義されていないですよー(めんどくさいときとか from a import * ってするから)
" W191: タブが使われてますよー(文字列に含まれてるかも)
" W503: 改行の前に演算子をおいてねー
" E265: # の後ろは ' ' にしてねー
" E203: スライスの : の前はスペース入れないでね
let g:ale_python_flake8_options .= ' '.'--ignore=E121,E123,E126,E226,E24,E704,W503,W504,F405,W191,E101,F403,E501,E265,E203'


"
" clang
"
" https://yasuharu519.hatenablog.com/entry/2015/12/13/210825
function! s:setup_clangformat_options() abort
    let l:clangformat_options = {
    \   'BasedOnStyle': 'llvm',
    \   'IndentWidth': 4,
    \}
    let g:ale_c_clangformat_options = '-style="{'
    let l:first = v:true
    for [key, val] in items(l:clangformat_options)
        let g:ale_c_clangformat_options .= l:first ? '' : ','
        let l:first = v:false
        let g:ale_c_clangformat_options .= printf('%s: %s,', key, val)
    endfor
    let g:ale_c_clangformat_options .= '}" '
endfunction

call s:setup_clangformat_options()
