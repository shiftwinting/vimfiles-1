scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/ctrlp.vim'))
    finish
endif

" mapping
" nnoremap <Space>ff :<C-u>CtrlPCurFile<CR>
" nnoremap <Space>fj :<C-u>CtrlPBuffer<CR>
nnoremap <Space>fq :<C-u>CtrlPGhq<CR>
" nnoremap <Space>fk :<C-u>CtrlPMixed<CR>
" nnoremap <Space>fk :<C-u>CtrlPMRUFiles<CR>
nnoremap <Space>fc :<C-u>CtrlPCdnJs<CR>
" nnoremap <Space>fo :<C-u>CtrlPFunky<CR>

" nnoremap <Space>fl :<C-u>CtrlPLine %<CR>
" nnoremap <Space>fd :<C-u>CtrlPDir resolve(expnad('%:p:h'))<CR>

nnoremap <Space>ml :<C-u>CtrlP ~/memo<CR>

" マッピング
let g:ctrlp_prompt_mappings = {
    \ 'ToggleByFname()':      ['<C-g>'],
    \ 'PrtSelectMove("u")':   ['<A-u>'],
    \ 'PrtSelectMove("d")':   ['<A-d>'],
    \ 'PrtClearCache()':      ['<F5>'],
    \ 'AcceptSelection("e")': ['<Cr>'],
    \ 'AcceptSelection("h")': ['<C-s>', '<C-cr>'],
    \ 'AcceptSelection("t")': ['<C-t>'],
    \ 'AcceptSelection("v")': ['<C-v>'],
    \ 'PrtExpandDir()':       ['<Tab>'],
    \ 'PrtCurStart()':        ['<C-a>'],
    \ 'PrtCurEnd()':          ['<C-e>'],
    \ 'PrtCurLeft()':         ['<C-b>'],
    \ 'PrtCurRight()':        ['<C-f>'],
    \ 'PrtBS()':              ['<C-h>', '<Bs>'],
    \ 'PrtDelete()':          ['<C-d>'],
    \ 'PrtDeleteWord()':      ['<C-w>'],
    \ 'PrtClear()':           ['<C-u>'],
    \ 'PrtSelectMove("j")':   ['<C-j>'],
    \ 'PrtSelectMove("k")':   ['<C-k>'],
    \ 'PrtHistory(-1)':       ['<C-n>'],
    \ 'PrtHistory(1)':        ['<C-p>'],
    \ 'PrtExit()':            ['<Esc>', '<C-c>', '<C-q>'],
    \ 'PrtInsert("c")':       ['<C-o>'],
    \ 'PrtInsert()':          [],
    \ 'ToggleRegex()':        ['<C-r>'],
    \ 'PrtSelectMove("t")':   [],
    \ 'PrtSelectMove("b")':   [],
    \ 'ToggleFocus()':        [],
    \ 'PrtDeleteEnt()':       [],
    \ 'CreateNewFile()':      [],
    \ 'MarkToOpen()':         [],
    \ 'OpenMulti()':          [],
    \ 'ToggleType(1)':        [],
    \ 'ToggleType(-1)':       [],
    \ }

    " \ 'ToggleType(1)':        ['<C-o>'],
    " \ 'ToggleType(-1)':       ['<C-i>'],

    " \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
    " \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
    " \ 'ToggleFocus()':        ['<s-tab>'],
    " \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
    " \ 'PrtInsert()':          ['<c-\>'],
    " \ 'PrtDeleteEnt()':       ['<F7>'],
    " \ 'CreateNewFile()':      ['<c-y>'],
    " \ 'MarkToOpen()':         ['<c-z>'],
    " \ 'OpenMulti()':          ['<c-o>'],

" match window 50件表示(scroll 可能にする)
let g:ctrlp_match_window = 'order:tbb,max:20,results:200'

" ctrlp-ghq 
" <CR> で実行するコマンド
let ctrlp_ghq_default_action = 'tabe | Vaffle'

let g:ctrlp_user_command_async = 1
if executable('rg')
  let g:ctrlp_user_command = 'rg --files -F --color never --hidden --follow --glob "!.git/*" %s'
endif

" 除くディレクトリ
" let g:ctrlp_custom_ignore = '\v[\/](.venv|.git|.mypy_cache|.pytest_cache|.*.egg-info)$'

" 終了時に、キャッシュを削除しない
let g:ctrlp_clear_cache_on_exit = 0

" <C-p> で起動しないようにする
let g:ctrlp_map = ''

" " statusline
" " XXX: prog ってなんだろう
" let g:ctrlp_status_func = {
"     \ 'main': 'CtrlPStatusMain',
"     \ 'prog': 'CtrlPStatusProg',
"     \}
"
" function! CtrlPStatusMain(focus, byfname, regex, prev, item, next, marked) abort
"     let l:byfname = a:byfname ==# 'file' ? 'f' : 'p'
"     let l:regex = a:regex ? 'regex mode' : ''
"
"     return printf(' %s %s %s', l:byfname, a:item, l:regex)
" endfunction
"
" function! CtrlPStatusProg(str) abort
"     return a:str
" endfunction

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

