scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/vista.vim'))
    finish
endif

let g:vista#renderer#icons = {
    \   'autocommand groups': '',
    \   'cmd': '🐚',
    \   'commands': '🐚',
    \   'implementation': '󿟾',
    \   'maps': '󿞸',
    \   'targets': '󿚶',
    \   'module': '󿮧',
    \   'modules': '󿮧',
    \   'namespace': '󿚞',
    \   'namespaces': '󿚞',
    \   'class': '󿚦',
    \   'classes': '󿚦',
    \   'struct': '󿝡',
    \   'unit': '🗳',
    \   'units': '🗳',
    \   'interface': '',
    \   'interfaces': '',
    \   'function': '󿞔',
    \   'functions': '󿞔',
    \   'method': '',
    \   'methods': '',
    \   'variable': '󿔪',
    \   'variables': '󿔪',
    \   'field': '',
    \   'fields': '',
    \   'property': '💊',
    \   'properties': '💊',
    \   'constant': '󿤂',
    \   'type': '',
    \   'enumerators': '󿚗',
    \   'enums': '󿚗',
    \   'default': '',
    \  }
