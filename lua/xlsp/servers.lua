local util = require 'lspconfig.util'

local M = {}

local expand = vim.fn.expand

local server_dir = expand('~/.local/share/vim-lsp-settings/servers')

local server_cmd_list = {
  gopls = {
    server_dir .. "/gopls/gopls"
  },
  jsonls = {
    server_dir .. '/json-languageserver/json-languageserver', '--stdio'
  },
  sumneko_lua = {
    server_dir .. '/sumneko-lua-language-server/sumneko-lua-language-server'
  },
  vimls = {
    server_dir .. '/vim-language-server/vim-language-server', '--stdio'
  },
  pyls = {
    server_dir .. '/pyls-all/pyls-all'
  },
  bashls = {
    server_dir .. '/bash-language-server/bash-language-server', 'start'
  },
  angularls = (function()
    -- see: [neovim/lspconfig]   https://github.com/neovim/nvim-lspconfig/issues/537#issuecomment-754955762
    -- see: [emacs-lsp]/lsp-mode https://github.com/emacs-lsp/lsp-mode/blob/master/clients/lsp-angular.el
    -- local prefix = vim.trim(vim.fn.system('npm config get --global prefix'))
    local prefix = '/usr'
    local node_module_path = prefix .. '/lib/node_modules'

    return {
      server_dir .. '/angular-language-server/angular-language-server',
      '--stdio',
      '--tsProbeLocations', node_module_path,
      '--ngProbeLocations', node_module_path
    };
  end)(),
  cssls = {
    server_dir .. '/css-languageserver/css-languageserver', '--stdio'
  },
  html = {
    server_dir .. '/html-languageserver/html-languageserver', '--stdio'
  },
  yamlls = {
    server_dir .. '/yaml-language-server/yaml-language-server', '--stdio'
  },
  jedi_language_server = {
    server_dir .. '/jedi-language-server/jedi-language-server'
  },
  pyright = {
    server_dir .. '/pyright-langserver/pyright-langserver', '--stdio'
  }
}

M.get_cmd = function(langserver_name)
  local cmd = server_cmd_list[langserver_name]
  if cmd == nil then
    vim.api.nvim_echo({{string.format('Not found server "%s"', langserver_name), 'ErrorMsg'}}, true, {})
    return {}
  end
  if type(cmd) == 'function' then
    return cmd()
  end
  return cmd
end

return M
