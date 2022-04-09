require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        -- disable = {},  -- list of language that will be disabled
    },
    context_commentstring = {
        enable = true,
        config = {css = '// %s'}
    },
    -- autopairs = {enable = true},
    indent = {
        enable = true,
        disable = {"python", "lua", "c", "cpp", "dart"},
    },
    autotag = {
        enable = true,
    },
}
