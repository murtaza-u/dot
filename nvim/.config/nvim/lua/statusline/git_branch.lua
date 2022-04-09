return function ()
    local color = "%#StatuslineGitBranch#"

    local handle = io.popen("git branch --show-current 2>/dev/null")
    local git_branch = handle:read("*a")
    handle:close()
    git_branch  = string.gsub(git_branch, "%s+", "") -- trim trailing whitespace

    if string.len(git_branch) > 0 then
        git_branch = color .. " " .. git_branch
    end

    return git_branch
end
