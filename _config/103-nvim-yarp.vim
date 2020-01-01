scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/yarp.vim'))
    finish
endif

let g:python3_host_prog = $LOCALAPPDATA.'/Programs/Python/Python37/python'
let $NVIM_PYTHON_LOG_FILE = expand('~/tmp/nvim_log')
let $NVIM_PYTHON_LOG_LEVEL = 'DEBUG'
