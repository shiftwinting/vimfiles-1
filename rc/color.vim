scriptencoding utf-8


function! s:define_my_highlight() abort
    if !exists('g:colors_name') | return | endif

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

        " hi EftChar      guifg=red gui=bold
    endif

endfunction


augroup MyColorScheme
    autocmd!
    autocmd ColorScheme * call s:define_my_highlight()
augroup END


let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_background = 'medium'

set bg=light
colorscheme gruvbox-material
