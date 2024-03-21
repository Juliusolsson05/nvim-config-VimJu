-- Script for running the tree command inside the terminal with the depth as a parameter, useful for AI debugging.
vim.api.nvim_create_user_command('Tree', function(opts)
  -- Open a new terminal buffer with ':terminal'
  vim.cmd('terminal')

  -- The default maxDepth if no argument is provided
  local maxDepth = opts.args == "" and 3 or tonumber(opts.args)
  -- If the argument is not a valid number, revert to the default value
  maxDepth = maxDepth or 3

  -- Multi-line command to be sent to the terminal with maxDepth replaced
  local command = [[
function DisplayTree {
    param (
        [string]$path = ".",
        [int]$depth = 0,
        [int]$maxDepth = ]] .. maxDepth .. [[
    )

    $items = Get-ChildItem -Path $path -ErrorAction SilentlyContinue

    foreach ($item in $items) {
        " " * ($depth * 4) + $item.Name
        if ($item.PSIsContainer -and $depth -lt $maxDepth) {
            DisplayTree -path $item.FullName -depth ($depth + 1) -maxDepth $maxDepth
        }
    }
}
DisplayTree
  ]]

  -- Get the current buffer number after opening the terminal
  local bufnr = vim.api.nvim_get_current_buf()
  -- Send the multi-line command to the terminal followed by a carriage return (\r)
  -- The carriage return is appended at the end of each line
  for line in command:gmatch("([^\r\n]+)") do
    vim.api.nvim_chan_send(vim.b[bufnr].terminal_job_id, line .. "\r")
  end
end, { nargs = '?' })  -- nargs = '?' means the command accepts zero or one argument


