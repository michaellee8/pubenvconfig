-- autocomplete config

vim.o.completeopt = "menuone,noselect"

-- dap related config

vim.g.dap_virtual_text = true

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

