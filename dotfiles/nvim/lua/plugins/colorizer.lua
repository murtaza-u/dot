vim.opt.termguicolors = true

return {
   'norcalli/nvim-colorizer.lua',
   config = function()
      require('colorizer').setup()
   end,
}
