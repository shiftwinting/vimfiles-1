scriptencoding utf-8

finish

let s:Process = vital#vital#import('System.Process')

" タブで開く
nnoremap <silent> <Space>gs :<C-u>Gstatus<CR>\|:wincmd T<CR>

" Gstatus のウィンドウ内で実行できるマッピング
" > , < diff の表示
" =     diff のの切り替え
" a     add

" J/K  hubk の移動

function! s:fugitive_my_settings() abort
    nnoremap <buffer>           <C-q> <C-w>q :<C-u>GitGutterLineHighlightsDisable<CR>
    nnoremap <buffer>           q     <C-w>q :<C-u>GitGutterLineHighlightsDisable<CR>
    nnoremap <buffer><silent>   ?     :<C-u>help fugitive-maps<CR>
    nnoremap <buffer>           s     <Nop>

    nnoremap <buffer>           P     :<C-u>call <SID>add_p()<CR>
    nnoremap <buffer>           <CR>  :<C-u>call <SID>add_p()<CR>

    setlocal cursorline
endfunction


function! s:add_p() abort
    " カレント行のファイルを開く
    let l:path = FugitiveWorkTree() . '/' . matchstr(getline('.'), '^[A-Z?] \zs.*')
    echomsg s:Process.execute('')

    " タブの右に表示する
    " ウィンドウがない
    "   t:preview_winid: 表示用のウィンドウ
    if !exists('t:preview_winid') || winbufnr(t:preview_winid) == -1
        execute 'vnew ' . l:path
        let t:preview_winid = bufwinid(bufnr())
    else
        call win_execute(t:preview_winid, 'e ' . l:path)
        call win_gotoid(t:preview_winid)
    endif

    ALEDisableBuffer
    GitGutterLineHighlightsEnable

    nnoremap <buffer><silent> q        :<C-u>quit<CR>
    nnoremap <buffer><silent> <Space>q :<C-u>quit<CR>
    nnoremap <buffer>         F        :<C-u>GitGutterFold<CR>
    nnoremap <buffer>         S        <Plug>(GitGutterStageHunk)
    xnoremap <buffer>         S        <Plug>(GitGutterStageHunk)
    nmap     <buffer>         <M-j>    <Plug>(GitGutterNextHunk)
    nmap     <buffer>         <M-k>    <Plug>(GitGutterPrevHunk)

    augroup MyFugitiveAddP
        autocmd!
        autocmd QuitPre  <buffer> call s:QuitPre()
        autocmd WinLeave <buffer> call s:WinLeave()
    augroup END

endfunction


function! s:QuitPre() abort
    let b:quited = v:true
endfunction


function! s:WinLeave() abort
    if !exists('b:quited') || !b:quited
        " :q  を使っていないときは何もしない
        let b:quited = v:false
        return
    endif

    " ハイライトを消す
    GitGutterLineHighlightsDisable

    " ステータスの再取得
    call fugitive#ReloadStatus()
endfunction


augroup MyFugitive
    autocmd!
    autocmd FileType fugitive call s:fugitive_my_settings()
    " autocmd FileType gitcommit call s:fugitive_init_buffer_if_empty()
augroup END
