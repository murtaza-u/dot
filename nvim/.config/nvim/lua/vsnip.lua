local map = vim.api.nvim_set_keymap
local expr = {expr = true}
map("i", "<C-j>", [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], expr)
map("s", "<C-j>", [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], expr)
map("i", "<C-k>", [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], expr)
map("s", "<C-k>", [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], expr)

vim.g.vsnip_snippet_dir = vim.fn.expand("$HOME") .. "/.config/nvim/snippets"
