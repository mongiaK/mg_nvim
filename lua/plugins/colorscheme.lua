return {
    { "tanvirtin/monokai.nvim" },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "monokai",
            --colorscheme = "catppuccin",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
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
            },
        },
    },
}
