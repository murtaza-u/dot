return {
   "lukas-reineke/indent-blankline.nvim",
   main = "ibl",
   config = function()
      ---@module "ibl"
      ---@type ibl.config
      require("ibl").setup({
         indent = {
            char = "│",
            highlight = "IblIndent",
         },
         scope = {
            show_start = false,
            show_end = false,
         },
      })

      -- disable indentation on the first level
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
   end,
}
