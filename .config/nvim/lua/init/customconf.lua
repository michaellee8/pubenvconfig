-- Source a specific vimconf.lua in the cwd.

local use_custom_config = vim.env.VIM_USE_CUSTOM_CONFIG == "true" or vim.env.VIM_USE_CUSTOM_CONFIG == "1"


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
