local cmp = require('cmp')

cmp.setup({
    preselect = true,
    auto_select = true,
    completion = {completeopt = 'menu,menuone,noinsert'},
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
                treesitter = "[treesitter]",
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
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
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
