local M = {}

function M.setup()
    -- General settings
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.ignorecase = true
    vim.opt.number = true
    vim.opt.relativenumber = true
    -- Enable indentation lines by default
    vim.g.indentLine_enabled = 1

    vim.g.nvim_tree_ignore = {".git", "node_modules", ".cache"} -- List of folders to hide
    vim.g.nvim_tree_gitignore = 0 -- 0: Show git ignored files, 1: Hide them
    vim.g.nvim_tree_show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1
    }

    require "nvim-tree".setup {
        -- other setup
        filters = {
            dotfiles = false -- this will show hidden files
        }
    }

    vim.api.nvim_command("hi Nordwebb guifg=#0D1D40 gui=bold")

    -- Highlighting on yank
    vim.cmd [[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
    augroup END
  ]]

    -- Highlighting settings
    vim.cmd [[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight NvimTreeNormal guibg=NONE ctermbg=NONE
    highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
    highlight LineNr guifg=#03ecfc
    highlight Visual guibg=#265f6e 
  ]]

    -- Search settings
    vim.cmd [[
    cnoreabbrev <expr> s getcmdtype() == ':' && getcmdline() == 's' ? '%s' : 's'
  ]]
end

return M

