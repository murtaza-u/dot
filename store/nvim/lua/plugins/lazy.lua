-- bootstrapping lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        "miikanissi/modus-themes.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("modus-themes").setup({
                style = "auto", -- "modus_operandi", "modus_vivendi", "auto"
                variant = "default", -- "default", "tinted", "deuteranopia", and "tritanopia"
                transparent = true, -- transparent background (as supported by the terminal)
                dim_inactive = false, -- "non-current" windows are dimmed
                hide_inactive_statusline = false, -- hide statuslines on inactive windows
                on_highlights = function(hl, c)
                    hl.SpellBad = { fg = "#b60000", bold = true }
                    hl.SpellCap = { fg = "#70480f", bold = true  }
                    hl.IblIndent = { fg = "#dadada", nocombine = true  }
                    hl.String = { fg = c.green_cooler }
                end,
            })
            vim.cmd.colorscheme("modus")
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'vrischmann/tree-sitter-templ',
        },
        config = function()
            require("plugins.treesitter")
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        keys = {
            { '<C-p>', '<CMD>Telescope find_files<CR>' },
            { '<C-g>', '<CMD>Telescope live_grep<CR>' },
            { '<leader>f', '<CMD>Telescope git_files<CR>' },
            { '<leader>b', '<CMD>Telescope buffers<CR>' },
            { '<leader>D', '<CMD>Telescope diagnostics<CR>' },
            { '<leader>d', '<CMD>lua require("telescope.builtin").diagnostics({ bufnr=0 })<CR>' },
        },
        config = function()
            require("plugins.telescope")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "windwp/nvim-autopairs",
                config = function()
                    require("plugins.autopairs")
                end,
            },
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
            },
            { -- cmp sources plugins
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-path",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp-signature-help",
            },
        },
        config = function()
            require("plugins.cmp")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lsp")
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { 'gs', '<CMD>Neogit<CR>' },
        },
        config = true,
    },
    {
        'stevearc/conform.nvim',
        config = function()
            require("conform").setup({
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
                formatters_by_ft = {
                    go = { "gofmt" },
                    templ = { "templ" },
                    nix = { "nixpkgs-fmt" },
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                    typescript = { "prettierd", "prettier", stop_after_first = true },
                    html = { "prettierd", "prettier", stop_after_first = true },
                    css = { "prettierd", "prettier", stop_after_first = true },
                },
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("plugins.indent-blankline")
        end,
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
    {
        'norcalli/nvim-colorizer.lua',
        ft = { "html", "css", "javascript", "templ", "yaml", "nix", "lua" },
        opts = {},
    },
    "tpope/vim-surround",
    "hashivim/vim-terraform",
})
