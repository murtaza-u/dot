return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        }
    },
    keys = {
        { '<C-p>',     '<CMD>Telescope find_files<CR>' },
        { '<C-g>',     '<CMD>Telescope live_grep<CR>' },
        { '<leader>f', '<CMD>Telescope git_files<CR>' },
        { '<leader>b', '<CMD>Telescope buffers<CR>' },
        { '<leader>D', '<CMD>Telescope diagnostics<CR>' },
        { '<leader>d', '<CMD>lua require("telescope.builtin").diagnostics({ bufnr=0 })<CR>' },
    },
    config = function()
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
    end,
}
