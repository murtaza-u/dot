return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
