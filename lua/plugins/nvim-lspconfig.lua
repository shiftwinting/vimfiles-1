if vim.api.nvim_call_function('FindPlugin', {'nvim-lspconfig'}) == 0 then do return end end

-- local neorocks = require'plenary.neorocks'
local util = require 'lspconfig/util'
local a = vim.api

local nlspsettings = require'nlspsettings'
nlspsettings.setup({
  -- config_home = vim.fn.stdpath('config') .. '/nslp'
})

-- 診断結果の設定
--   LSP の仕様: https://github.com/tennashi/lsp_spec_ja#publishdiagnostics-notification
--- lua の設定はここに書いてある https://github.com/sumneko/lua-language-server/blob/9bde1d4431a466e894a81b533a3a037b9e574305/script/config.lua#L115-L191
--- /home/tamago324/ghq/github.com/sumneko/lua-language-server/script/config.lua
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
  local has_lspsaga, lspsaga = pcall(require, 'lspsaga')
  if has_lspsaga then
    lspsaga.init_lsp_saga {
      border_style = 'plus',
      code_action_icon = '󿯦',
      code_action_prompt = {
        enable = false
      }
    }

    vim.cmd( [[augroup my_lspsaga]])
    vim.cmd( [[  autocmd!]])
    vim.cmd( [[  autocmd FileType sagahover nnoremap <buffer> K <Cmd>wincmd p<CR>]])
    vim.cmd( [[augroup END]])
  end
end


-- lspkind
do
  local has_lspkind, lspkind = pcall(require, 'lspkind')
  if has_lspkind then
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
end

do
  local has_symbols, symbols = pcall(require, 'symbols-outline/symbols')
  if has_symbols then
    symbols = {
      File = {icon = "󿢚", hl = "TSURI"},
      Module = {icon = "󿙨", hl = "TSNamespace"},
      Namespace = {icon = "", hl = "TSNamespace"},
      Package = {icon = "", hl = "TSNamespace"},
      Class = {icon = "󿯟", hl = "TSType"},
      Method = {icon = "", hl = "TSMethod"},
      Property = {icon = "󿪶", hl = "TSMethod"},
      Field = {icon = "󿰩", hl = "TSField"},
      Constructor = {icon = "󿚦", hl = "TSConstructor"},
      Enum = {icon = "", hl = "TSType"},
      Interface = {icon = "󿨡", hl = "TSType"},
      Function = {icon = "", hl = "TSFunction"},
      Variable = {icon = "󿰩", hl = "TSConstant"},
      Constant = {icon = "󿡛", hl = "TSConstant"},
      String = {icon = "𝓐", hl = "TSString"},
      Number = {icon = "#", hl = "TSNumber"},
      Boolean = {icon = "⊨", hl = "TSBoolean"},
      Array = {icon = "", hl = "TSConstant"},
      Object = {icon = "⦿", hl = "TSType"},
      Key = {icon = "🔐", hl = "TSType"},
      Null = {icon = "NULL", hl = "TSType"},
      EnumMember = {icon = "", hl = "TSField"},
      Struct = {icon = "󿩭", hl = "TSType"},
      Event = {icon = "󿝀", hl = "TSType"},
      Operator = {icon = "+", hl = "TSOperator"},
      TypeParameter = {icon = "𝙏", hl = "TSParameter"},
    }
  end
end


function on_attach(client)
  local map = function(mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, { silent = true, noremap = true }))
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
  if client.resolved_capabilities.signature_help and client.name ~= 'zls' then
    if vim.tbl_contains({'lua'}, vim.bo.filetype) then
      require'xlsp/lspsignicha'.setup_autocmds(bufnr)
    end
  -- if false then
  end

  if client.resolved_capabilities.document_highlight then
    require'xlsp/document_highlight'.setup_autocmds(bufnr)
  end

  if client.resolved_capabilities.document_formatting then
    map('n', '<Space>rf', '<Cmd>lua vim.lsp.buf.formatting({})<CR>')

  elseif client.resolved_capabilities.document_range_formatting then
    vim.cmd [[command! -buffer LspFormat lua require'xlsp/document_range_formatting'.format()]]
    map('n', '<Space>rf', '<Cmd>LspFormat<CR>')
  end

  -- require'lspsignicha_ver2'.setup_autocmds(bufnr)

  map( 'n', '<Space>vl', '<Plug>(nlsp-buf-config)', { noremap = false })

  map("n", "<A-d>", "<cmd>lua require'vim.lsp.diagnostic'.set_loclist()<cr>")

  -- require'xlsp/lightbulb'.on_attach()
end


do
  pcall(require, 'lsp_ext')
end

local servers = require'xlsp.servers'

local lspconfig = require'lspconfig'


local global_capabilities = vim.lsp.protocol.make_client_capabilities()
global_capabilities.textDocument.completion.completionItem.snippetSupport = true
global_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  { capabilities = global_capabilities }
)

-- ログレベルを TRACE に設定
vim.lsp.set_log_level(vim.log.levels.DEBUG)

-- lua
-- local annotations_path = vim.fn.expand('$HOME') .. '/tmpdir/nvim-lua-annotations.lua'
-- if vim.fn.filereadable(annotations_path) == 0 then
--   require'nvim-lua-annotations'.write_to_file(annotations_path)
-- end

do
  -- -- https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8
  -- local library = {}
  -- local path = vim.split(package.path, ';')
  --
  -- table.insert(path, 'lua/?.lua')
  -- table.insert(path, 'lua/?/init.lua')
  --
  -- local function add(lib)
  --   for _, p in ipairs(vim.fn.expand(lib, false, true)) do
  --     p = vim.loop.fs_realpath(p)
  --     library[p] = true
  --   end
  -- end
  --
  -- add('$VIMRUNTIME')
  -- add(vim.fn.stdpath('config'))

  lspconfig.sumneko_lua.setup{
    on_attach = on_attach,
    cmd = servers.get_cmd('sumneko_lua'),

    settings = {
      Lua = {
        -- runtime = {
        --   path = path
        -- },
        workspace = {
          -- library = library,
          library = vim.tbl_extend('force', {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. '/lua'] = true,
          -- vim-plug で管理しているプラグインの /lua を入れる
          }, vim.fn.PlugLuaLibraries())
        }
      }
    },
  }

end

--- vim
-- https://github.com/iamcco/vim-language-server
-- $ npm install -g vim-language-server
lspconfig.vimls.setup{
  on_attach = on_attach,
  cmd = servers.get_cmd('vimls'),
}


--- clangd
-- https://clangd.llvm.org/installation.html
-- $ sudo apt-get install clangd-9
-- $ sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100

-- $ yay -S libz3.so
lspconfig.clangd.setup {
  on_attach = on_attach,
  cmd = servers.get_cmd('clangd'),
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

}


--- pyright-langserver
lspconfig.pyright.setup{
  on_attach = on_attach,
  cmd = servers.get_cmd('pyright'),
}

-- --- efm
-- -- 設定の例 : https://github.com/search?q=lspconfig+efm+language%3ALua&type=Code&ref=advsearch&l=&l=
-- lspconfig.efm.setup {
--   -- init_options = { documentFormatting = true },
--   cmd = servers.get_cmd('efm'),
--   -- filetypes = vim.fn['efm_langserver_settings#whitelist'](),
--   filetypes = { 'zig', 'ruby' },
--   settings = {
--     rootMarkers = { '.git/', 'Gemfile', 'Rakefile', '.rubocop.yml'  },
--     languages = {
--       -- zig = {
--       --   formatCommand = 'zig fmt --stdin',
--       --   formatStdin = true,
--       -- },
--       -- https://github.com/LkeMitchll/Dotfiles/blob/3001570a22301a99138677a66442e38b19d5db18/config/nvim/lua/lsp.lua#L56
--       ruby = {
--         lintCommand = 'rubocop --format emacs --force-exclusion --stdin ${INPUT}',
--         lintIgnoreExitCode = true,
--         lintStdin = true,
--         -- lintFormats = {'%f:%l:%c: %m'},
--         -- rootMarkers = { 'Gemfile', 'Rakefile', '.rubocop.yml' }
--       }
--     }
--   },
--   -- commands = {
--   --   Format = {
--   --     function()
--   --       vim.lsp.buf.formatting_sync({})
--   --     end
--   --   }
--   -- }
-- }

-- vim.cmd [[augroup my-efm-langserver]]
-- vim.cmd [[  autocmd!]]
-- vim.cmd [[  autocmd BufWritePre *.zig lua vim.lsp.buf.formatting_sync({}, 1000)]]
-- vim.cmd [[augroup END]]

---------
-- jsonls
---------
-- https://github.com/ekadas/Devenv/blob/ba55bd221e9e0d37c8f70e0f752fcfee146e7d64/tools/nvim/lua/lsp.lua#L83-L99
-- https://github.com/JoosepAlviste/dotfiles/blob/65b325e7804831ad014942b78e943022f43a2456/config/nvim/lua/j/plugins/lsp.lua#L158-L170
local jsonls_schemas = {
  {
    fileMatch = {"dockerls.json"},
    url = "file:///home/tamago324/ghq/github.com/tamago324/nlsp-settings.nvim/schemas/dockerls.json"
  },
  {
    fileMatch = {"zls.json"},
    url = "file:///home/tamago324/ghq/github.com/tamago324/vimfiles/data/zls_schema.json",
  }
}
for _, v in ipairs(vim.deepcopy(require'nlspsettings.jsonls'.get_default_schemas())) do
  table.insert(jsonls_schemas, v)
end


lspconfig.jsonls.setup {
  on_attach = on_attach,
  cmd = servers.get_cmd('jsonls'),
  settings = {
    json = {
      schemas = jsonls_schemas
    }
  },
  -- -- Format というコマンドを定義する
  -- commands = {
  --   Format = {
  --     function()
  --       vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
  --     end
  --   }
  -- }
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  cmd = servers.get_cmd('bashls'),
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  cmd = servers.get_cmd('gopls'),
}

-- lspconfig.angularls.setup{
--   on_attach = on_attach,
--   cmd = servers.get_cmd('angularls'),
--
--   -- see https://github.com/neovim/nvim-lspconfig/issues/537#issuecomment-754955762
--   -- angularls のサーバー側で、cmd を更新してしまうため、設定し直すための関数
--   on_new_config = function(new_config, new_root_dir)
--     new_config.cmd = servers.get_cmd('angularls')
--   end
-- }

lspconfig.cssls.setup{
  on_attach = on_attach,
  cmd = servers.get_cmd('cssls'),
}

lspconfig.html.setup{
  on_attach = on_attach,
  cmd = servers.get_cmd('html'),
}


lspconfig.yamlls.setup{
  on_attach = on_attach,
  cmd = servers.get_cmd('yamlls'),
}

lspconfig.zls.setup{
  on_attach = on_attach,
  cmd = { vim.fn.expand('$HOME/.cache/zls/zls') },
}


lspconfig.vuels.setup{
  on_attach = on_attach,
  cmd = servers.get_cmd('vuels'),
}

lspconfig.denols.setup {
  on_attach = on_attach,
}

lspconfig.solargraph.setup {
  on_attach = on_attach,
  cmd = servers.get_cmd('solargraph'),
}

-- require'xlsp.kitels'
-- lspconfig.kitels.setup{
--   on_attach= on_attach
-- }
