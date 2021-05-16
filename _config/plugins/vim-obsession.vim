
UsePlugin 'vim-obsession'

let s:obsession_dir = stdpath('config') .. '/obsession'

if !isdirectory(s:obsession_dir)
  call mkdir(s:obsession_dir, 'p')
endif

function! s:save_session(name) abort
  execute printf('Obsession %s/%s', s:obsession_dir, a:name)
endfunction

function! s:load_session(name) abort
  execute printf('source %s/%s', s:obsession_dir, a:name)
endfunction

function! s:complete_session_names(ArgLead, CmdLine, CursorPos) abort
  let l:files = map(split(glob(s:obsession_dir .. '/*'), '\n'), 'fnamemodify(v:val, ":t")')
  return join(l:files, "\n")
endfunction

command! -nargs=1 SaveSession call s:save_session(<f-args>)
command! -nargs=1 -complete=custom,s:complete_session_names LoadSession call s:load_session(<f-args>)
