local M = {}

local last_gdb_config = {}

-- .plugged/vimspector/gadgets/linux/download/vscode-cpptools/0.27.0/root/extension/debugAdapters/bin/cppdbg.ad7Engine.json
-- という名前を
-- .plugged/vimspector/gadgets/linux/download/vscode-cpptools/0.27.0/root/extension/debugAdapters/bin/nvim-dap.ad7Engine.json
-- にする必要がある

M.start_zig_debugger = function(args, mi_mode, mi_debugger_path)
  local dap = require'dap'
  if args and #args> 0 then
    last_gdb_config = {
      -- adapter の名前
      type = 'cpp',
      name = args[1],
      request = 'launch',
      program = table.remove(args, 1),
      args = args,
      cwd = vim.fn.getcwd(),
      -- env = {},
      externalConsole = true,
      MIMode = mi_mode or 'gdb',
      MIDebuggerPath = mi_debugger_path,
    }
  end

  if not last_gdb_config then
    print('No binary to debug set! Use ":DebugZig <binary> <args>"')
    return
  end

  dap.run(last_gdb_config)
  dap.repl.open()
end

return M
