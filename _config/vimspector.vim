scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/vimspector.vim'))
    finish
endif

 
" 以下のようなマッピングになる
" let g:vimspector_enable_mappings = 'HUMAN'

" 停止
nmap <F3> <Plug>VimspectorStop
" 開始、続ける
nmap <F5> <Plug>VimspectorContinue
" 再実行
nmap <F3> <Plug>VimspectorRestart
" 一時停止
nmap <F6> <Plug>VimspectorPause

nmap <F7> <Plug>VimspectorStepInto
nmap <F8> <Plug>VimspectorStepOut
nmap <F9> <Plug>VimspectorStepOver

nnoremap <F12>        :<C-u>VimspectorReset<CR>

" 条件付きブレークポイント
" nmap <S-M-b>      <Plug>VimspectorToggleConditionalBreakpoint
" ブレークポイントをトグル
nmap <C-m>        <Plug>VimspectorToggleBreakpoint
" 関数にブレークポイントを置く
" nmap <F8>         <Plug>VimspectorAddFunctionBreakpoint


let g:vimspector_base_dir = expand('~/vimfiles/vimspector_config')

" ====================
" stacktrace window
" ====================
function! s:BufEnterStackTrace() abort
    " ダブルクリックでジャンプ
    nnoremap <buffer> <2-LeftMouse> :call vimspector#GoToFrame()<CR>
endfunction

" ====================
" variables window
" ====================
function! s:BufEnterVariables() abort
    " l でトグル
    nnoremap <buffer> l :call vimspector#ExpandVariable()<CR>
endfunction

" ====================
"  window
" ====================
function! s:BufEnterWatches() abort
    " 削除
    nnoremap <buffer> dd :call vimspector#DeleteWatch()<CR>
    " トグル
    nnoremap <buffer> l  :call vimspector#ExpandVariable()<CR>
endfunction

augroup MyVimspector
    autocmd!
    autocmd User VimspectorUICreated call s:CustomWinBar()
    autocmd BufEnter vimspector.StackTrace call s:BufEnterStackTrace()
    autocmd BufEnter vimspector.Variables call s:BufEnterVariables()
    autocmd BufEnter vimspector.Watches call s:BufEnterWatches()
augroup END

function! s:CustomWinBar()
    call win_gotoid(g:vimspector_session_windows.code)
    aunmenu WinBar
    nnoremenu WinBar.\ F4 :call vimspector#Stop()<CR>
    nnoremenu WinBar.\ F5 :call vimspector#Continue()<CR>
    nnoremenu WinBar.\ F6 :call vimspector#Pause()<CR>
    " nnoremenu WinBar.󿲒\ F8 :call vimspector#StepInto()<CR>
    nnoremenu WinBar.󿚺\ F7 :call vimspector#StepInto()<CR>
    " nnoremenu WinBar.󿲖\ F9 :call vimspector#StepOut()<CR>
    nnoremenu WinBar.󿚻\ F8 :call vimspector#StepOut()<CR>
    nnoremenu WinBar.󿥍\ F9 :call vimspector#StepOver()<CR>
    nnoremenu WinBar.󿥘\ F3 :call vimspector#Restart()<CR>
    nnoremenu WinBar.\ F12 :call vimspector#Reset()<CR>
endfunction


" ブレークポイントの sign
sign define vimspectorBP text= texthl=vimspectorBP
sign define vimspectorBPDisabled text= texthl=vimspectorBP
sign define vimspectorPC text= texthl=vimspectorPC linehl=vimspectorPCBP
sign define vimspectorPCBP text=󿧗 texthl=vimspectorPC linehl=vimspectorPCBP


" ====================
" 複数の変数を追加
" ====================
function! s:add_multi_watch(exprs) abort
    for l:e in a:exprs
        exec 'VimspectorWatch ' . l:e
    endfor
endfunction

command! -nargs=+ VimspectorWatchMulti call s:add_multi_watch(<f-args>)


" ====================
" カーソル下の変数を watch に追加
" ====================
nnoremap <M-w> :<C-u>VimspectorWatch <C-r><C-w><CR>
vnoremap <M-w> :<C-u>execute 'VimspectorWatch ' . vimrc#getwords_last_visual()<CR>


" ====================
" Leaderf でブレークポイントを表示
" TODO: Quickfix じゃなくて、ちゃんとしたのを作る トグルとかできるようにしたい
" ====================
function! s:lf_breakpoint() abort

python3 << EOF
qf = _vimspector_session._breakpoints.BreakpointsAsQuickFix()
vim.eval('setqflist({})'.format(json.dumps(qf)))
EOF
    exec 'Leaderf quickfix'
endfunction

command! LeaderfVimspectorBreakpoints call <SID>lf_breakpoint()
