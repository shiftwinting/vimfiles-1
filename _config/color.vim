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
    if get(g:, 'colors_name', '') =~# 'gruvbox'
      " =============================
      " p00f/nvim-ts-rainbow
      " =============================
      " from ~/.ghq/github.com/sainnhe/gruvbox-material/autoload/gruvbox_material.vim
      " blue
      hi rainbowcol1 guifg=#45707a
      " purple (magenta)
      hi rainbowcol2 guifg=#945e80
      " red
      hi rainbowcol3 guifg=#c14a4a
      " orange
      hi rainbowcol4 guifg=#c35e0a

      let l:colors = {
      \ 'error': '#c14a4a',
      \ 'warn':  '#b47109',
      \ 'info':  '#45707a',
      \ 'hint':  '#4c7a5d',
      \}

      exec 'hi LspDiagnosticsError       guifg='..l:colors.error
      exec 'hi LspDiagnosticsWarning     guifg='..l:colors.warn
      exec 'hi LspDiagnosticsInformation guifg='..l:colors.info
      exec 'hi LspDiagnosticsHint        guifg='..l:colors.hint

      exec 'hi LspDiagnosticsVirtualTextError       guifg='..l:colors.error
      exec 'hi LspDiagnosticsVirtualTextWarning     guifg='..l:colors.warn
      exec 'hi LspDiagnosticsVirtualTextInformation guifg='..l:colors.info
      exec 'hi LspDiagnosticsVirtualTextHint        guifg='..l:colors.hint

      exec 'hi LspDiagnosticsUnderlineError       gui=undercurl guifg='..l:colors.error
      exec 'hi LspDiagnosticsUnderlineWarning     gui=undercurl guifg='..l:colors.warn
      exec 'hi LspDiagnosticsUnderlineInformation gui=undercurl guifg='..l:colors.info
      exec 'hi LspDiagnosticsUnderlineHint        gui=undercurl guifg='..l:colors.hint

      hi GitSignAdd    gui=bold guifg=#6c782e guibg=#ebdbb2
      hi GitSignChange gui=bold guifg=#b47109 guibg=#ebdbb2
      hi GitSignDelete gui=bold guifg=#AF0000 guibg=#ebdbb2

      " hi VertSplit guifg=#d5c4a1 guibg=#ebdbb2

    endif

    hi ScrollView guibg=#a96b2c
  else
    
    hi ScrollView guibg=#ddc7a1

    " green
    hi GitSignAdd    gui=bold guifg=#6c782e guibg=#3c3836
    " yellow
    hi GitSignChange gui=bold guifg=#d8a657 guibg=#3c3836
    " red
    hi GitSignDelete gui=bold guifg=#ea6962 guibg=#3c3836

    " #504945 
    hi LirFloatNormal guibg=#32302f
    hi LirFloatBorder guifg=#7c6f64

    hi TSDefinition guibg=#504945

    " " =============================
    " " p00f/nvim-ts-rainbow
    " " =============================
    " " from ~/.ghq/github.com/sainnhe/gruvbox-material/autoload/gruvbox_material.vim
    " " blue
    " hi rainbowcol1 guifg=#45707a
    " " purple (magenta)
    " hi rainbowcol2 guifg=#945e80
    " " red
    " hi rainbowcol3 guifg=#c14a4a
    " " orange
    " hi rainbowcol4 guifg=#c35e0a

    hi SigHelpParam gui=bold,underline guifg=#d8a657

    hi link LightBulbVirtualText Yellow

    " lspsaga
    hi LspSagaDiagnosticBorder guifg=#d8a657
    hi LspSagaDiagnostcTruncateLine guifg=#d8a657
  endif
  hi TelescopeBorder guifg=#7c6f64
  hi link TelescopePromptBorder TelescopeBorder
  hi link TelescopeResultsBorder TelescopeBorder
  hi link TelescopePreviewBorder TelescopeBorder

endfunction


augroup MyColorScheme
  autocmd!
  autocmd ColorScheme * call s:define_my_highlight()
augroup END

" gruvbox
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_cursor = 'fg0'

" " nord
" let g:nord_uniform_diff_background = 1
" let g:nord_underline = 1
" let g:nord_bold_vertical_split_line = 1

set termguicolors

" set bg=light
set bg=dark
colorscheme gruvbox-material
" colorscheme nautilus
" colorscheme nord
