local nSpaceIndent = function(ft, n)
   return function()
      return ft, function(bufnr)
         vim.bo[bufnr].expandtab = true
         vim.bo[bufnr].shiftwidth = n
         vim.bo[bufnr].tabstop = n
         vim.bo[bufnr].softtabstop = n
      end
   end
end

local nTabIndent = function(ft, n)
   return function()
      return ft, function(bufnr)
         vim.bo[bufnr].expandtab = false
         vim.bo[bufnr].shiftwidth = n
         vim.bo[bufnr].tabstop = n
         vim.bo[bufnr].softtabstop = n
      end
   end
end


vim.filetype.add({
   extension = {
      go = nTabIndent("go", 4),
      templ = nTabIndent("templ", 4),
      lua = nSpaceIndent("lua", 3),
      html = nSpaceIndent("html", 2),
      gohtml = nSpaceIndent("html", 2),
      css = nSpaceIndent("css", 2),
      js = nSpaceIndent("javascript", 2),
      ts = nSpaceIndent("typescript", 2),
      json = nSpaceIndent("json", 2),
      xml = nSpaceIndent("xml", 2),
      nix = nSpaceIndent("nix", 2),
      proto = nSpaceIndent("proto", 2),
      tf = nSpaceIndent("tf", 2),
      python = nSpaceIndent("python", 4),
      md = function()
         return "markdown", function(bufnr)
            local winid = vim.api.nvim_get_current_win()
            vim.wo[winid][0].spell = true
            vim.bo[bufnr].textwidth = 78
         end
      end,
   },
})
