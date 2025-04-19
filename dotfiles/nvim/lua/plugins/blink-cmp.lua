return {
    "saghen/blink.cmp",
    enabled = false,
    dependencies = { 'L3MON4D3/LuaSnip' },
    version = '1.*',
    opts = {
        keymap = { preset = 'enter' },
        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },

        completion = {
            -- (Default) Only show the documentation popup when manually triggered
            documentation = { auto_show = false },
            -- 'prefix' will fuzzy match on the text before the cursor
            -- 'full' will fuzzy match on the text before _and_ after the cursor
            keyword = { range = 'full' },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = {
                'lsp',
                'path',
                'snippets',
                -- 'buffer',
            },
        },

        -- Experimental signature help support
        signature = { enabled = true }
    },
    opts_extend = { "sources.default" },
}
