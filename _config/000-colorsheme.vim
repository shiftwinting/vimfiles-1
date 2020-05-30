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

function! s:nord_color() abort

    " from nord
    let s:nord0_gui        = '#2E3440' "  #2E3440
    let s:nord1_gui        = '#3B4252' "  #3B4252
    let s:nord2_gui        = '#434C5E' "  #434C5E
    let s:nord3_gui        = '#4C566A' "  #4C566A
    let s:nord3_gui_bright = '#616E88' "  #616E88
    let s:nord4_gui        = '#D8DEE9' "  #D8DEE9
    let s:nord5_gui        = '#E5E9F0' "  #E5E9F0
    let s:nord6_gui        = '#ECEFF4' "  #ECEFF4
    let s:nord7_gui        = '#8FBCBB' "  #8FBCBB
    let s:nord8_gui        = '#88C0D0' "  #88C0D0
    let s:nord9_gui        = '#81A1C1' "  #81A1C1
    let s:nord10_gui       = '#5E81AC' "  #5E81AC
    let s:nord11_gui       = '#BF616A' "  #BF616A
    let s:nord12_gui       = '#D08770' "  #D08770
    let s:nord13_gui       = '#EBCB8B' "  #EBCB8B
    let s:nord14_gui       = '#A3BE8C' "  #A3BE8C
    let s:nord15_gui       = '#B48EAD' "  #B48EAD

    exec printf('hi Lf_hl_cursorline  guifg=%s guibg=NONE gui=NONE', s:nord5_gui )
    exec printf('hi Lf_hl_match       guifg=%s guibg=NONE gui=bold', s:nord13_gui)
    exec printf('hi Lf_hl_match0      guifg=%s guibg=NONE gui=bold', s:nord13_gui)
    exec printf('hi Lf_hl_match1      guifg=%s guibg=NONE gui=bold', s:nord12_gui)
    exec printf('hi Lf_hl_match2      guifg=%s guibg=NONE gui=bold', s:nord12_gui)
    exec printf('hi Lf_hl_match3      guifg=%s guibg=NONE gui=bold', s:nord11_gui)
    exec printf('hi Lf_hl_match4      guifg=%s guibg=NONE gui=bold', s:nord11_gui)
    exec printf('hi Lf_hl_matchRefine guifg=%s guibg=NONE gui=bold', s:nord15_gui)
    exec printf('hi Lf_hl_rgHighlight guifg=%s guibg=%s   gui=NONE', s:nord0_gui, s:nord13_gui)
    hi link Lf_hl_filerDir Directory

    " exec printf('hi VertSplit guifg=NONE guibg=%s gui=NONE', s:nord1_gui)

    exec printf('hi hlLevel0 guifg=%s', s:nord11_gui)
    exec printf('hi hlLevel1 guifg=%s', s:nord12_gui)
    exec printf('hi hlLevel2 guifg=%s', s:nord13_gui)
    exec printf('hi hlLevel3 guifg=%s', s:nord14_gui)
    exec printf('hi hlLevel4 guifg=%s', 'green1')
    exec printf('hi hlLevel5 guifg=%s', s:nord7_gui)
    exec printf('hi hlLevel6 guifg=%s', 'cyan1')
    exec printf('hi hlLevel7 guifg=%s', s:nord8_gui)
    exec printf('hi hlLevel8 guifg=%s', 'magenta1')
    exec printf('hi hlLevel9 guifg=%s', s:nord15_gui)

endfunction

function! DefineMyHighlishts() abort
    if !exists('g:colors_name') | return | endif

    hi Tab guifg=#999999
    hi Eol guifg=#999999

    if &background == 'light'
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
    else

        if g:colors_name ==# 'nord'
            call s:nord_color()
        endif

    endif

endfunction

augroup MyColorScheme
    autocmd!
    autocmd ColorScheme * call DefineMyHighlishts()
augroup END

" italic なくす
" let g:solarized_italics = 0

" colorscheme solarized8
" set background=dark

" colorscheme one
" set background=light

colorscheme nord
set background=dark

let g:nord_uniform_diff_background = 1
let g:nord_underline = 1
let g:nord_bold_vertical_split_line = 1



" よく間違える文字をハイライト
let s:misspell = [
\   'pritn',
\   'funciton',
\   'fmg',
\   'Prinln',
\]
exe printf('match Error /%s/', join(s:misspell, '\|'))
