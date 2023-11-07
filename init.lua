-- Define the leader
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
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

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
  use 'preservim/tagbar' -- Tagbar plugin
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
-- First, we require the necessary modules
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

vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight NvimTreeNormal guibg=NONE ctermbg=NONE
  highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
]]

-- Set default tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Convert tabs to spaces


-- Set the theme for airline statusbar --
vim.cmd('let g:airline_theme="dark"')

-- Set the file underline color to white 
vim.api.nvim_set_hl(0, 'CursorLine', {underline = true, sp = 'white'})

-- The settings for the nivm-tree icons --
require'nvim-web-devicons'.setup {
  color_icons = true,
  default = true,
  strict = true,
}

vim.cmd [[
  filetype plugin indent on
  syntax enable
]]

-- Auto-detect fold method based on filetype
vim.api.nvim_create_autocmd("FileType", {  
  pattern = "*",
  callback = function()
    local syntax = vim.api.nvim_buf_get_option(0, 'syntax')
    if syntax and vim.fn.exists('b:current_syntax') then
      vim.wo.foldmethod = 'syntax'
    else
      vim.wo.foldmethod = 'indent' -- Or 'expr' if you have a custom fold expression
    end
  end
})

-- General settings for folds
vim.opt.foldenable = true -- Enable folding
vim.opt.foldlevelstart = 99 -- Start with all folds open
vim.opt.foldnestmax = 10 -- Deepest fold is 10 levels
vim.opt.foldminlines = 1 -- Minimum lines for a fold is 1

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
vim.cmd('command! ExploreT NvimTreeToggle')

-- LSP hover keybinding
vim.api.nvim_set_keymap('n', 'P', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
-- Binding telescope to commands --
vim.cmd [[
  command! FindFiles Telescope find_files
  command! LiveGrep Telescope live_grep
  command! Buffers Telescope buffers
  command! HelpTags Telescope help_tags
]]

-- Keybinds for buffer tabs --
-- These commands will navigate through buffers in order rather than actual tabs
vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', {noremap = true, silent = true})

-- Bind the exit termnal mode to ctrl + n --
vim.api.nvim_set_keymap('t', '<C-n>', '<C-\\><C-n>', { noremap = true })

local plugins = require('plugins')
local themes = require("themes")
