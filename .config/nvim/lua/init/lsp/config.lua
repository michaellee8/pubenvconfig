local on_attach = require("init.lsp.attach")

return function(use)
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

  use {
    "nvim-lua/lsp_extensions.nvim",
    requires = {
      "neovim/nvim-lspconfig",
    },
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
end
