-- Disable flutter tools if a specific environment variable is specified.
-- Intended for developing Dart SDK or Flutter SDK in-tree.

local no_flutter = vim.env.VIM_NO_FLUTTER == "1" or vim.env.VIM_NO_FLUTTER == "true"

return function(use)
  -- flutter specific
  use {
    "akinsho/flutter-tools.nvim",
    disable = no_flutter,
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
