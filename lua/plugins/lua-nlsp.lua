if vim.api.nvim_call_function('FindPlugin', {'lua-nlsp'}) == 0 then do return end end

local nlsp = require'nlsp.lspconfig'

local on_attach = function(client_id, bufnr)
  require'xlsp.document_highlight'.setup_autocmds(bufnr)
end

nlsp.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = {
    vim.fn.expand('~/.local/share/vim-lsp-settings/servers/sumneko-lua-language-server/extension/server/bin/Linux/lua-language-server'),
    '-E',
    vim.fn.expand('~/.local/share/vim-lsp-settings/servers/sumneko-lua-language-server/extension/server/main.lua'),
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        enable = true,
        globals = {'vim', 'describe', 'it', 'before_earch', 'after_each', 'vimp', '_vimp'},
        disable = {"unused-local", "unused-vararg", "lowercase-global", "undefined-field"}
      },
      completion = {
        keywordSnippet = "Enable",
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. '/lua'] = true,
        }
      }
    }
  }
}

--- efm
nlsp.efm.setup {
  init_options = { documentFormatting = true },
  cmd = {
    'efm-langserver', '-c', vim.fn['efm_langserver_settings#config_path']()
  },
  -- filetypes = vim.fn['efm_langserver_settings#whitelist'](),
  filetypes = { 'json' },
  settings = {
    rootMarkers = { '.git/' },
  }
}
