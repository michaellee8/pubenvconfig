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

-- Source a specific vimconf.lua in the cwd.

local use_custom_config = vim.env.VIM_USE_CUSTOM_CONFIG == "true" or vim.env.VIM_USE_CUSTOM_CONFIG == "1"

-- Declare packer.nvim plugins.


require("packer").startup(function(use)

  -- load packer
  use "wbthomason/packer.nvim"

  -- treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- native lsp
  
  use {
    "neovim/nvim-lspconfig",
    config = function()
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
    end
  }

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
    requires = {
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
    },
    config = function()
      require("compe").setup{
        enabled = true,
        autocomplete = true,
        debug = true,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        resolve_timeout = 800,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = {
          border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
          winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
          max_width = 120,
          min_width = 60,
          max_height = math.floor(vim.o.lines * 0.3),
          min_height = 1,
        },

        source = {
          path = true,
          buffer = true,
          calc = true,
          nvim_lsp = true,
          nvim_lua = true,
          vsnip = true,
          ultisnips = true,
          luasnip = true,
        },
      }
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
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- Some keymaps are commented out to prevent collision with lspsaga
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
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

_G._on_lsp_attach = on_attach

-- autocomplete config

vim.o.completeopt = "menuone,noselect"


-- dap related config

vim.g.dap_virtual_text = true




-- keymap

-- nvim-compe suggested keymap

local function set_nvim_compe_keymap(l, r)
  vim.api.nvim_set_keymap("n", l, r, {
    noremap = true, 
    silent = true, 
    expr = true, 
  })
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Setting keymap in lua is verbose right now, so I just use VimScript
vim.cmd([[

" nvim-compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>f. <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

]])

-- symbols-outline.nvim

vim.api.nvim_set_keymap("n", "<F8>", ":SymbolsOutline<CR>", { 
  silent = true 
})

-- core settings

vim.o.number = true
vim.o.relativenumber = true
vim.o.filetype= "on"
vim.o.wrap = false

vim.o.colorcolumn = "80"

-- 2 spaces for indention

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.mouse = "a"

vim.o.statusline = vim.o.statusline .. "%F"

local cwd = vim.fn.getcwd()
if use_custom_config and vim.fn.filereadable(cwd .. "/vimconf.lua") == 1 then
  local msg1 = "Trying to source " .. cwd .. 
    "/vimconf.lua becuase you have set VIM_USE_CUSTOM_CONFIG to " ..
    vim.env.VIM_USE_CUSTOM_CONFIG .. "."
  local choices1 = "&No\n&yes\n&show"
  local default1 = 1
  local result1 = vim.fn.confirm(msg1, choices1, default1)
  if result1 == 2 then
    -- yes, load the script
    vim.cmd("source " .. cwd .. "/vimconf.lua")
  elseif result1 == 3 then
    -- show, show the script to user
    -- use binary readfile() to block encoding tricks
    local script_text = vim.fn.readfile(cwd .. "/vimconf.lua", "b")
    local msg2 = "Content of ".. cwd .. "/vimconf.lua: \n" ..
      "-------------------------------------\n" ..
      table.concat(script_text,"\n") ..
      "\n-------------------------------------\n" ..
      "Really load this script?\n"
    local choice2 = "&No\n&yes"
    local default2 = 1
    local result2 = vim.fn.confirm(msg2, choice2, default2)
    if result2 == 2 then
      -- yes, load the script
      vim.cmd("source " .. cwd .. "/vimconf.lua")
    end
  elseif result == 1 then
    -- No, do not load the script
    -- No-op
  end

end
