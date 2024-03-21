local M = {}

function M.setup() 
  require('nvim-tree').setup {
    -- Update the configuration options as per your requirement
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_tab         = false,
    hijack_cursor       = false,
    update_cwd          = true,
    update_focused_file = {
        enable      = true,
        update_cwd  = true,
        ignore_list = {}
    },
    system_open = {
        cmd  = nil,
        args = {}
    },
    filters = {
        dotfiles = false,
        custom = {}
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
   trash = {
        cmd = "trash",
        require_confirm = true
    }
  }
end

return M

