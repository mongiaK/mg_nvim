local _M = {}

function _M.option()
    return {
        indent = {
            enable = false,
        },
        ensure_installed = {
            "bash",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "tsx",
            "typescript",
            "vim",
            "yaml",
            "make",
            "go",
            "cpp",
            "c",
            "rust"
        },
    }
end

return _M
