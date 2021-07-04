-- michaellee8's init.lua
-- This file is public domain just in case you want to use it.

-- Follows style guide from lua rocks
-- https://github.com/luarocks/lua-style-guide

-- helpers

-- From https://github.com/nanotee/nvim-lua-guide.
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Auto install packer.nvim.

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute "packadd packer.nvim"
end

-- Disable flutter tools if a specific environment variable is specified.
-- Intended for developing Dart SDK or Flutter SDK in-tree.

local no_flutter = vim.env.VIM_NO_FLUTTER == "1" or vim.env.VIM_NO_FLUTTER == "true"

-- Source a specific nvimconf.lua in the cwd.

local use_custom_config = vim.env.VIM_USE_CUSTOM_CONFIG == "true" or vim.env.VIM_USE_CUSTOM_CONFIG == "1"

-- Declare packer.nvim plugins.

vim.cmd [[packadd packer.nvim]]

vim._update_package_paths()

return require("packer").startup(function(use)

  -- load packer
  use "wbthomason/packer.nvim"

  -- treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- native lsp
  
  use "neovim/nvim-lspconfig"

  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = true,
        position = 'right',
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        keymaps = {
            close = "<Esc>",
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            rename_symbol = "r",
            code_actions = "a",
        },
        lsp_blacklist = {},
      }
    end
  }
  
  -- autocomplete
  
  use "Raimondi/delimitMate"

  use {
    "hrsh7th/nvim-compe",
    config = function()
      require("compe").setup()
    end
  }

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
      {"'kyazdani42/nvim-web-devicons'"},
    },
    config = function()
      require("telescope").setup {}
    end
  }
  -- Optionally depends on ripgrep, 
  -- install by sudo apt install ripgrep.


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

  -- Will this break flutter-tools.nvim?
  -- use "dart-lang/dart-vim-plugin"

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

  -- flutter specific

  if not no_flutter then
    use {
      "akinsho/flutter-tools.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("flutter-tools").setup{
          debugger = {
            enabled = true,
          },
          flutter_path = "/home/michaellee8/.local/lib/flutter/bin/flutter",
          widget_guides = {
            enabled = true,
          },
        }
        require("telescope").load_extension("flutter")
      end
    }
  end
  
end)

-- lsp config


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

require("lspconfig").pyright.setup{
  on_attach = on_attach,
}
require("lspconfig").pyright.setup{
  on_attach = on_attach,
}

require("lspconfig").gopls.setup{
  on_attach = on_attach,
}

require("lspconfig").jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    },
    on_attach = on_attach,
}
require("lspconfig").rust_analyzer.setup{
  on_attach = on_attach,
}

require("lspconfig").yamlls.setup{
  on_attach = on_attach,
}

require("lspconfig").tsserver.setup{
  on_attach = on_attach,
}




-- autocomplete config

vim.o.completeopt = "menuone,noselect"


-- dap related config

vim.g.dap_virtual_text = true




-- keymap

-- nvim-compe suggested keymap

local function set_nvim_compe_keymap(l, r)
  vim.api.nvim_set_keymap("n", l, r, {
    noremap = true, 
    slient = true, 
    expr = true, 
  })
end

set_nvim_compe_keymap("<C-Space>", "compe#complete()")
-- Not sure if this is the corrrect way for lua,
-- see https://github.com/hrsh7th/nvim-compe/commit/a7ea48b856841518cd9f542338a69f5165a65de4
set_nvim_compe_keymap("<CR>", 'compe#confirm({ "keys": "\<Plug>delimitMateCR", "mode": "" }')
set_nvim_compe_keymap("<C-e>", "compe#close('<C-e>')")
set_nvim_compe_keymap("<C-f>", "compe#scroll({ 'delta': +4 })")
set_nvim_compe_keymap("<C-d>", "compe#scroll({ 'delta': -4 })")

-- symbols-outline.nvim

vim.api.nvim_set_keymap("n", "<F8>", ":SymbolsOutline<CR>", { 
  silent = true 
})

-- core settings


