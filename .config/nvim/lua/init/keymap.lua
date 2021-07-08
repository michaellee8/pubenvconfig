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


-- Perform a <silent> <expr> keymap
local function map_se(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, {
    silent = true,
    expr = true,
  })
end

map_se("i", "<Tab>", "v:lua.tab_complete()")
map_se("s", "<Tab>", "v:lua.tab_complete()")
map_se("i", "<S-Tab>", "v:lua.s_tab_complete()")
map_se("s", "<S-Tab>", "v:lua.s_tab_complete()")

-- Perform a <silent> <expr> <noremap> keymap
local function map_sen(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, {
    silent = true,
    expr = true,
    noremap = true,
  })
end

map_sen("i", "<C-Space>", "compe#complete()")
map_sen("i", "<CR>", [[compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })]])
map_sen("i", "<C-e>", "compe#close('<C-e>')")
map_sen("i", "<C-f>", "compe#scroll({ 'delta': +4 })")
map_sen("i", "<C-d>", "compe#scroll({ 'delta': -4 })")

local function map_telescope(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, "<cmd>Telescope " .. rhs .. "<cr>", {
    noremap = true,
    silent = true,
  })
end

local function map_telescope_prefix(mode, lhs, rhs)
  local prefixes = { "<space>", "<leader>" }
  for _, p in ipairs(prefixes) do
    map_telescope(mode, p .. lhs, rhs)
  end
end

map_telescope_prefix("n", "ff", "find_files")
map_telescope_prefix("n", "f.", "find_files hidden=true")
map_telescope_prefix("n", "lf", "file_browser")
map_telescope_prefix("n", "l.", "file_browser hidden=true")
map_telescope_prefix("n", "lc", "file_browser hidden=true cwd=%:h")
map_telescope_prefix("n", "fg", "live_grep")
map_telescope_prefix("n", "fb", "buffers")
map_telescope_prefix("n", "fh", "help_tags")

map_telescope_prefix("n", "ds", "lsp_document_symbols")
map_telescope_prefix("n", "ws", "lsp_workspace_symbols")
map_telescope_prefix("n", "dws", "lsp_dynamic_workspace_symbols")
map_telescope_prefix("n", "rca", "lsp_range_code_actions")
map_telescope_prefix("n", "dd", "lsp_document_diagnostics")
map_telescope_prefix("n", "wd", "lsp_workspace_diagnostics")
map_telescope_prefix("n", "ca", "lsp_code_actions")

map_telescope("n", "gd", "lsp_definitions")
map_telescope("n", "gi", "lsp_implementations")
map_telescope("n", "gr", "lsp_references")

-- symbols-outline.nvim

vim.api.nvim_set_keymap("n", "<F8>", ":SymbolsOutline<CR>", { 
  silent = true 
})
