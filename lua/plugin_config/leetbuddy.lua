local _M = {}

function _M.config()
    require('leetbuddy').setup({
        domain = "cn", -- `cn` for chinese leetcode
        language = "cpp",
    })
end

return _M
