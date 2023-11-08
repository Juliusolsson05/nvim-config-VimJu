-- Script for running the tree command inside the terminal with the depth as a parameter, useful for AI debugging.
vim.api.nvim_create_user_command('UMD', function(opts)
  -- Open a new terminal buffer with ':terminal'
  vim.cmd('terminal')
  -- Multi-line command to be sent to the terminal with maxDepth replaced
  local command = "python manage.py graph_models -a -g --dot > Nordtools_UMD.dot"

    -- Get the current buffer number after opening the terminal
  local bufnr = vim.api.nvim_get_current_buf()
  -- Send the multi-line command to the terminal followed by a carriage return (\r)
  -- The carriage return is appended at the end of each line
   vim.api.nvim_chan_send(vim.b[bufnr].terminal_job_id, command)
  end
)


