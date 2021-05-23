if vim.api.nvim_call_function('FindPlugin', {'nvim-dap'}) == 0 then do return end end

local dap = require'dap'

dap.adapters.cpp = {
  type = 'executable',
  name = 'cppdbg',
  command = vim.api.nvim_get_runtime_file("gadgets/linux/vscode-cpptools/debugAdapters/OpenDebugAD7", false)[1],
  attach = {
    pidProperty = 'proccessId',
    pidSelect = 'ask'
  }
}

vim.cmd [[command! -complete=file -nargs=* DebugZig lua require "xdap".start_zig_debugger({<f-args>}, "gdb")]]

vim.cmd [[augroup my-dap]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()]]
vim.cmd [[augroup END]]

-- require'dapui'.setup()

local map = function(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, { silent = true, noremap = true }))
end

map('n', '<F5>', ":lua require'dap'.continue()<CR>")
map('n', '<F10>', ":lua require'dap'.step_over()<CR>")
map('n', '<F11>', ":lua require'dap'.step_into()<CR>")
map('n', '<F12>', ":lua require'dap'.step_out()<CR>")

-- nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
-- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
-- nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

require'which-key'.register{
  ["<Space>d"] = {
    name = "+Debug Adapter Protocol",
    bb = { [[:lua require'dap'.toggle_breakpoint()<CR>]], 'Toggle breakpoint' },
    bB = { [[:lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]], 'Breakpoint condition.' },
    bp = { [[:lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]], 'Log point message' },
    bl = { [[:Telescope dap list_breakpoints]], 'List breakpoints' },

    rr = { [[:lua require'dap'.repl.open()<CR>]], 'Open a REPL / Debug-console.' },
    rl = { [[:lua require'dap'.run_last()<CR>]], 'Re-runs the last debug-adapter/configuration that ran using dap.run()' },
  }
}
