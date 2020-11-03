-- https://github.com/wbthomason/packer.nvim
vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
local packer_config = {
  -- install path
  package_root = '~/.config/nvim/pack'
}

packer.init(packer_config)

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  -- git
  use {'lewis6991/gitsigns.nvim',
    config = [[require('rc.lewis6991/gitsigns')]],
    requires = {'nvim-lua/plenary.nvim'},
  }

  -- color
  use {'norcalli/nvim-colorizer.lua',
    config = [[require('rc/norcalli/nvim-colorizer.lua')]],
  }
end)
