return {
   "NeogitOrg/neogit",
   dependencies = {
      "nvim-lua/plenary.nvim",
      {
         "sindrets/diffview.nvim",
         opts = {
            use_icons = false,
            view = {
               merge_tool = {
                  layout = "diff3_mixed",
                  disable_diagnostics = false,
                  winbar_info = false,
               },
            },
            hooks = {
               view_opened = function()
                  require("diffview.actions").toggle_files()
               end,
            },
         }
      },
   },
   keys = {
      { 'gs', '<CMD>Neogit<CR>' },
   },
   config = true,
}
