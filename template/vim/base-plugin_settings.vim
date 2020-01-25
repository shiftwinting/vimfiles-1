scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/{{_expr_:expand("%:t:r")[4:]}}.vim'))
    finish
endif

{{_cursor_}}
