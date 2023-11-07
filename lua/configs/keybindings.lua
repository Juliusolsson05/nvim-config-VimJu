local M = {}

function M.setup()
  -- Keybindings
  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  -- NvimTree
  map('n', '<leader>r', ':NvimTreeToggle<CR>', opts)

  -- Config file
  map('n', '<leader>cf', ':edit $MYVIMRC<CR>', opts)

  -- LSP
  map('n', 'P', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- Telescope
  map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
  map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
  map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
  map('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

  -- Buffer navigation
  map('n', '<TAB>', ':BufferNext<CR>', opts)
  map('n', '<S-TAB>', ':BufferPrevious<CR>', opts)

  -- Terminal escape
  map('t', '<C-n>', '<C-\\><C-n>', opts)


-- Define custom command "Find" that opens Telescope find_files
vim.api.nvim_create_user_command(
  'Find',
  function()
    require('telescope.builtin').find_files()
  end,
  {desc = "Open Telescope to find files"}
)

end

return M

