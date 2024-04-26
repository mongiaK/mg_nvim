local _M = {}

function _M.option()
    return {
        sources = {
            require("null-ls").builtins.formatting.clang_format.with({
                filetypes = { "c", "cpp", "hpp", "cc" },
                extra_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4}" },
            }),
        },
    }
end

return _M
