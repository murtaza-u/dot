local actions = require("telescope.actions")

require('telescope').setup({
    defaults = {
        prompt_prefix = "➤ ",
        selection_caret = "➥ ",
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<esc>"] = actions.close,
                ["<C-q>"] = actions.send_to_qflist,
            }
        },
        layout_config = {
            preview_width = 0.6,
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        }
    }
})

-- load fzf native extension, if installed
pcall(require('telescope').load_extension('fzf'))
