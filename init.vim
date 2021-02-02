scriptencoding utf-8

let g:vimfiles_path = expand('<sfile>:h')
let g:plug_script = expand('<sfile>:h').'/lua/plugins.lua'
let $MYVIMFILES = g:vimfiles_path

" install packer.nvim
let s:pack_path = printf('%s/pack', expand('<sfile>:h'))
function! s:clone_packer_nvim() abort
  let l:packer_path = printf('%s/packer/opt/packer.nvim', s:pack_path)
  if isdirectory(l:packer_path)
    return
  endif
  botright new
  exec printf('terminal git clone https://github.com/wbthomason/packer.nvim %s', l:packer_path)
  nnoremap <buffer> q <Cmd>quit!<CR>
endfunction
call s:clone_packer_nvim()

let g:lua_plugin_config_dir = g:vimfiles_path .. '/lua/plugins'
let g:vim_plugin_config_dir = g:vimfiles_path .. '/_config/plugins'

lua require('init')
runtime! _config/*.vim
