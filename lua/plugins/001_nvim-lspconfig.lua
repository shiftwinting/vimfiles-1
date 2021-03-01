if vim.api.nvim_call_function('FindPlugin', {'nvim-lspconfig'}) == 0 then do return end end

-- local neorocks = require'plenary.neorocks'
local util = require 'lspconfig/util'
local a = vim.api

-- 診断結果の設定
--   LSP の仕様: https://github.com/tennashi/lsp_spec_ja#publishdiagnostics-notification
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- INSERT モードのときは、更新しない
    update_in_insert = false,
    -- 下線を引かない
    underline = false,
    virtual_text = false,
    -- virtual_text = {
    --   prefix = '',
    --   spacing = 4
    -- },
  }
)

-- lspsaga
do
  require'lspsaga'.init_lsp_saga {
    border_style = 4,
    code_action_icon = ' 󿯦 '
  }
end


-- lspkind
do
  local has_lspkind, lspkind = pcall(require, 'lspkind')
  if not has_lspkind then
    return
  end
  -- アイコンの画像がある
  -- https://github.com/Microsoft/vscode/issues/2628#issuecomment-297566399
  lspkind.init({
    with_text = true,
    symbol_map = {
      Text        = '',
      Method      = '',
      Function    = '',
      Constructor = '󿚦',
      Variable    = '󿰩',
      Field       = '󿰩',
      Class       = '󿯟',
      Interface   = '󿨡',
      Module      = '󿙨',
      Property    = '󿪶',
      Unit        = '󿴵',
      Value       = '󿰩',
      Enum        = '',
      Keyword     = '󿨅',
      Snippet     = '󿨀',
      Color       = '󿣗',
      File        = '󿢚',
      Folder      = '',
      EnumMember  = '',
      Constant    = '󿡛',
      Struct      = '󿩭',
      Event       = '󿝀',
    },
  })
end


local on_attach = function(client)
  local map = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, { silent = true, noremap = true })
  end

  map( 'n', 'K',         [[<Cmd>lua require'xlsp.lspsaga'.render_or_into_hover_doc()<CR>]])
  -- map( 'n', '<Space>fl', [[<Cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]])
  map( 'n', '<Space>fl', [[<Cmd>lua require'plugins.telescope_nvim'.lsp_references()<CR>]])
  map( 'n', 'gd',        [[<cmd>lua require'lspsaga.provider'.preview_definition()<CR>]])
  map( 'n', '<A-k>',     [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]])
  map( 'n', '<A-j>',     [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]])
  map( 'n', '<Space>fa', [[<cmd>Lspsaga code_action<CR>]])
  -- map( 'i', '<A-s>',     [[<cmd>lua require'xlsp.signature_help'.toggle()<CR>]])
  -- map( 'n', '<A-s>',     [[<cmd>lua require'xlsp.signature_help'.toggle()<CR>]])
  -- map( 'n', '<C-]>',     [[<cmd>lua vim.lsp.buf.definition()<CR>]])
  -- map( 0, 'n', '<A-l>',     [[<Cmd>lua vim.lsp.diagnostics.set_loclist()<CR>]],                      { silent = true, noremap = true })

  vim.cmd [[command! -buffer LspDiagnosticSetLoclist lua vim.lsp.diagnostic.set_loclist()]]
  -- lsp_status.on_attach(client)

  local bufnr = a.nvim_get_current_buf()
  -- signature_help を表示する
  require'xlsp/lspsignicha'.setup_autocmds(bufnr)
  -- require'lspsignicha_ver2'.setup_autocmds(bufnr)

  -- require'xlsp/lightbulb'.on_attach()
end


do
  pcall(require, 'lsp_ext')
end

local lspconfig = require'lspconfig'

-- ログレベルを TRACE に設定
vim.lsp.set_log_level(vim.log.levels.DEBUG)

-- lua
lspconfig.sumneko_lua.setup{
  on_attach = on_attach,
  cmd = {
    vim.fn.expand('~/.local/share/vim-lsp-settings/servers/sumneko-lua-language-server/extension/server/bin/Linux/lua-language-server'),
    '-E',
    vim.fn.expand('~/.local/share/vim-lsp-settings/servers/sumneko-lua-language-server/extension/server/main.lua'),
    -- meta file を指定
    '--metapath=' .. vim.fn['emmylua_annot_nvim_api#get_meta_path']()
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
        library = vim.tbl_extend('force', {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. '/lua'] = true,
          -- vim-plug で管理しているプラグインの /lua を入れる
        }, vim.fn.PlugLuaLibraries(), (function()
          local has_neorocks, neorocks = pcall(require, 'plenary.neorocks')
          if has_neorocks then
            -- neorocks のライブラリを追加
            -- ["/home/tamago324/.cache/nvim/plenary_hererocks/2.1.0-beta3"] = true,
            return {
              [neorocks._hererocks_install_location.filename .. '/share/lua/' .. neorocks._lua_version.lua] = true
            }
          end
        end)())
      }
    }
  }
}


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


--- rust_analyzer
-- update 方法
-- $ curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer

lspconfig.rust_analyzer.setup{
  on_attach = on_attach,
  root_dir = function(fname)
    local cargo_metadata = vim.fn.system("cargo metadata --format-version 1")
    local cargo_root = nil
    if vim.v.shell_handler == 0 then
      cargo_root = vim.fn.json_decode(cargo_metadata)["workspace_root"]
    end
    return cargo_root or
      -- Cargo.toml があったら、そこを root_dir にする
      util.root_pattern("Cargo.toml")(fname) or
      util.find_git_ancestor(fname) or
      util.root_pattern("rust-project.json")(fname)
  end,

  -- https://rust-analyzer.github.io/manual.html#configuration
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFretures = true
      },
      checkOnSave = {
        command = 'clippy'
      }
    }
  }
}

--- pyls
lspconfig.pyls.setup{
  on_attach = on_attach,
}

-- --- efm-langserver
-- -- go get github.com/mattn/efm-langserver
-- require'lspconfig'.efm.setup{}
