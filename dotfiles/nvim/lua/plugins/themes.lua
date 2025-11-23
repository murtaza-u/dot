return {
   {
      "miikanissi/modus-themes.nvim",
      priority = 1000,
      lazy = false,
      opts = {
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
      },
   },
   {
      "folke/tokyonight.nvim",
      priority = 1000,
      lazy = false,
      opts = {
         style = "night",
         transparent = false,
         on_highlights = function(hl, c)
            local prompt = c.bg_dark1
            hl.TelescopeNormal = {
               bg = c.bg_dark,
               fg = c.fg_dark,
            }
            hl.TelescopeBorder = {
               bg = c.bg_dark,
               fg = c.bg_dark,
            }
            hl.TelescopePromptNormal = {
               bg = prompt,
            }
            hl.TelescopePromptBorder = {
               bg = prompt,
               fg = prompt,
            }
            hl.TelescopePromptTitle = {
               bg = prompt,
               fg = prompt,
            }
            hl.TelescopePreviewTitle = {
               bg = c.bg_dark,
               fg = c.bg_dark,
            }
            hl.TelescopeResultsTitle = {
               bg = c.bg_dark,
               fg = c.bg_dark,
            }
            hl.TelescopeSelection = {
               bg = c.bg_dark,
               bold = true,
               fg = "white",
            }
         end,
      },
   },
}
