local M = {}

function M.setup()
  local alpha = require('alpha')
  local dashboard = require('alpha.themes.dashboard')
local ascii_art = {
  [[ __  __                      _____             ]],
  [[/\ \/\ \   __               /\___ \            ]],
  [[\ \ \ \ \ /\_\     ___ ___  \/__/\ \   __  __  ]],
  [[ \ \ \ \ \\/\ \  /' __` __`\   _\ \ \ /\ \/\ \ ]],
  [[  \ \ \_/ \\ \ \ /\ \/\ \/\ \ /\ \_\ \\ \ \_\ \]],
  [[   \ `\___/ \ \_\\ \_\ \_\ \_\\ \____/ \ \____/]],
  [[    `\/__/   \/_/ \/_/\/_/\/_/ \/___/   \/___/ ]],
}

  -- ASCII Art
  local header = {
    type = "text",
    val = ascii_art,
    opts = {
      position = "center",
      hl = "Nordwebb"
    }
  }



  -- Buttons
  local buttons = {
    type = "group",
    val = {
      dashboard.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
      dashboard.button( "f", "  Find file", ":Telescope find_files <CR>"),
      dashboard.button( "r", "  Recent"   , ":Telescope oldfiles <CR>"),
      dashboard.button( "s", "  Settings" , ":e $MYVIMRC <CR>"),
      dashboard.button( "q", "  Quit NVIM (Out of order)", ":qa<CR>"),
    },
    opts = {
      spacing = 1
    }
  }

  -- Set header and buttons
  dashboard.section.header = header
  dashboard.section.buttons = buttons

  -- Set footer (optional)
  local footer = {
    type = "text",
    val = "Welcome to Neovim",
    opts = {
      position = "center",
      hl = "Number"
    }
  }
  dashboard.section.footer = footer

  -- Set the layout of the dashboard sections
  dashboard.config.layout = {
    { type = "padding", val = 2 },
    header,
    { type = "padding", val = 2 },
    buttons,
    { type = "padding", val = 1 },
    footer,
  }

  -- Set the modified dashboard config to alpha
  alpha.setup(dashboard.opts)
end

return M
