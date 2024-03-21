local M = {}

local telescope = require('telescope')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values

local function select_colorscheme(colorscheme)
  local success, err = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
  if success then
    -- Write the selected colorscheme to a Lua file
    local colorscheme_lua = vim.fn.stdpath('config') .. '/theme-cache.lua'
    local file = io.open(colorscheme_lua, 'w')
    if file then
      file:write("return '" .. colorscheme .. "'")
      file:close()
    else
      vim.notify('Could not write colorscheme file.', vim.log.levels.ERROR)
    end
  else
    vim.notify('Error loading colorscheme: ' .. err, vim.log.levels.ERROR)
  end
end

-- Colorscheme previewer
local function colorscheme_previewer(opts)
  return function(_, entry, status)
    select_colorscheme(entry.value)
  end
end

-- Picker function to list and preview colorschemes
function M.colorscheme_selector(opts)
  opts = opts or {}
  local colorschemes = vim.fn.getcompletion('', 'color')

  local previewer = require('telescope.previewers').new_buffer_previewer({
    define_preview = function(self, entry, status)
      select_colorscheme(entry.value)
    end,
  })

  pickers.new(opts, {
    prompt_title = 'Color Schemes',
    finder = finders.new_table({
      results = colorschemes,
      entry_maker = function(entry)
        return {
          display = entry,
          value = entry,
          ordinal = entry,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    previewer = previewer, -- set the previewer here
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<CR>', function(bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        select_colorscheme(selection.value)
        require('telescope.actions').close(bufnr)
      end)

      return true
    end,
  }):find()
end

-- Telescope setup with default configurations
function M.setup()
  telescope.setup({
    defaults = {
      -- Your default config for telescope goes here
      -- You can leave it empty to use the default settings
      -- Or you can add your preferences
      file_ignore_patterns = { "node_modules" },
    },
    extensions = {
      -- Your extensions configuration goes here
    }
  })

  -- To load extensions you've added above
  -- telescope.load_extension('some_extension')

  -- Adding the `TelescopeColorschemes` command to Neovim
  vim.api.nvim_create_user_command('Colors', M.colorscheme_selector, {})
end

return M

