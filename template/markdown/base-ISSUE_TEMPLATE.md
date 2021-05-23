
- `nvim --version`: systemlist('nvim --version')[0]
- `vim -u DEFAULTS` (version: ) behaves differently?
- Operating system/version:
- Terminal name/version:
- `$TERM`:


**Describe the bug**


**To Reproduce using `nvim -u mini.vim -i NONE`**

```vim
set encoding=utf-8

filetype plugin indent on
if has('vim_starting')
  let s:pluin_manager_dir='~/.config/nvim/.plugged/vim-plug'
  execute 'set runtimepath+=' . s:pluin_manager_dir
endif
call plug#begin('~/.config/nvim/.plugged')
Plug 'kevinhwang91/nvim-bqf'
call plug#end()

set nobackup
set nowritebackup
set noswapfile
set updatecount=0
set backspace=indent,eol,start
language messages en_US.utf8

lua << EOF

require'bqf'.setup{
  preview = {
    win_height = 10
  }
}
EOF
```

Steps to reproduce the behavior:


**Expected behavior**


**Screenshots**



Thank you!
