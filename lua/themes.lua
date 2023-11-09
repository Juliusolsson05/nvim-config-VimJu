-- Check if there is a selected theme stored in cache otherwise use monokai
local colorscheme_lua = vim.fn.stdpath('config') .. '/theme-cache.lua'
if vim.fn.filereadable(colorscheme_lua) == 1 then
  local colorscheme = require('theme-cache')
  vim.cmd('colorscheme ' .. colorscheme)
end

