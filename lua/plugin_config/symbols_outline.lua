local _M = {}

function _M.config()
    require("symbols-outline").setup({
        relative_width = false,
        width = 30,
    })
end

return _M
