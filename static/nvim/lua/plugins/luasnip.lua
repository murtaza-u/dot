local map = vim.keymap
local opt = { silent = true }
local luasnip = require("luasnip")

-- map.set({"i"}, "<C-l>", function() luasnip.expand() end, opt)
-- map.set({"i", "s"}, "<C-j>", function() luasnip.jump(1) end, opt)
-- map.set({"i", "s"}, "<C-k>", function() luasnip.jump(-1) end, opt)
-- map.set({"i", "s"}, "<C-e>", function()
--     if luasnip.choice_active() then
--         luasnip.change_choice(1)
--     end
-- end, opt)

require("luasnip.loaders.from_vscode").lazy_load()
