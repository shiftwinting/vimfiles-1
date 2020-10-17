scriptencoding utf-8

let g:python3_host_prog = $IS_WSL ? 
\   '/usr/bin/python3.8' :
\   $LOCALAPPDATA.'/Programs/Python/Python37/python'
let $NVIM_PYTHON_LOG_FILE = $IS_WSL ?
\   '/tmp/nvim_log' :
\   expand('~/tmp/nvim_log')

let $NVIM_PYTHON_LOG_LEVEL = 'DEBUG'
