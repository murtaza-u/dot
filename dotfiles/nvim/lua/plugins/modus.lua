return {
    "miikanissi/modus-themes.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        require("modus-themes").setup({
            style = "auto",                   -- "modus_operandi", "modus_vivendi", "auto"
            variant = "default",              -- "default", "tinted", "deuteranopia", and "tritanopia"
            transparent = true,               -- transparent background (as supported by the terminal)
            dim_inactive = false,             -- "non-current" windows are dimmed
            hide_inactive_statusline = false, -- hide statuslines on inactive windows
            on_highlights = function(hl, c)
                hl.SpellBad = { fg = "#b60000", bold = true }
                hl.SpellCap = { fg = "#70480f", bold = true }
                hl.IblIndent = { fg = "#dadada", nocombine = true }
                hl.String = { fg = c.green_cooler }
            end,
        })
        vim.cmd.colorscheme("modus")
    end,
}
