local M = {}

function M.parse_python_errors_from_terminal()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local output = table.concat(lines, "\n")
  local python_errorformat = '%A  File "%f"%\\, line %l\\,%m,' ..
                             '%C        %m,' ..
                             '%-Z%p^%.%#,' ..
                             '%-G%.%#'

  vim.fn.setqflist({}, ' ', {
    title = 'Python Errors',
    lines = vim.split(output, '\n'),
    efm = python_errorformat
  })

  vim.cmd('copen')
end

vim.api.nvim_create_user_command(
  'TerminalErrors',
  function()
    M.parse_python_errors_from_terminal()
  end,
  {desc = "Parse errors from terminal and populate the quickfix list"}
)

return M

