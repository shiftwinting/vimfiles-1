if vim.api.nvim_call_function('FindPlugin', {'nvim-autopairs'}) == 0 then do return end end

require'nvim-autopairs'.setup {
  disable_filetype = {
    'TelescopePrompt'
  }
}


_G.MUtils= {}
local npairs = require'nvim-autopairs'

vim.g.completion_confirm_key = ""
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end


vim.api.nvim_set_keymap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
