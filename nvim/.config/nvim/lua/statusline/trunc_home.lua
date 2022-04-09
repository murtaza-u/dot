local split = require('statusline.split')

local function trunc_home(path, dir, return_split)
    local USER = vim.fn.expand('$USER')
    local chunks = split(path, '/')
    if chunks == nil then
        return path
    end

    if chunks[1] == dir and chunks[2] == USER then
        table.remove(chunks, 1)
        table.remove(chunks, 1)
        table.insert(chunks, 1, '~')
        if not return_split then return table.concat(chunks, '/') else return chunks end
    else
        if not return_split then return table.concat(chunks, '/') else return chunks end
    end
end

return function (path, return_split)
    if path == nil then
        path = vim.fn.expand("%f")
    end

    return trunc_home(path, 'home', return_split)
end
