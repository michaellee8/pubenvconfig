-- Declare packer.nvim plugins.


require("packer").startup(function(use)

  -- load packer
  use "wbthomason/packer.nvim"

  -- treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  require("init.lsp.config")(use)


  -- dap support

  use "mfussenegger/nvim-dap"

  use "theHamsta/nvim-dap-virtual-text"
  
  use { 
    "rcarriga/nvim-dap-ui", 
    requires = {
      "mfussenegger/nvim-dap"
    },
    config = function()
      require("dapui").setup()
    end
  }

  -- telescope
  
  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {}
    end
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {"nvim-lua/popup.nvim"}, 
      {"nvim-lua/plenary.nvim"},
      {"kyazdani42/nvim-web-devicons"},
    },
    config = function()
      require("telescope").setup {}
    end
  }
  -- Optionally depends on ripgrep and fd-find, 
  -- install by sudo apt install ripgrep fd-find.


  -- other plugins

  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("gitsigns").setup()
    end
  }

  use "tpope/vim-fugitive"

  use "tpope/vim-eunuch"

  use "tpope/vim-surround"

  use "tpope/vim-commentary"
  
  use "editorconfig/editorconfig-vim"
  
  use "christoomey/vim-tmux-navigator"

  use "Yggdroot/indentLine"

  use "vim-airline/vim-airline"

  use "vim-airline/vim-airline-themes"

  use "tpope/vim-obsession"

  use {
    "prettier/vim-prettier",
    run = "yarn install",
  }

  use "junegunn/fzf"

  use {
    "junegunn/fzf.vim",
    requires = {
      "junegunn/fzf",
    },
  }

 require("init.flutter")(use) 
end)
