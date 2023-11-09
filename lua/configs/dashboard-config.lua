-- Define a module table to return at the end
local M = {}

-- Function to set up the dashboard
function M.setup()
  -- Import the dashboard plugin
  local db = require('dashboard')

  -- ASCII Art
  local ascii_art = [[
 __  __                      _____             
/\ \/\ \   __               /\___ \            
\ \ \ \ \ /\_\     ___ ___  \/__/\ \   __  __  
 \ \ \ \ \\/\ \  /' __` __`\   _\ \ \ /\ \/\ \ 
  \ \ \_/ \\ \ \ /\ \/\ \/\ \ /\ \_\ \\ \ \_\ \
   \ `\___/ \ \_\\ \_\ \_\ \_\\ \____/ \ \____/
    `\/__/   \/_/ \/_/\/_/\/_/ \/___/   \/___/ 
 ]]

  -- Set the custom header
  db.custom_header = vim.split(ascii_art, "\n")

  -- Menu items
  db.custom_center = {
    {icon = '  ', desc = 'New file                    ', action ='DashboardNewFile'},
    {icon = '  ', desc = 'Find file                   ', action ='Telescope find_files'},
    {icon = '  ', desc = 'Recently used files         ', action ='Telescope oldfiles'},
    {icon = '  ', desc = 'Configuration               ', action ='edit $MYVIMRC'},
    {icon = '  ', desc = 'Quit NVIM                   ', action ='quit'},
  }

  -- Footer
  db.custom_footer = {'Do one thing and do it well.'}

  -- Highlight groups
  vim.api.nvim_set_hl(0, 'DashboardHeader', {fg = '#ebcb8b'})
  vim.api.nvim_set_hl(0, 'DashboardCenter', {fg = '#b48ead'})
  vim.api.nvim_set_hl(0, 'DashboardFooter', {fg = '#a3be8c'})
end

-- Call the setup function
M.setup()

-- Return the module table
return M

