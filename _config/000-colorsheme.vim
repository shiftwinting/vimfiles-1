scriptencoding utf-8

function! DefineMyHighlishts() abort
    if g:colors_name =~# '^solarized8'
        hi IncSearch  gui=NONE guifg=fg guibg=#FFBF80
        hi Search     gui=NONE guifg=fg guibg=#FFFFA0
        hi SignColumn gui=NONE guifg=fg guibg=#eee8d5

        " カーソル行はアンダーラインのみ
        hi CursorLine gui=underline guifg=NONE guibg=NONE

        " Diff* がめっちゃ重かったし、この色好きだから、いい感じ
        hi DiffAdd    gui=NONE guifg=fg guibg=#DFFFDF
        hi DiffChange gui=NONE guifg=fg guibg=#DFFFDF
        hi DiffDelete gui=NONE guifg=fg guibg=#FFDFDF
        hi DiffText   gui=NONE guifg=fg guibg=#AAFFAA

        " from shirotelin
        hi Todo       gui=bold guifg=#005F00 guibg=#afd7af

        hi Tab guifg=#999999
        hi Eol guifg=#999999

        " HTML のリンク
        hi htmlLink gui=underline guifg=#0896d4 guibg=bg

        " ====================
        " LeafCage/yankround.vim
        hi YankRoundRegion guibg=#FFEBCD

        " ====================
        " machakann/vim-highlightedyank
        hi HighlightedyankRegion guibg=bg guifg=#ffd6b0 gui=reverse

        " ====================
        " zah/nim.vim
        hi link nimBuiltin Statement

        " ====================
        " dense-analysis/ale
        hi ALEWarning     gui=undercurl guifg=fg      guibg=#D7FFD7
        hi ALEError       gui=undercurl guifg=fg      guibg=#FFE6FF
        hi ALEWarningSign gui=bold      guifg=#00AD00 guibg=#D7FFD7
        hi ALEErrorSign   gui=bold      guifg=#AF0000 guibg=#FFE6FF

        " ====================
        " markdown
        hi link MarkdownError Normal

        " ====================
        " airblade/vim-gitgutter
        hi link GitGutterAdd            DiffAdd
        hi link GitGutterChange         DiffAdd
        hi link GitGutterDelte          DiffDelte
        hi link GitGutterChangeDelete   DiffDelte

        " ====================
        " matchup
        " hi MatchParen   gui=bold guifg=fg guibg=#fff0e6
        hi MatchParen   gui=underline guifg=fg guibg=bg

        " ====================
        " echodoc
        " from shirotelin
        hi link EchodocPopup Pmenu

        " ====================
        " coc.nvim
        hi CocWarningSign gui=bold      guifg=#00AD00 guibg=#D7FFD7
        hi CocErrorSign   gui=bold      guifg=#AF0000 guibg=#FFE6FF

        " ====================
        " python
        hi pythonClassVar               guifg=#6f97a6

        " ====================
        " shot-f
        hi ShotFGraph guifg=#4f84da guibg=NONE gui=bold
        hi ShotFBlank guifg=NONE    guibg=#4f84da gui=bold

        " ====================
        " quickui
        hi link QuickBG Pmenu
        hi link QuickSel PmenuSel
        " hi QuickKey ctermfg=166 guifg=#cb4b16
        " hi QuickDisable ctermfg=242 guifg=#eee8d5
        " hi QuickHelp ctermfg=32 guifg=#268bd2
        " hi QuickBorder ctermfg=235 ctermbg=246 guifg=#073642 guibg=#839496
        " hi QuickTermBorder ctermfg=235 ctermbg=246 guifg=#073642 guibg=#839496
    endif

endfunction
augroup MyColorScheme
    autocmd!
    autocmd ColorScheme * call DefineMyHighlishts()
augroup END

" italic なくす
let g:solarized_italics = 0

colorscheme solarized8
set background=light
