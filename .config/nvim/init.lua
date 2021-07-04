-- michaellee8's init.lua
-- This file is public domain just in case you want to use it.

-- Auto install packer.nvim

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Declare packer.nvim plugins

vim.cmd [[packadd packer.nvim]]

vim._update_package_paths()

return require('packer').startup(function(use)

-- load packer
  use 'wbthomason/packer.nvim'

-- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  
-- autocomplete
  use {
    'hrsh7th/nvim-compe',
    config = function()
      require('compe').setup()
    end
  }

-- dap support

  use 'mfussenegger/nvim-dap'

  use 'theHamsta/nvim-dap-virtual-text'
  
  use { 
    "rcarriga/nvim-dap-ui", 
    requires = {
      "mfussenegger/nvim-dap"
    },
    config = function()
      require('dapui').setup()
    end
  }



  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }


end)

-- lsp config


-- autocomplete config

vim.o.completeopt = "menuone,noselect"


-- dap related config

vim.g.dap_virtual_text = true

require("dapui").setup()


