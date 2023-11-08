require("monokai-nightasty").setup({
    dark_style_background = "transparent", 
    terminal_colors = true,
    color_headers = true,
    hl_styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
        floats = "default",
        sidebars = "default",
    }, sidebars = { "qf", "help" },
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = true,
    lualine_style = "dark",
    on_colors = function(colors)
        colors.border = colors.grey
    end,
    on_highlights = function(highlights, colors)
        highlights.TelescopeNormal = { fg = colors.magenta, bg = colors.charcoal }
        highlights.WinSeparator = { fg = colors.grey }
    end,
})


-- Theme setup
vim.cmd('colorscheme monokai-nightasty')

