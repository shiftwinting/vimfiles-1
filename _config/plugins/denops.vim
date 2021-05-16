scriptencoding utf-8
UsePlugin 'denops.vim'

if get(g:, 'my_denops_debug', v:false)
  let g:denops#server#service#deno_args = [
  \ '-q',
  \ '--unstable',
  \ '-A',
  \]
endif
