local twoSpaceTabs = function(ft)
    return function(_, bufnr)
        return ft, function(bufnr)
            vim.bo[bufnr].expandtab = true
            vim.bo[bufnr].shiftwidth = 2
            vim.bo[bufnr].tabstop = 2
            vim.bo[bufnr].softtabstop = 2
        end
    end
end

vim.filetype.add({
    extension = {
        go = function(_, bufnr)
            return "go", function(bufnr)
                vim.bo[bufnr].expandtab = false
                vim.bo[bufnr].shiftwidth = 4
                vim.bo[bufnr].tabstop = 4
                vim.bo[bufnr].softtabstop = 4
            end
        end,
        templ = function(_, bufnr)
            return "templ", function(bufnr)
                vim.bo[bufnr].expandtab = false
                vim.bo[bufnr].shiftwidth = 4
                vim.bo[bufnr].tabstop = 4
                vim.bo[bufnr].softtabstop = 4
            end
        end,
        html = twoSpaceTabs("html"),
        css = twoSpaceTabs("css"),
        js = twoSpaceTabs("javascript"),
        ts = twoSpaceTabs("typescript"),
        json = twoSpaceTabs("json"),
        xml = twoSpaceTabs("xml"),
        nix = twoSpaceTabs("nix"),
        proto = twoSpaceTabs("proto"),
        tf = twoSpaceTabs("tf"),
        md = function(_, bufnr)
            return "markdown", function(bufnr)
                local winid = vim.api.nvim_get_current_win()
                vim.wo[winid][0].spell = true
                vim.bo[bufnr].textwidth = 78
            end
        end,
    },
})
