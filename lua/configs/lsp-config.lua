local M = {}

function M.setup()
  local lspconfig = require('lspconfig')
  local cmp_nvim_lsp = require('cmp_nvim_lsp')

  -- Enhance the default LSP capabilities with nvim-cmp's capabilities
  local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
  
  -- Add additional LSP capabilities that support more features
  capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  }
  -- Setup LSP servers
  -- Here we setup pyright, you can add more servers using lspconfig.<server>.setup
  lspconfig.pyright.setup({
    capabilities = capabilities, -- Add enhanced capabilities
    on_attach = function(client, bufnr)
      -- on_attach will allow us to configure buffer specific key mappings
      -- You can add your key mappings here if needed, but as you said, keybinds go elsewhere
    end,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          typeCheckingMode = "strict" -- Can be "off", "basic", or "strict"
        }
      }
    }
  })
-- Setup ESLint
lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Optional: Add buffer specific key mappings here, if needed
  end,
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
    format = true, -- Enable or disable automatic formatting
    run = "onType", -- Other option is 'onSave'
    rulesCustomizations = {
      -- Example: Override a specific rule (adjust according to your needs)
      { rule = "no-unused-vars", severity = "off" }
    },
    -- Add more ESLint specific settings here as per your project requirements
  }
})-- Configure Lua LSP with auto-formatting using ast-grep
lspconfig.lua_ls.setup({
    on_attach = function(client, bufnr)
        -- Enable auto-formatting on save
        vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'AstGrepFormat()')
        vim.api.nvim_buf_set_option(bufnr, 'formatprg', 'ast-grep fmt')
    end,
    settings = {
        Lua = {
            -- Your Lua LSP settings here
            format = {
                enable = true, -- Enable formatting
            },
        },
    },
})end

return M

