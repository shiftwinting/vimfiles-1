scriptencoding utf-8

function! s:solarized_color() abort
    hi SignColumn gui=NONE guifg=fg guibg=#eee8d5

    " カーソル行はアンダーラインのみ
    hi CursorLine gui=underline guifg=NONE guibg=NONE

    " ====================
    " LeafCage/yankround.vim
    " ====================
    hi YankRoundRegion guibg=#FFEBCD

    " ====================
    " zah/nim.vim
    " ====================
    hi link nimBuiltin Statement

    " ====================
    " dense-analysis/ale
    " ====================
    hi ALEWarning     gui=undercurl guifg=fg      guibg=#D7FFD7
    hi ALEError       gui=undercurl guifg=fg      guibg=#FFE6FF
    hi ALEWarningSign gui=bold      guifg=#00AD00 guibg=#D7FFD7
    hi ALEErrorSign   gui=bold      guifg=#AF0000 guibg=#FFE6FF

    " ====================
    " airblade/vim-gitgutter
    " ====================
    hi link GitGutterAdd            DiffAdd
    hi link GitGutterChange         DiffAdd
    hi link GitGutterDelte          DiffDelte
    hi link GitGutterChangeDelete   DiffDelte

    " ====================
    " echodoc
    " ====================
    hi link EchodocPopup Pmenu

    " ====================
    " coc.nvim
    " ====================
    hi CocWarningSign gui=bold      guifg=#00AD00 guibg=#D7FFD7
    hi CocErrorSign   gui=bold      guifg=#AF0000 guibg=#FFE6FF

    " ====================
    " python
    " ====================
    hi pythonClassVar               guifg=#6f97a6

    " ====================
    " shot-f
    " ====================
    hi ShotFGraph guifg=#4f84da guibg=NONE gui=bold
    hi ShotFBlank guifg=NONE    guibg=#4f84da gui=bold

    " ====================
    " quickui
    " ====================
    hi link QuickBG Pmenu
    hi link QuickSel PmenuSel
    " hi QuickKey ctermfg=166 guifg=#cb4b16
    " hi QuickDisable ctermfg=242 guifg=#eee8d5
    " hi QuickHelp ctermfg=32 guifg=#268bd2
    " hi QuickBorder ctermfg=235 ctermbg=246 guifg=#073642 guibg=#839496
    " hi QuickTermBorder ctermfg=235 ctermbg=246 guifg=#073642 guibg=#839496
endfunction


function! s:one_color() abort

    hi VertSplit gui=NONE guifg=fg guibg=#e7e9e1

    " ====================
    " LeaderF-filer
    " ====================
    hi link Lf_hl_filerDir Directory

    " ====================
    " GV
    " ====================
    hi DiffAdded   gui=NONE guifg=fg      guibg=#DFFFDF
    hi DiffRemoved gui=NONE guifg=fg      guibg=#FFDFDF
    hi DiffLine    gui=NONE guifg=#4078f2 guibg=bg
    hi DiffNewFile gui=NONE guifg=#50a14f guibg=bg
    hi DiffFile    gui=NONE guifg=#e45649 guibg=bg

    " ====================
    " dense-analysis/ale
    " ====================
    hi ALEWarning     gui=undercurl guifg=fg      guibg=#D7FFD7
    hi ALEError       gui=undercurl guifg=fg      guibg=#FFE6FF
    " hi ALEWarningSign gui=bold      guifg=#00AD00 guibg=#D7FFD7
    " hi ALEErrorSign   gui=bold      guifg=#AF0000 guibg=#FFE6FF
    hi ALEWarningSign gui=bold      guifg=#00AD00 guibg=NONE
    hi ALEErrorSign   gui=bold      guifg=#AF0000 guibg=NONE

endfunction

function! DefineMyHighlishts() abort
    if !exists('g:colors_name') | return | endif

    hi Tab guifg=#999999
    hi Eol guifg=#999999

    " from shirotelin
    hi Todo gui=bold guifg=#005F00 guibg=#afd7af

    " ====================
    " matchup
    " ====================
    hi MatchParen   gui=underline guifg=fg guibg=bg

    " ====================
    " search
    " ====================
    hi IncSearch  gui=NONE guifg=fg guibg=#FFBF80
    hi Search     gui=NONE guifg=fg guibg=#FFFFA0

    " ====================
    " diff
    " ====================
    hi DiffAdd    gui=NONE guifg=fg guibg=#DFFFDF
    hi DiffChange gui=NONE guifg=fg guibg=#DFFFDF
    hi DiffDelete gui=NONE guifg=fg guibg=#FFDFDF
    hi DiffText   gui=NONE guifg=fg guibg=#AAFFAA

    " =============================
    " machakann/vim-highlightedyank
    " =============================
    hi HighlightedyankRegion guibg=bg guifg=#ffd6b0 gui=reverse

    " =============================
    " markdown
    " =============================
    " HTML のリンク
    hi htmlLink gui=underline guifg=#0896d4 guibg=bg
    " エラーの部分を普通にする
    hi link MarkdownError Normal

    " Leaderf
    hi Lf_hl_cursorline guifg=NONE guibg=NONE gui=NONE ctermfg=57 cterm=NONE

    if g:colors_name =~# '^solarized8'
        call s:solarized_color()
    elseif g:colors_name ==# 'one'
        call s:one_color()
    endif

endfunction

augroup MyColorScheme
    autocmd!
    autocmd ColorScheme * call DefineMyHighlishts()
augroup END

" italic なくす
let g:solarized_italics = 0

" colorscheme solarized8
" set background=dark
colorscheme one
set background=light



" よく間違える文字をハイライト
let s:misspell = [
\   'pritn',
\   'funciton'
\]
exe printf('match Error /%s/', join(s:misspell, '\|'))
