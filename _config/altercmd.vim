scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/altercmd.vim'))
    finish
endif


call altercmd#load()

CAlterCommand lf Leaderf
CAlterCommand brs BrowserSyncStart
CAlterCommand bro BrowserSyncOpen
