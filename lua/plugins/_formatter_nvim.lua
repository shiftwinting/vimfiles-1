if vim.api.nvim_call_function('FindPlugin', {'formatter.nvim'}) == 0 then
  do
    return
  end
end

local Path = require'plenary.path'

local config = {}
config.ruby = {
  function()
    return {
      exe = 'rufo',
      args = { '--' },
      stdin = true
    }
  end
}

config['ruby.rspec'] = config.ruby

config.zig = {
  function()
    return {
      exe = 'zig',
      args = { 'fmt', '--stdin' },
      stdin = true
    }
  end
}

-- config.go = {
--   function()
--     return {
--       exe = 'gofmt',
--       args = {'-w'},
--       stdin = false
--     }
--   end
-- }


-- -- https://github.com/google/google-java-format
-- local p = Path:new(os.getenv('HOME') .. '/.local/jars/google-java-format.jar')
-- if not p:exists() then
--   local cmd = vim.fn.stdpath('config') .. '/scripts/install-google-java-format.sh'
--   vim.cmd(string.format('split | execute "terminal " .. "%s"', cmd))
-- end
--
-- config.java = {
--   function()
--     return {
--       exe = 'java',
--       args = {
--         '-jar',
--         p:absolute(),
--         '--replace',
--         vim.api.nvim_buf_get_name(0)
--       },
--       stdin = false
--     }
--   end
-- }

-- yarn global add sql-formatter
-- https://github.com/zeroturnaround/sql-formatter
config.sql = {
  function()
    return {
      exe = 'sql-formatter',
      args = {
        -- キーワードを大文字にする
        '--uppercase',
        -- クエリの間に改行を1つ入れる
        '--lines-between-queries', '2',
        -- '--language', 'postgresql'
      },
      stdin = true
    }
  end
}

-- yarn global add prettier
config.html = {
  function()
    return {
      exe = 'prettier',
      args = {
        '--stdin-filepath', vim.api.nvim_buf_get_name(0), '--single-quote'
      },
      stdin = true,
    }
  end
}

-- xmllint を使う？
-- -- yarn global add @prettier/plugin-xml
-- config.xml = {
--   function()
--     return {
--       exe = 'prettier',
--       args = {
--         vim.api.nvim_buf_get_name(0),
--       },
--       stdin = true
--     }
--   end
-- }

require'formatter'.setup {
  filetype = config,
}

local patterns = {
  '*.zig',
  '*.rb',
  -- '*.java',
  '*.sql',
  '*.html',
  -- '*.xml'
}

vim.api.nvim_exec(string.format([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost %s FormatWrite
augroup END
]], table.concat(patterns, ',')), true)
