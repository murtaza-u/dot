local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        selection_caret = ' ',
        prompt_prefix = '  ',
        color_devicons = true,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        -- path_display = { "shorten" },

        vimgrep_arguments = {
            "rg",
            "--hidden",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case"
        },

        file_ignore_patterns = {
            ".class",
            ".git",
            "__pycache__",
            "node_modules",
            "target",
            "lib",
            ".mkv",
            ".png",
            ".jpg",
            ".jpeg",
            ".webp",
            ".pdf",
            ".epub",
            ".mp3",
            ".mp4",
            ".m4a",
            ".opus",
            ".flac",
            ".zip",
        },

        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<esc>"] = actions.close,
                ["<C-q>"] = actions.smart_send_to_qflist,
            },
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}

telescope.load_extension('fzy_native')

local M = {}
M.search_dotfiles = function()
    builtin.find_files({
        prompt_title = "< VimRC >",
        cwd = "$HOME/.config/nvim/",
    })
end

M.git_branches = function()
    builtin.git_branches({
        attach_mappings = function(_, map)
            map("i", "<C-d>", actions.git_delete_branch)
            map("n", "<C-d>", actions.git_delete_branch)
            return true
        end,
    })
end

local map = vim.api.nvim_set_keymap
local props = {noremap = true, silent = true}
map('n', '<C-p>', ':lua require("telescope.builtin").find_files()<CR>', props)
map('n', '<C-g>', ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("grep for > ")})<CR>', props)
map('n', '<leader>b', ':lua require("telescope.builtin").buffers()<CR>', props)
map('n', '<leader>gw', ':lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<CR>', props)
map('n', '<leader>gc', ':lua require("telescope.builtin").git_commits()<CR>', props)
map('n', '<leader>gb', ':lua require("telescope.builtin").git_branches()<CR>', props)
map('n', '<leader>gn', ':lua require("plugins.telescope").search_dotfiles()<CR>', props)

return M
