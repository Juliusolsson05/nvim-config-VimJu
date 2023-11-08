local M = {}

function M.setup()
  -- General settings
  vim.o.shell = "powershell"
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
  vim.opt.ignorecase = true
  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.api.nvim_command('hi Nordwebb guifg=#33ccff gui=bold')

  -- Highlighting on yank
  vim.cmd [[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
    augroup END
  ]]

  -- Highlighting settings
  vim.cmd [[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight NvimTreeNormal guibg=NONE ctermbg=NONE
    highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
    highlight LineNr guifg=#03ecfc
    highlight Visual guibg=#265f6e 
  ]]

  -- Search settings
  vim.cmd [[
    cnoreabbrev <expr> s getcmdtype() == ':' && getcmdline() == 's' ? '%s' : 's'
  ]]
end

return M

