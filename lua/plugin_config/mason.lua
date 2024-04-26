local _M = {}

function _M.option()
    return {
        ensure_installed = {
            "stylua",
            "codelldb",
            "shfmt",
            "delve",
            "clangd",
            "debugpy",
            "gopls"
        },
    }
end

function _M.config()

end

return _M
