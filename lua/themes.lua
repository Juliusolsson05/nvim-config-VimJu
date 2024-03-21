local colorscheme_lua = vim.fn.stdpath('config') .. '/theme-cache.lua'
if vim.fn.filereadable(colorscheme_lua) == 1 then
  -- Load the colorscheme from the file
  local colorscheme_code = loadfile(colorscheme_lua)
  local colorscheme = colorscheme_code()
  vim.cmd('colorscheme ' .. colorscheme)
end

