if vim.api.nvim_call_function('FindPlugin', {'nvim-treesitter'}) == 0 then do return end end

-- https://github.com/rcarriga/dotfiles/blob/4dea65d6d75a34788bba36bfb6074815feff784c/.config/nvim/lua/init.lua
require('nvim-treesitter.configs').setup{
  ensure_installed = {
    'lua',
    'python',
    'json',
    'c',
    'query',
    'javascript',
    'rust',
    'bash',
    'toml',
    'comment',
    'typescript',
    -- 'vim'
  },
  highlight = {
    enable = true,
  },
  -- indent = {
  --   enable = true,
  --   disable = {'rust'},
  -- },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        -- ['ab'] = '@block.outer',
        -- ['ib'] = '@block.inner',
        ['ac'] = '@call.outer',
        ['ic'] = '@call.inner',
        ['a,'] = '@parameter.outer',
        ['i,'] = '@parameter.inner',
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ['g>'] = '@parameter.inner',
      },
      swap_previous = {
        ['g<'] = '@parameter.inner',
      }
    },
  },
  refactor = {
    highlight_definitions = {
      enable = true,
    },
    -- highlight_current_scope = {
    --   enable = true
    -- },
    -- smart_rename = {
    --   enable = true,
    --   keymaps = {
    --     smart_rename = 'Rr'
    --   }
    -- }
  },
  -- rainbow = {
  --   enable = true
  -- },
  playground = {
    enable = true
  },
  -- tree_docs = {
  --   enable = true,
  -- }
}
