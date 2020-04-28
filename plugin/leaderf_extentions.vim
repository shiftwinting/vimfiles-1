scriptencoding utf-8

" リストで取得
let s:sfile = expand('<sfile>:p')
function! s:load_extensions() abort
    let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
    for l:ext in glob(fnamemodify(s:sfile, ':h:h') . '/autoload/lf/*.vim', '', v:true)
        let l:category = fnamemodify(l:ext, ':t:r')
        let l:source_type = lf#{l:category}#source_type()
        let g:Lf_Extensions[l:category] = {}

        if l:source_type ==# 'funcref'
            " funcref にしてしまうと、Python 側で None になってしまうため文字列にする
            let g:Lf_Extensions[l:category]['source'] = printf('lf#%s#source', l:category)
        elseif l:source_type ==# 'commnad_funcref'
            let l:source = {'command': funcref(printf('lf#%s#source', l:category))}
            let g:Lf_Extensions[l:category]['source'] = l:source
        else
            let g:Lf_Extensions[l:category]['source'] = []
        endif

        call s:add_func(l:category, 'accept')
        call s:add_func(l:category, 'before_enter')
        call s:add_func(l:category, 'preview')
        call s:add_func(l:category, 'format_list')
        call s:add_func(l:category, 'format_line')
        call s:add_func(l:category, 'get_digest')
        call s:add_by_exec(l:category, 'highlights_def')
        call s:add_by_exec(l:category, 'highlights_cmd')
        call s:add_by_exec(l:category, 'supports_name_only')

    endfor
endfunction

function! s:add_func(category, key) abort
    let l:func = printf('lf#%s#%s', a:category, a:key)
    if exists('*' . l:func)
        " funcref にしてしまうと、Python 側で None になってしまうため文字列にする
        let g:Lf_Extensions[a:category][a:key] = l:func
    endif
endfunction

function! s:add_by_exec(category, key) abort
    let l:func = printf('lf#%s#%s', a:category, a:key)
    if exists('*' . l:func)
        let g:Lf_Extensions[a:category][a:key] = funcref(l:func)()
    endif
endfunction

call s:load_extensions()

command! Tpackadd Leaderf packadd
