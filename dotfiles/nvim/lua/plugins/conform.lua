return {
   'stevearc/conform.nvim',
   opts = {
      format_on_save = {
         -- These options will be passed to conform.format()
         timeout_ms = 500,
         lsp_fallback = true,
      },
      formatters_by_ft = {
         go = { "goimports", "gofumpt" },
         templ = { "templ" },
         nix = { "nixpkgs_fmt" },
         markdown = { "mdformat", "cbfmt" },
         terraform = { "terraform_fmt", "tofu_fmt", stop_after_first = true },
         bash = { "shfmt" },
         sh = { "shfmt" },
         yaml = { "yamlfmt" },
      },
   },
}
