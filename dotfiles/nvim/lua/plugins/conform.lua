return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    opts = {
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            go = { "gofmt" },
            templ = { "templ" },
            nix = { "nixpkgs_fmt" },
            markdown = { "mdformat", "cbfmt" },
            terraform = { "terraform_fmt" },
            bash = { "shfmt" },
            sh = { "shfmt" },
            yaml = { "yamlfmt" },
        },
    },
}
