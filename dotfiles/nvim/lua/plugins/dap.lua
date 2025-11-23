return {
   {
      "mfussenegger/nvim-dap"
   },
   {
      "leoluz/nvim-dap-go",
      dependencies = {
         "mfussenegger/nvim-dap",
      },
      ft = "go",
      config = true,
   }
}
