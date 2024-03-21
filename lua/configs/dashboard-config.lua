local M = {}

function M.setup()
    -- Create an autocommand group for Alpha dashboard specific settings
    vim.api.nvim_create_augroup("AlphaDashboard", {clear = true})

    -- Disable indentation lines when the Alpha dashboard is open
    vim.api.nvim_create_autocmd(
        "FileType",
        {
            group = "AlphaDashboard",
            pattern = "alpha",
            callback = function()
                vim.g.indentLine_enabled = 0
                vim.cmd("IndentLinesDisable")
            end
        }
    )

    -- Re-enable indentation lines when entering a buffer that is not the Alpha dashboard
    vim.api.nvim_create_autocmd(
        "BufEnter",
        {
            group = "AlphaDashboard",
            pattern = "*",
            callback = function()
                if vim.bo.filetype ~= "alpha" then
                    vim.g.indentLine_enabled = 1
                    vim.cmd("IndentLinesEnable")
                end
            end
        }
    )

    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    -- VimJu ASCII Art
    local ascii_art = {
        [[            /\]],
        [[/vvvvvvvvvvvv \--------------------------------------,]],
        [[`^^^^^^^^^^^^ /====================================="]],
        [[            \/                 _____               ]],
        [[  /\ \/\ \   __               /\___ \              ]],
        [[  \ \ \ \ \ /\_\     ___ ___  \/__/\ \   __  __    ]],
        [[   \ \ \ \ \\/\ \  /' __` __`\   _\ \ \ /\ \/\ \   ]],
        [[    \ \ \_/ \\ \ \ /\ \/\ \/\ \ /\ \_\ \\ \ \_\ \  ]],
        [[     \ `\___/ \ \_\\ \_\ \_\ \_\\ \____/ \ \____/  ]],
        [[      `\/__/   \/_/ \/_/\/_/\/_/ \/___/   \/___/   ]],
        [[]],
        [[]],
        [[]],
        [[]]
    }

    local header = {
        type = "text",
        val = ascii_art,
        opts = {
            position = "center",
            hl = "Number"
        }
    }

    -- Import the button function from the new settings
    local function button(sc, txt, keybind, keybind_opts)
        local if_nil = vim.F.if_nil
        local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
        local opts = {
            position = "center",
            shortcut = sc,
            cursor = 5,
            width = 36,
            align_shortcut = "right",
            hl_shortcut = "Keyword"
        }
        if keybind then
            keybind_opts = if_nil(keybind_opts, {noremap = true, silent = true, nowait = true})
            opts.keymap = {"n", sc_, keybind, keybind_opts}
        end

        local function on_press()
            local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
            vim.api.nvim_feedkeys(key, "t", false)
        end

        return {
            type = "button",
            val = txt,
            on_press = on_press,
            opts = opts
        }
    end

    -- New buttons using the imported function
    local new_buttons = {
        type = "group",
        val = {
            button("e", "  New file", "<cmd>ene <CR>"),
            button("SPC f f", "󰈞  Find file"),
            button("SPC f h", "󰊄  Recently opened files"),
            button("SPC f r", "  Frecency/MRU"),
            button("SPC f g", "󰈬  Find word"),
            button("SPC f m", "  Jump to bookmarks"),
            button("SPC s l", "  Open last session")
        },
        opts = {
            spacing = 1,
            hl = "Function"
        }
    }

    -- Footer
    local footer = {
        type = "text",
        val = "Welcome to VimJu",
        opts = {
            position = "center",
            hl = "Number"
        }
    }

    -- Set header, buttons, and footer
    dashboard.section.header = header
    dashboard.section.buttons = new_buttons
    dashboard.section.footer = footer

    -- Layout
    dashboard.config.layout = {
        {type = "padding", val = 2},
        header,
        {type = "padding", val = 1},
        new_buttons,
        {type = "padding", val = 1},
        footer
    }

    -- Set the dashboard config to alpha
    alpha.setup(dashboard.config)
end

return M

