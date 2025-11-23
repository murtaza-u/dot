-- mark trailing spaces
vim.cmd([[match IncSearch '\s\+$']])

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
   group = augroup('HighlightYank', {}),
   pattern = '*',
   callback = function()
      vim.highlight.on_yank({
         higroup = 'IncSearch',
         timeout = 40,
      })
   end,
})

autocmd({ "BufWritePre" }, {
   group = augroup('TrimLeadingSpace', {}),
   pattern = "*",
   command = [[%s/\s\+$//e]],
})

autocmd({ "BufReadPost" }, {
   group = augroup('RememberLastPosition', {}),
   pattern = "*",
   command = 'silent! normal! g`"zv',
})
