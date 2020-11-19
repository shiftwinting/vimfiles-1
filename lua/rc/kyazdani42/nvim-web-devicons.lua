if vim.api.nvim_call_function('FindPlugin', {'nvim-web-devicons'}) == 0 then do return end end

local devicons = require'nvim-web-devicons'

devicons.setup({
  default = true,
  override = {
    ["folder_icon"] = {
      icon = "",
      color = "#7ebae4",
      name = "FolderNode"
    },
    ["default_icon"] = {
      icon = "",
      color = "#6d8086",
      name = "Default",
    }
  }
})
