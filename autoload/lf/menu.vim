scriptencoding utf-8

let s:menu =[
\   {
\       'name': '!git switch', 
\       'cmd': 'Leaderf switch',
\   },
\   {
\       'name': '!git dirty', 
\       'cmd': 'Leaderf dirty',
\   },
\   {
\       'name': '!git pull', 
\       'cmd': 'Gpull',
\   },
\   {
\       'name': '!git push', 
\       'cmd': 'Gpush',
\   },
\   {
\       'name': 'git new', 
\       'cmd': 'Git switch -c ',
\       'if': '&ft isnot# "GV"',
\   },
\   {
\       'name': 'ghq get', 
\       'cmd': 'GhqGet ',
\   },
\   {
\       'name': '!QfReplace', 
\       'cmd': 'QfReplace',
\   },
\   {
\       'name': '!packadd', 
\       'cmd': 'Tpackadd',
\   },
\   {
\       'name': '!git conflicts', 
\       'cmd': 'Leaderf rg --popup-width=200 --match-path -e "<<<<<<<" -F',
\   },
\   {
\       'name': '!new pull request', 
\       'cmd': '!gh pr create --web',
\   },
\]

" ソースに追加
function! lf#menu#add(source) abort
    call add(s:menu, a:source)
endfunction

" バッファローカルなソースに追加
function! lf#menu#add_buflocal(source) abort
    if !exists('b:lf_menu')
        let b:lf_menu = []
    endif
    call add(b:lf_menu, a:source)
endfunction


function! lf#menu#source_type() abort
    return 'funcref'
endfunction

function! lf#menu#source(args) abort
    let l:menu = s:menu
    " バッファローカルなソースがあれば、足す
    if exists('b:lf_menu')
        let l:menu = s:menu + b:lf_menu
    endif

    " if があれば、評価する
    " なければ、必須
    let l:menu = map(filter(copy(l:menu), 'eval(get(v:val, "if", 1))'), '[v:val.name, v:val.cmd]')

    " ! じゃない場合、先頭に空白を入れる
    for l:item in l:menu
        if l:item[0] !~# '^!'
            let l:item[0] = ' ' . l:item[0]
        endif
    endfor
    return lf#space_between(l:menu)
endfunction

function! lf#menu#accept(line, args) abort
    let l:cmd = trim(split(a:line, '|')[1])
    " 閉じる
    " call feedkeys("\<C-]>")
    if a:line =~# '^!'
        exec l:cmd
    else
        call feedkeys(printf(':%s', l:cmd), 'n')
    endif
endfunction

function! lf#menu#highlights_def() abort
    return {
    \   'Lf_hl_menu_comment': '|\zs .*$',
    \}
endfunction

function! lf#menu#highlights_cmd() abort
    return [
    \   'hi link Lf_hl_menu_comment Comment',
    \]
endfunction
