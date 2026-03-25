return {
   "lewis6991/gitsigns.nvim",
   opts = {
      signs = {
         add = { text = '+' },
         change = { text = '~' },
         delete = { text = '_' },
         topdelete = { text = '‾' },
         changedelete = { text = '~' },
      },
      signs_staged_enable = false,
   },
   keys = {
      { ']n', '<CMD>Gitsigns next_hunk<CR>' },
      { '[p', '<CMD>Gitsigns prev_hunk<CR>' },
   },
   lazy = false,
}
