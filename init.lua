vim.g.mapleader = " "  -- Set leader key to spacebar

-- Helper functions
local function is_packer_installed()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  return vim.fn.empty(vim.fn.glob(install_path)) == 0
end
-- Auto-install packer if it's not installed
if not is_packer_installed() then
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd('packadd packer.nvim')
end

-- Plugins to check in for tailwind support:
-- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
-- https://github.com/NvChad/nvim-colorizer.lua



-- Plugin configuration
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'polirritmico/monokai-nightasty.nvim' -- Theme
    use {
  'folke/tokyonight.nvim', 
}  

use 'neovim/nvim-lspconfig' -- LSP
use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  config = function() require('lualine').setup() end
}

-- Autocompletion plugins
use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
use 'hrsh7th/cmp-buffer' -- Buffer source for nvim-cmp
use 'hrsh7th/cmp-path' -- Path source for nvim-cmp
use 'hrsh7th/cmp-cmdline' -- Cmdline source for nvim-cmp
use 'saadparwaiz1/cmp_luasnip' -- Snippet source for nvim-cmp
use 'L3MON4D3/LuaSnip' -- Snippets plugin


-- Make scrolling seem smoother
use 'karb94/neoscroll.nvim'
-- Which-key displays what key does what
use 'folke/which-key.nvim'
use {
  'folke/flash.nvim',
  config = function()
    -- Setup configuration for 'flash.nvim'
    require'flash'.setup({
      -- Configuration options go here
    })

    -- Keybinds for using flash, navigation after search
    local flash = require('flash')
    vim.api.nvim_set_keymap('n', '<leader>f', "<cmd>lua require('flash').jump()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>F', "<cmd>lua require('flash').treesitter()<CR>", { noremap = true, silent = true })
    -- Add other keybinds if necessary
  end
}


-- Treesitter configuration
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all"
        ensure_installed = { "lua", "python", "javascript" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = true,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "javascript", "c" },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = true,
        },

        -- Indentation based on treesitter for the `=` operator. Experimental.
        indent = {
          enable = true,
        },

        -- Incremental selection based on the named nodes from the grammar.
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },

        -- Treesitter-based textobjects
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      }
    end
  }


  -- Mason for managing LSPs, DAPs, linters, and formatters
  use {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup()
    end
  }

  -- Other plugins
  use 'petertriho/nvim-scrollbar' -- Scrollbar plugin
  -- use 'preservim/tagbar' -- Tagbar plugin
  use 'vim-scripts/RltvNmbr.vim' -- Relative number plugin
  use {
    'romgrk/barbar.nvim', -- Tabline plugin
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  use 'tpope/vim-fugitive' -- Git integration plugin
  use {
    'nvim-telescope/telescope.nvim', -- Fuzzy finder plugin
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'justinmk/vim-sneak' -- Sneak motion plugin
  use {
    'lewis6991/gitsigns.nvim', -- Git signs plugin
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }
  use 'windwp/nvim-autopairs' -- Autopairs plugin
  use 'Yggdroot/indentLine' -- Indent line plugin
  use {
    'kyazdani42/nvim-tree.lua', -- File explorer plugin
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-tree').setup {
        -- Configure nvim-tree options
      }
    end 
  }
end)


local cmp = require'cmp'
local lspconfig = require'lspconfig'


-- Set the default terminal to powershell
vim.o.shell = "powershell"

-- Define the capabilities using the new default_capabilities method
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' }
    }),
    window = {
      -- Completion menu
      completion = cmp.config.window.bordered(),
      -- Documentation window
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      -- Enable this to have a more "native" feeling UI (optional)
      native_menu = false,
      -- Enable ghost text (optional)
      ghost_text = true,
    },
})

-- Example LSP setup for Python using pyright
lspconfig.pyright.setup{
    capabilities = capabilities, -- Pass the updated capabilities here
}

-- Set default tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Convert tabs to spaces

-- Set the file underline color to white 
vim.api.nvim_set_hl(0, 'CursorLine', {underline = true, sp = 'white'})

-- Make the default search not to be casesensetive
vim.opt.ignorecase = true

-- Rebinding the search and replace command to only s instead of %
vim.cmd [[
  cnoreabbrev <expr> s getcmdtype() == ':' && getcmdline() == 's' ? '%s' : 's'
]]


-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd("highlight LineNr guifg=#03ecfc")
-- Selection color --
vim.cmd [[
  highlight Visual guibg=#265f6e 
]]


-- Keybindings
-- Toggle the file explorer
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Open the config file
vim.api.nvim_set_keymap('n', '<leader>cf', ':edit $MYVIMRC<CR>', { noremap = true, silent = true })

-- LSP hover keybinding
vim.api.nvim_set_keymap('n', 'P', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})

-- Binding telescope to commands --
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })

-- Keybinds for buffer tabs --
-- These commands will navigate through buffers in order rather than actual tabs
vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', {noremap = true, silent = true})

-- Bind the exit termnal mode to ctrl + n --
vim.api.nvim_set_keymap('t', '<C-n>', '<C-\\><C-n>', { noremap = true })

local remaps = require("remaps")
local plugins = require('plugins')
local themes = require("themes")
