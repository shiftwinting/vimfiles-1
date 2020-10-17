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

    " LeaderF
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
    exec printf('hi Lf_hl_rgLineNumber         guifg=%s guibg=%s  gui=NONE', s:nord14_gui, 'NONE')
    exec printf('hi Lf_hl_rgColumnNumber       guifg=%s guibg=%s  gui=NONE', s:nord14_gui, 'NONE')
    exec printf('hi Lf_hl_quickfixLineNumber   guifg=%s guibg=%s  gui=NONE', s:nord14_gui, 'NONE')
    exec printf('hi Lf_hl_quickfixColumnNumber guifg=%s guibg=%s  gui=NONE', s:nord14_gui, 'NONE')
    exec printf('hi Lf_hl_loclistLineNumber    guifg=%s guibg=%s  gui=NONE', s:nord14_gui, 'NONE')
    exec printf('hi Lf_hl_loclistColumnNumber  guifg=%s guibg=%s  gui=NONE', s:nord14_gui, 'NONE')

    " slimv
    " exec printf('hi hlLevel0 guifg=%s', s:nord11_gui)
    " exec printf('hi hlLevel1 guifg=%s', s:nord12_gui)
    " exec printf('hi hlLevel2 guifg=%s', s:nord13_gui)
    " exec printf('hi hlLevel3 guifg=%s', s:nord14_gui)
    " exec printf('hi hlLevel4 guifg=%s', 'green1')
    " exec printf('hi hlLevel5 guifg=%s', s:nord7_gui)
    " exec printf('hi hlLevel6 guifg=%s', 'cyan1')
    " exec printf('hi hlLevel7 guifg=%s', s:nord8_gui)
    " exec printf('hi hlLevel8 guifg=%s', 'magenta1')
    " exec printf('hi hlLevel9 guifg=%s', s:nord15_gui)

    " shot-f
    exec printf('hi ShotFGraph guifg=%s guibg=%s gui=bold', s:nord12_gui, 'NONE')
    exec printf('hi ShotFBlank guifg=%s guibg=%s gui=bold', 'NONE', s:nord12_gui)
    " highlight link ShotFCursor Cursor

    hi link r7rsSyntaxA PreProc

    hi vimspectorBP         guifg=#A3BE8C guibg=#3B4252
    hi vimspectorBPDisabled guifg=#81A1C1 guibg=#3B4252
    hi vimspectorPC         guifg=#EBCB8B guibg=#3B4252

endfunction

function! s:palenight_color() abort
    " green は nord から
    let g:palenight_color_overrides = {}
    let g:palenight_color_overrides.green = {'gui': '#A3BE8C'}

    hi pythonClassVar guifg=#88C0D0
    hi link pythonDecorator Function
    hi Boolean guifg=#D08770

    hi VertSplit gui=NONE guifg=fg guibg=#2E3440

    " " " davidhalter/jedi-vim
    " hi jediFunction guifg=#bfc7d5 guibg=#474b59
    " hi jediFat      guifg=#82b1ff guibg=#474b59 gui=bold,underline

    hi Todo gui=bold guifg=#005F00 guibg=#A3BE8C

    hi vimspectorBP         guifg=#A3BE8C guibg=#3B4252
    hi vimspectorBPDisabled guifg=#81A1C1 guibg=#3B4252
    hi vimspectorPC         guifg=#EBCB8B guibg=#3B4252
    hi vimspectorPCBP       guifg=#EBCB8B guibg=#3B4252

endfunction

function! DefineMyHighlishts() abort
    if !exists('g:colors_name') | return | endif

    hi Tab guifg=#999999
    hi Eol guifg=#999999

    hi link smlType smlLCIdentifier

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
        hi! link DiffAdded   DiffAdd
        hi! link DiffRemoved DiffDelete

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

        if g:colors_name ==# 'palenight'
            call s:palenight_color()
        endif

    endif

    hi EftChar      guifg=red gui=bold

endfunction

augroup MyColorScheme
    autocmd!
    autocmd ColorScheme * call DefineMyHighlishts()
augroup END

" italic なくす
" let g:solarized_italics = 0

" set background=dark
" colorscheme solarized8

" colorscheme one
" set background=light

" colorscheme nord
" set background=dark

let g:nord_uniform_diff_background = 1
let g:nord_underline = 1
let g:nord_bold_vertical_split_line = 1


" colorscheme palenight
" set background=dark

" set background=dark
" let g:ayucolor = "mirage"
" colorscheme ayu

" set background=dark
" colorscheme tender

" set background=light
"
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
"
" " let g:gruvbox_material_background = 'medium'
" let g:gruvbox_material_background = 'hard'
" " let g:gruvbox_material_background = 'soft'
"
" colorscheme gruvbox-material

set background=light
" colorscheme monochromenote
colorscheme gruvbox-material


hi link vimEmbedError Normal
