local treesitter_config = require("plugin_config.treesitter")
-- local lazyvim_config = require("plugin_config.lazyvim")

return {
    {
        "tanvirtin/monokai.nvim"
    },
    {
        "LazyVim/LazyVim",
        -- opts = lazyvim_config.option()
    },
    {
        "nvim-treesitter/nvim-treesitter",
        enable = true,
        opts = treesitter_config.option()
    },
}
