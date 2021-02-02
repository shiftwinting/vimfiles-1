local dial = require'dial'

dial.searchlist.normal = {
  dial.augends.number.decimal,
  dial.augends.number.hex,
  dial.augends.number.octal,
  dial.augends.number.binary,
  dial.augends.number.decimal_integer,
  dial.augends.number.decimal_fixeddigit_zero,
  dial.augends.number.decimal_fixeddigit_space,
  dial.augends.number.decimal_fixeddigit_space,
  dial.augends.date["%Y/%m/%d"],
  dial.augends.date["%m/%d"],
  dial.augends.date["%-m/%-d"],
  dial.augends.date["%Y-%m-%d"],
  dial.augends.date["%Y年%-m月%-d日"],
  dial.augends.date["%Y年%-m月%-d日(%ja)"],
  dial.augends.date["%H:%M:%S"],
  dial.augends.date["%H:%M"],
  dial.augends.date["%ja"],
  dial.augends.date["%jA"],
  dial.augends.markup.markdown_header,
}

vim.api.nvim_set_keymap('n', '<C-a>', '<Plug>(dial-increment)', {nowait = true})
vim.api.nvim_set_keymap('n', '<C-x>', '<Plug>(dial-decrement)', {nowait = true})
