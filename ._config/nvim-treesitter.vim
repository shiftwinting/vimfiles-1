scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/nvim_treesitter.vim'))
    finish
endif

lua << EOF

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  }
}

EOF
