scriptencoding utf-8


function! lf#func(func_name) abort
    " function('<SNR>476_sample_func') -> <SNR>476_sample_func
    return string(function(a:func_name))[10:-3]
endfunction


" a:linesは [[str, str], [str, str], ...] のようなリスト
" 例)
"   :echo s:space_between([['mac', 'text1'], ['windows', 'text2']])
" [
" \ 'mac      | text1',
" \ 'windows  | text2',
" ]

function! lf#space_between(line_items) abort
    let l:result = []
    " 1つ目の要素の最大の長さを返す
    let l:max_len = max(map(copy(a:line_items), {_,x -> strdisplaywidth(x[0])}) + [0])
    for l:line_item in a:line_items
        let l:space = l:max_len - strdisplaywidth(l:line_item[0])
        call add(l:result, printf('%s%s | %s', l:line_item[0], repeat(' ', l:space), l:line_item[1]))
    endfor
    return l:result
endfunction

