UsePlugin 'lexima.vim'
scriptencoding utf-8


" https://github.com/yukiycino-dotfiles/dotfiles/blob/b8b12149c85fc7605af98320ae1289a6b8908aa9/.vimrc#L1178-L1328

" <Esc> をマッピングしないようにする
let g:lexima_map_escape = ''
" endwise をしないようにする
let g:lexima_enable_endwise_rules = 0

" TODO: オススメらしい？
let g:lexima_accept_pum_with_enter = 0

let s:rules = []


" 設定のリセット
call lexima#set_default_rules()


" \%# はカーソル位置


" ====================
" カッコ (Parenthesis)
" ====================
" 閉じ括弧も削除
call add(s:rules, { 'char': '<C-h>', 'at': '(\%#)',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': '(\%#)',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<C-w>', 'at': '(\%#)',  'input': '<BS><Del>' })


" ====================
" 波カッコ (Brace)
" ====================
" 閉じ括弧も削除
call add(s:rules, { 'char': '<C-h>', 'at': '{\%#}',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': '{\%#}',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<C-w>', 'at': '{\%#}',  'input': '<BS><Del>' })



" ====================
" 角カッコ (Bracket)
" ====================
" 閉じ括弧も削除
call add(s:rules, { 'char': '<C-h>', 'at': '\[\%#\]',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': '\[\%#\]',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<C-w>', 'at': '\[\%#\]',  'input': '<BS><Del>' })



" ====================
" シングルクオート (Single Quote)
" ====================
" 閉じクオートも削除
call add(s:rules, { 'char': '<C-h>', 'at': "'\\%#'",  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': "'\\%#'",  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<C-w>', 'at': "'\\%#'",  'input': '<BS><Del>' })


" ====================
" ダブルクオート (Double Quote)
" ====================
" 閉じクオートも削除
call add(s:rules, { 'char': '<C-h>', 'at': '"\%#"',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': '"\%#"',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<C-w>', 'at': '"\%#"',  'input': '<BS><Del>' })



" ====================
" バッククオート (Back Quote)
" ====================
" 閉じクオートも削除
call add(s:rules, { 'char': '<C-h>', 'at': '`\%#`',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<BS>',  'at': '`\%#`',  'input': '<BS><Del>' })
call add(s:rules, { 'char': '<C-w>', 'at': '`\%#`',  'input': '<BS><Del>' })



" ====================
" lua
" ====================
call add(s:rules, { 'filetype': ['lua'], 'char': "'", 'at': 'require\%#',  'input': "''\<Left>" })
" call add(s:rules, { 'filetype': ['lua'], 'char': ">", 'at': '([^)]*\%#)',  'input': "function ()\nend\<Up>\<End>\<Left>" })


" ====================
" python
" ====================
call add(s:rules, { 'filetype': ['python'], 'char': "'", 'at': 'f\%#',  'input': "''\<Left>" })
call add(s:rules, { 'filetype': ['python'], 'char': "'", 'at': 'r\%#',  'input': "''\<Left>" })


" ====================
" vim
" ====================
call add(s:rules, { 'filetype': ['vim'], 'char': '<', 'at': '^\s*\(autocmd\|.[nore]map\)\s*',  'input': "<>\<Left>" })


" ====================
" telescope
" ====================
" call add(s:rules, { 'filetype': ['TelescopePrompt'], 'char': "'", 'input': "\<Del>" })

" ====================
" rust
" ====================
call add(s:rules, { 'filetype': ['rust'], 'char': "'",                         'input': "''\<Left>"    })
call add(s:rules, { 'filetype': ['rust'], 'char': "'", 'at':    'b\%#',        'input': "''\<Left>" })
call add(s:rules, { 'filetype': ['rust'], 'char': "<", 'at':    'Vec\%#',      'input': "<>\<Left>" })
call add(s:rules, { 'filetype': ['rust'], 'char': "<", 'at':    'struct.*\%#', 'input': "<>\<Left>" })
call add(s:rules, { 'filetype': ['rust'], 'char': "<", 'at':    '::\%#',       'input': "<>\<Left>" })
call add(s:rules, { 'filetype': ['rust'], 'char': "<", 'at':    'Box\%#',      'input': "<>\<Left>" })
call add(s:rules, { 'filetype': ['rust'], 'char': "<", 'at':    'Some\%#',     'input': "<>\<Left>" })



" ====================
" markdown
" ====================
" Thanks https://github.com/yukiycino-dotfiles/dotfiles/blob/1cdadb87170aa5b1f93bd06729442e420b9f13e6/.vimrc#L2049
call add(s:rules, { 'filetype': 'markdown', 'char': '<Space>', 'at': '^\s*\%#',         'input': "*<Space>"         })
call add(s:rules, { 'filetype': 'markdown', 'char': '<Space>', 'at': '^\s*\%#',         'input': "*<Space>"         })
call add(s:rules, { 'filetype': 'markdown', 'char': '<Space>', 'at': '^\s*\*\s\%#',     'input': "<Home><Tab><End>" })
call add(s:rules, { 'filetype': 'markdown', 'char': '<Tab>',   'at': '^\s*\%#',         'input': "*<Space>"         })
call add(s:rules, { 'filetype': 'markdown', 'char': '<Tab>',   'at': '^\s*\*\s\%#',     'input': "<Home><Tab><End>" })
call add(s:rules, { 'filetype': 'markdown', 'char': '<Tab>',   'at': '^\s*\*\s\w.*\%#', 'input': "<Home><Tab><End>" })
call add(s:rules, { 'filetype': 'markdown', 'char': '<S-Tab>', 'at': '^\s\+\s\+\%#',    'input': "<C-d>"            })
call add(s:rules, { 'filetype': 'markdown', 'char': '<S-Tab>', 'at': '^\s\+\*\s\+\%#',  'input': "<C-d>"            })
call add(s:rules, { 'filetype': 'markdown', 'char': '<S-Tab>', 'at': '^\*\s\+\%#',      'input': ""                 })
call add(s:rules, { 'filetype': 'markdown', 'char': '<S-Tab>', 'at': '^\%#',            'input': ""                 })
call add(s:rules, { 'filetype': 'markdown', 'char': '<S-Tab>', 'at': '^\* \%#',         'input': "<C-w>"            })
call add(s:rules, { 'filetype': 'markdown', 'char': '<C-h>',   'at': '^\*\s\%#',        'input': "<C-w>"            })

" なぜか、二回 <CR> が必要
call add(s:rules, { 'filetype': 'markdown', 'char': '<CR>', 'at': '^\*\s\%#',     'input': "<C-u><C-u><CR><CR>" })
call add(s:rules, { 'filetype': 'markdown', 'char': '<CR>', 'at': '^\s\+\*\s\%#', 'input': "<C-u><C-u><CR>"     })

for s:rule in s:rules
    call lexima#add_rule(s:rule)
endfor

augroup my-lexima
    autocmd!
    autocmd FileType TelescopePrompt b:lexima_disabled = 1
augroup END
