if vim.api.nvim_call_function('FindPlugin', {'formatter.nvim'}) == 0 then
  do
    return
  end
end

require'formatter'.setup {
  filetype = {
    -- lua = {
    --   -- https://github.com/Koihik/LuaFormatter/blob/master/docs/Style-Config.md
    --   function()
    --     return {
    --       exe = vim.g.plugs['vscode-lua-format'].dir .. 'bin/linux/lua-format',
    --       args = {
    --         '--indent-width=2',
    --         '--break-before-functioncall-rp',
    --         '--break-before-functiondef-rp',
    --         '--break-before-table-rb',
    --         '--chop-down-table',
    --         '--extra-sep-at-table-end',
    --         -- '--double-quote-to-single-quote',
    --         '--no-keep-simple-function-one-line',
    --         '--no-keep-simple-control-block-one-line',
    --         '--column-limit=80',
    --         '-i',
    --       },
    --       stdin = true,
    --     }
    --   end,
    -- },
    ruby = {
      function()
        return {
          exe = 'rufo',
          args = { '--' },
          stdin = true
        }
      end
    },
    zig = {
      function()
        return {
          exe = 'zig',
          args = { 'fmt', '--stdin' },
          stdin = true
        }
      end
    },
    -- json = {
    --   function()
    --     return {
    --       exe = 'jq',
    --       args = { '.' },
    --       stdin = false
    --     }
    --   end
    -- }
  },
}

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.zig,*.rb FormatWrite
augroup END
]], true)
