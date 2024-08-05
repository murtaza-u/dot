vim.o.background = "light"

return {
    {
        "miikanissi/modus-themes.nvim",
        lazy = false,
        priority = 1000,
        cond = vim.o.background == "light" and true or false,
        config = function()
            require("modus-themes").setup({
                style = "auto",
                variant = "default",
                transparent = true,
                dim_inactive = false,
                hide_inactive_statusline = true,
                styles = {
                    comments = { italic = true },
                },
                on_highlights = function(highlight, color)
                    highlight.SpellBad = { fg = "#b60000", bold = true }
                    highlight.SpellCap = { fg = "#70480f", bold = true  }
                end,
            })
            vim.cmd([[colorscheme modus]])
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1001 ,
        cond = vim.o.background == "dark" and true or false,
        config = function()
            require("gruvbox").setup({
                invert_selection = true,
                contrast = "hard", -- can be "hard", "soft" or empty string
                dim_inactive = true,
                transparent_mode = true,
                overrides = {
                    SpellBad = { fg = "#fb4934", bold = true },
                    SpellCap = { fg = "#83a598", bold = true  },
                },
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require("custom.treesitter")
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
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
            require("custom.telescope")
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        ft = { "html", "css", "javascript", "templ" },
        opts = {},
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("custom.lsp")
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = {},
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
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                dependencies = {
                    "budimanjojo/k8s-snippets",
                },
                config = function()
                    local map = vim.keymap
                    local opt = { silent = true }
                    local luasnip = require("luasnip")

                    map.set({"i"}, "<C-l>", function()
                        luasnip.expand()
                    end, opt)
                    map.set({"i", "s"}, "<C-j>", function()
                        luasnip.jump(1)
                    end, opt)
                    map.set({"i", "s"}, "<C-k>", function()
                        luasnip.jump(-1)
                    end, opt)
                    map.set({"i", "s"}, "<C-e>", function()
                        if luasnip.choice_active() then
                            luasnip.change_choice(1)
                        end
                    end, opt)

                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            -- cmp sources plugins
            {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-path",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp-signature-help",
            },
        },
        config = function()
            require("custom.cmp")
        end,
    },
}
