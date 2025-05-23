return {
    "hrsh7th/nvim-cmp",
    enabled = true,
    event = "InsertEnter",
    dependencies = {
        "L3MON4D3/LuaSnip",
        {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup()

                -- insert pair after select function or method item
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                local cmp = require("cmp")
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end,
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
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            auto_select = true,
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            formatting = {
                format = function(entry, item)
                    -- set a name for each source
                    item.menu = ({
                        spell = "[Spell]",
                        buffer = "[Buffer]",
                        calc = "[Calc]",
                        emoji = "[Emoji]",
                        nvim_lsp = "[LSP]",
                        path = "[Path]",
                        look = "[Look]",
                        treesitter = "[Treesitter]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[Latex]",
                    })[entry.source.name]
                    return item
                end
            },
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                })
            }),
            sources = cmp.config.sources({
                { name = "nvim_lua" },
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                { name = "path" },
                { name = "luasnip" },
            })
        })
    end,
}
