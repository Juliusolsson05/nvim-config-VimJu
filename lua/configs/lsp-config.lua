local M = {}

function M.setup()
  local lspconfig = require('lspconfig')

  -- Example LSP setup for Python using pyright
  lspconfig.pyright.setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  }

  -- Add other LSP servers here
end

return M

