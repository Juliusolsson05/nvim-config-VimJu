-- Set leader key to spacebar
vim.g.mapleader = " "

-- Auto-install packer if it's not installed
local function bootstrap_packer()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd 'packadd packer.nvim'
  end
end
bootstrap_packer()

-- Plugin configuration
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  -- use 'rafi/awesome-vim-colorschemes'
  -- Themes
  use 'polirritmico/monokai-nightasty.nvim'
  use 'folke/tokyonight.nvim'
  use 'shaunsingh/nord.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'

use {
  'kyazdani42/nvim-web-devicons',
  config = function() require'nvim-web-devicons'.setup() end
}

  -- Comment.nvim
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }



  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('lualine').setup() end
  }

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  -- Smooth scrolling
  use 'karb94/neoscroll.nvim'

  -- Key mappings helper
  use 'folke/which-key.nvim'

  -- Flash navigation
  use 'folke/flash.nvim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = require('configs.treesitter-config').setup
  }
  -- Mason
  use {
    'williamboman/mason.nvim',
    config = require('configs.mason-config').setup
  }
  use 'williamboman/mason-lspconfig.nvim'
  use 'goolord/alpha-nvim'
  -- Other plugins
  use 'preservim/tagbar'
  use 'petertriho/nvim-scrollbar'
  use 'vim-scripts/RltvNmbr.vim'
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use 'tpope/vim-fugitive'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'justinmk/vim-sneak'
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }
  use 'windwp/nvim-autopairs'
  use 'Yggdroot/indentLine'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = require('configs.nvim-tree-config').setup
  }
end)

-- LSP and completion configuration
require('configs.lsp-config').setup()
require('configs.completion-config').setup()

require("configs.telescope-themes-config").setup()

require("configs.dashboard-config").setup()

-- General Neovim settings
require('configs.settings').setup()

-- Keybindings
require('configs.keybindings').setup()

-- All custom written plugins along with theme configuration
local plugins = require('plugins')
local themes = require("themes")

