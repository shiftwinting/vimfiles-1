local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')


-- @Summary ghq
-- @Description
return function()
  local ghq_root = vim.env.GHQ_ROOT
  require'telescope'.extensions.ghq.list{
    previewer = false,

    entry_maker = function(line)
      local short_name = string.sub(line, #ghq_root + #'/github.com/' + 1)
      return {
        value = line,
        ordinal = short_name,
        display = short_name,
        short_name = short_name,
      }
    end,
    attach_mappings = function(prompt_bufnr, map)
      local tabnew = function()
        local val = actions.get_selected_entry().value
        actions.close(prompt_bufnr)
        vim.api.nvim_command('tabnew')
        vim.api.nvim_command(string.format('tcd %s | edit .', val))
        -- vim.api.nvim_command(string.format([[tcd %s | lua require'lir.float'.toggle()]], val))
      end

      -- ブラウザで開く
      local open_browser = function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.fn['openbrowser#open'](string.format('https://github.com/%s', entry.short_name))
      end

      actions.select_default:replace(tabnew)
      actions.select_tab:replace(tabnew)
      map('i', '<C-x>', open_browser)
      map('n', '<C-x>', open_browser)

      return true
    end
  }
end

