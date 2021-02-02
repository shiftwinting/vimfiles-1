-- local neorocks = require'plenary.neorocks'
local util = require 'lspconfig/util'
local f = vim.fn
local Path = require 'plenary.path'
local a = vim.api

-- 診断結果の設定
--   LSP の仕様: https://github.com/tennashi/lsp_spec_ja#publishdiagnostics-notification
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- INSERT モードのときは、更新しない
    update_in_insert = false,
    -- 下線を引く
    underline = false,
    virtual_text = false,
    -- virtual_text = {
    --   prefix = '',
    --   spacing = 4
    -- },
  }
)

local on_attach = function(client)
  -- lsp_status.on_attach(client)
  vim.cmd [[nnoremap <buffer><silent> K         <Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]]
  vim.cmd [[nnoremap <buffer><silent> <Space>fl <Cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]]
  vim.cmd [[nnoremap <buffer><silent> gd        <cmd>lua require'lspsaga.provider'.preview_definition()<CR>]]
  vim.cmd [[nnoremap <buffer><silent> <A-k>     <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]]
  vim.cmd [[nnoremap <buffer><silent> <A-j>     <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]]
end

local install_server = function(name)
  a.nvim_command('LspInstallServer ' .. name)
end

local lspconfig = require'lspconfig'

--[[
  lua
  cmd のデフォルト値はないため、:LspInstallInfo で確認する
]]

-- 参考になる
--    https://github.com/7415963987456321/dotfiles/blob/76685865c9ed6d7bb42dda926f21b8cc56201e1e/.config/nvim/lua/init.lua#L71
--    https://github.com/tami5/nvim/blob/664e43360cc47e0db8ef9b497ea0dd9381bfa8cb/fnl/module/nvim_lsp.fnl
if false then
  install_server('sumneko-lua-language-server')
  install_server('vim-language-server')
  install_server('rust-analyzer')
  install_server('pyls-all')
end

lspconfig.sumneko_lua.setup{
  on_attach = on_attach,
  cmd = {
    vim.fn.expand('~/.local/share/vim-lsp-settings/servers/sumneko-lua-language-server/extension/server/bin/Linux/lua-language-server'),
    '-E',
    vim.fn.expand('~/.local/share/vim-lsp-settings/servers/sumneko-lua-language-server/extension/server/main.lua')
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        enable = true,
        globals = {'vim', 'describe', 'it', 'before_earch', 'after_each', 'vimp', '_vimp'},
        disable = {"unused-vararg", "lowercase-global"}
      },
      workspace = {
        -- library = {
        --   [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        --   [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        -- }
        library = {
          [vim.fn.expand("$VIMRUNTIME")] = true,
          [vim.fn.stdpath("config")] = true,
          -- ["/home/tamago324/.cache/nvim/plenary_hererocks/2.1.0-beta3"] = true,
          -- neorocks のライブラリを追加
          -- [neorocks._hererocks_install_location.filename .. '/share/lua/' .. neorocks._lua_version.lua] = true
        }
      }
    }
  }
}

-- -- see https://github.com/tjdevries/nlua.nvim/blob/master/lua/nlua/lsp/nvim.lua
-- require('nlua.lsp.nvim').setup(lspconfig, {
--   on_attach = on_attach,
--   disabled_diagnostics = {"unused-local", "unused-vararg", "lowercase-global"},
--   globals = {"pprint"},
--   library = {
--     -- 再帰的に検索される
--     [vim.fn.stdpath("config")] = true,
--     [vim.fn.expand("$VIMRUNTIME")] = true,
--     -- neorocks のライブラリを追加
--     -- ["/home/tamago324/.cache/nvim/plenary_hererocks/2.1.0-beta3"] = true,
--     [neorocks._hererocks_install_location.filename .. '/share/lua/' .. neorocks._lua_version.lua] = true
--   }
-- })


--- vim
-- https://github.com/iamcco/vim-language-server
-- $ npm install -g vim-language-server
lspconfig.vimls.setup{
  on_attach = on_attach,
}


--- clangd
-- https://clangd.llvm.org/installation.html
-- $ sudo apt-get install clangd-9
-- $ sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100
lspconfig.clangd.setup {
  on_attach = on_attach,
}


-- --[[
--   lsp_ext
-- ]]
-- require'lsp_ext'.set_signature_help_autocmd()


--- rust_analyzer
lspconfig.rust_analyzer.setup{
  on_attach = on_attach,
  root_dir = function(fname)
    local cargo_metadata = vim.fn.system("cargo metadata --format-version 1")
    local cargo_root = nil
    if vim.v.shell_handler == 0 then
      cargo_root = vim.fn.json_decode(cargo_metadata)["workspace_root"]
    end
    return cargo_root or
      -- util.find_git_ancestor(fname) or
      -- util.root_pattern("rust-project.json")(fname)

      -- Cargo.toml があったら、そこを root_dir にする
      util.root_pattern("Cargo.toml")(fname) or
      util.find_git_ancestor(fname) or
      util.root_pattern("rust-project.json")(fname)
  end,
  -- capabilities = vim.tbl_deep_extend('keep', vim.lsp.protocol.make_client_capabilities(), {
  --   textDocument = {
  --     completion = {
  --       completionItem = {
  --         resolveSupport = {
  --           properties = { 'additionalTextEdits' }
  --         }
  --       }
  --     }
  --   }
  -- }),
}

--- pyls
lspconfig.pyls.setup{
  on_attach = on_attach,
}

-- --- efm-langserver
-- -- go get github.com/mattn/efm-langserver
-- require'lspconfig'.efm.setup{}


-- return {
--   lsp_progress_messages = lsp_progress_messages
-- }
