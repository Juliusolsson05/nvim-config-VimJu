local M = {}

-- Define the functions at module scope
local function add_lines_above()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, {"", "", "", "", ""})
    vim.api.nvim_win_set_cursor(0, {current_line + 2, 0})
end

local function add_lines_below()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, current_line, current_line, false, {"", "", "", "", ""})
    vim.api.nvim_win_set_cursor(0, {current_line + 3, 0})
end

function M.setup()
    -- Keybindings
    local map = vim.api.nvim_set_keymap
    local opts = {noremap = true, silent = true}
    local flash = require("flash")
    -- NvimTree
    map("n", "<leader>r", ":NvimTreeToggle<CR>", opts)

    -- LSP hover documentation
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

    -- LSP signature help
    map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- Config file
    map("n", "<leader>cf", ":edit $MYVIMRC<CR>", opts)

    -- LSP
    map("n", "<leader>P", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

    -- Flash
    vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>lua require('flash').treesitter()<CR>", {noremap = true})

    -- Set up a keybinding to open the yank history menu
    vim.api.nvim_set_keymap("n", "<leader>y", ":Telescope yank_history<CR>", { noremap = true, silent = true })

    -- Telescope
    map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
    map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
    map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
    map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)


    -- Buffer navigation
    map("n", "<TAB>", ":BufferNext<CR>", opts)
    map("n", "<S-TAB>", ":BufferPrevious<CR>", opts)

    -- Terminal escape
    map("t", "<C-n>", "<C-\\><C-n>", opts)

    -- :Cursor command to toggle cursoer line help.
    function M.toggle_cursor()
        local cl = vim.wo.cursorline
        local cc = vim.wo.cursorcolumn
        vim.wo.cursorline = not cl
        vim.wo.cursorcolumn = not cc
    end

    -- Declaring the command for :Cursor
    vim.api.nvim_create_user_command("Cursor", M.toggle_cursor, {})

    -- Keybindings for custom functions
    map("n", "<leader>a", '<cmd>lua require("configs.keybindings").add_lines_above()<CR>', opts)
    map("n", "<leader>f", '<cmd>lua require("configs.keybindings").add_lines_below()<CR>', opts)

    -- Define custom command "Find" that opens Telescope find_files
    vim.api.nvim_create_user_command(
        "Find",
        function()
            require("telescope.builtin").find_files()
        end,
        {desc = "Open Telescope to find files"}
    )
end

-- Make the functions accessible outside the module
M.add_lines_above = add_lines_above
M.add_lines_below = add_lines_below

return M

