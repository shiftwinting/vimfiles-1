command! PackerInstall packadd packer.nvim | lua require('packers').install()
command! PackerUpdate  packadd packer.nvim | lua require('packers').update()
command! PackerSync    packadd packer.nvim | lua require('packers').sync()
command! PackerClean   packadd packer.nvim | lua require('packers').clean()
command! PackerCompile packadd packer.nvim | lua require('packers').compile()
