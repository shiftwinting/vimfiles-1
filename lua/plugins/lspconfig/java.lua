local M = {}

local Path = require'plenary.path'

-- The declared package "com.example.restservice" does not match the expected package "..."
-- みたいなやつの対処法は、
-- https://github.com/eclipse/eclipse.jdt.ls/issues/1764
-- "java.project.sourcePaths" に追加する

-- https://github.com/mfussenegger/nvim-jdtls

-- start_or_attach() には vim.lsp.start_client() に渡すものを渡せる
vim.cmd [[augroup MyJavaLsp]]
vim.cmd [[   autocmd!]]
vim.cmd [[  autocmd FileType java lua require('plugins/lspconfig/java').start_or_attach()]]
vim.cmd [[augroup END]]

local map = function(mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, { silent = true, noremap = true }))
end

function M.start_or_attach()
  -- cmd の第2引数でワークスペースのパスを指定する
  local root_dir = require'jdtls.setup'.find_root({'gradle.build', 'pom.xml'})
  -- local workspace_folder = os.getenv('GHQ_ROOT') .. '/github.com/tamago324/' .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local script_path = vim.fn.stdpath('config') .. '/scripts/java-lsp.sh'
  local config = {
    -- cmd = { script_path, workspace_folder },
    name = "jdtls",
    cmd = { script_path },
    root_dir = root_dir,
    on_attach = function(client)
      require'plugins/nvim-lspconfig'.on_attach(client)

      map( 'n', '<Space>fa', [[<cmd>lua require('jdtls').code_action()<CR>]])

      -- vim.cmd [[command! -buffer OrganizeImports lua require'jdtls'.organize_imports()]]

      -- dap
      -- require'jdtls'.setup_dap({ hotcodereplace = 'auto' })
    end,
    settings = require'nlspsettings'.get_settings('jdtls')
  }

  -- dap
  local debug_dir = Path:new(os.getenv('HOME') .. '/.local/java-debug')
  if not debug_dir:exists() then
    local cmd = vim.fn.stdpath('config') .. '/scripts/install-java-debug.sh'
    vim.cmd(string.format('split | execute "terminal " .. "%s"', cmd))
  end

  config['init_options'] = {
    bundles = {
      vim.fn.glob(os.getenv('HOME') .. '/.local/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar')
    }
  }


  require('jdtls').start_or_attach(config)
end

-- actions の UI を変更
local finders = require'telescope.finders'
local sorters = require'telescope.sorters'
local actions = require'telescope.actions'
local pickers = require'telescope.pickers'

require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
  local opts = {}
  pickers.new(opts, {
    prompt_title = prompt,
    finder    = finders.new_table {
      results = items,
      entry_maker = function(entry)
        return {
          value = entry,
          display = label_fn(entry),
          ordinal = label_fn(entry),
        }
      end,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = actions.get_selected_entry()
        actions.close(prompt_bufnr)

        cb(selection.value)
      end)

      return true
    end,
  }):find()
end
-- local jdtls_ui = require'jdtls.ui'
-- function jdtls_ui.pick_one_async(items, _, _, cb)
--   require'lsputil.codeAction'.code_action_handler(nil, nil, items, nil, nil, nil, cb)
-- end

return M
