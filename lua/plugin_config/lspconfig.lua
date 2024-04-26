local _M = {}

function _M.option()
    return {
        setup = {
            clangd = function(_, opts)
                opts.capabilities.offsetEncoding = { "utf-16" }
            end
        },
    }
end

function _M.config()

end

return _M
