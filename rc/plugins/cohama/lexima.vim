UsePlugin 'lexima.vim'
scriptencoding utf-8


" https://github.com/yukiycino-dotfiles/dotfiles/blob/b8b12149c85fc7605af98320ae1289a6b8908aa9/.vimrc#L1178-L1328

" <Esc> をマッピングしないようにする
let g:lexima_map_escape = ''
" endwise をしないようにする
let g:lexima_enable_endwise_rules = 0

let s:rules = []

" \%# はカーソル位置


" ====================
" カッコ (Parenthesis)
" ====================
" " ( を2回入力で ) を削除する
" call add(s:rules, { 'char': '(', 'at': '(\%#)', 'input': '<Del>' })
" " (| の場所で ( を入力すると、((|)) となる
" call add(s:rules, { 'char': '(', 'at': '(\%#',  'input': '('     , 'input_after': '))'})

" 閉じ括弧も削除
call add(s:rules, { 'char': '<C-h>', 'at': '(\%#)',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': '(\%#)',  'input': '<BS><Del>' })

" |) の位置でタブを入力すると、)| に移動する
call add(s:rules, { 'char': '<TAB>', 'at': '\%#)',  'input': '<Right>' })

" print(| で ) を入力すると、 print(|) となる
call add(s:rules, { 'char': ')', 'at': '(\%#',  'input': ')<Left>' })



" ====================
" 波カッコ (Brace)
" ====================
" 閉じ括弧も削除
call add(s:rules, { 'char': '<C-h>', 'at': '{\%#}',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': '{\%#}',  'input': '<BS><Del>' })

" |) の位置でタブを入力すると、)| に移動する
call add(s:rules, { 'char': '<TAB>', 'at': '\%#}',  'input': '<Right>' })



" ====================
" 角カッコ (Bracket)
" ====================
" 閉じ括弧も削除
call add(s:rules, { 'char': '<C-h>', 'at': '[\%#]',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': '[\%#]',  'input': '<BS><Del>' })

" |) の位置でタブを入力すると、)| に移動する
call add(s:rules, { 'char': '<TAB>', 'at': '\%#]',  'input': '<Right>' })



" ====================
" シングルクオート (Single Quote)
" ====================
" '' を2回入力で ' を削除する
call add(s:rules, { 'char': "'", 'at': "'\\%#'", 'input': '<Del>' })

" '| の場合、何も入力しない
call add(s:rules, { 'char': "'", 'at': "'\\%#" })

" 閉じクオートも削除
call add(s:rules, { 'char': '<C-h>', 'at': "'\\%#'",  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': "'\\%#'",  'input': '<BS><Del>' })

" |' の位置でタブを入力すると、'| に移動する
call add(s:rules, { 'char': '<TAB>', 'at': "\\%#'",  'input': '<Right>' })



" ====================
" ダブルクオート (Double Quote)
" ====================
" " を2回入力で " を削除する
call add(s:rules, { 'char': '"', 'at': '"\%#"', 'input': '<Del>' })

" "| で " を入力しても、何も入力しない
call add(s:rules, { 'char': '"', 'at': '"\%' })

" 閉じクオートも削除
call add(s:rules, { 'char': '<C-h>', 'at': '"\%#"',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': '"\%#"',  'input': '<BS><Del>' })

" |" の位置でタブを入力すると、"| に移動する
call add(s:rules, { 'char': '<TAB>', 'at': '\%#"',  'input': '<Right>' })



" ====================
" バッククオート (Back Quote)
" ====================
" `|` で ` を入力すると 右の ` を削除する
call add(s:rules, { 'char': '`', 'at': '`\%#`', 'input': '<Del>' })

" `| で ` を入力しても、何も入力しない
call add(s:rules, { 'char': '`', 'at': '`\%' })

" 閉じクオートも削除
call add(s:rules, { 'char': '<C-h>', 'at': '`\%#`',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': '`\%#`',  'input': '<BS><Del>' })

" |" の位置でタブを入力すると、"| に移動する
call add(s:rules, { 'char': '<TAB>', 'at': '\%#`',  'input': '<Right>' })



" ====================
" lua
" ====================
call add(s:rules, { 'filetype': ['lua'], 'char': "'", 'at': 'require\%#',  'input': "''<Left>" })



" ====================
" python
" ====================
call add(s:rules, { 'filetype': ['python'], 'char': "'", 'at': 'f\%#',  'input': "''<Left>" })



for s:rule in s:rules
    call lexima#add_rule(s:rule)
endfor
