-- The installed themes

local colorscheme_lua = vim.fn.stdpath('config') .. '/colorscheme.lua'
if vim.fn.filereadable(colorscheme_lua) == 1 then
  local colorscheme = require('colorscheme')
  vim.cmd('colorscheme ' .. colorscheme)
else
local themes = require("themes.monokai")
end

