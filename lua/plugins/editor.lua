return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            close_if_last_window = true,
            window = {
                width = 30,
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
    },
    {
        "folke/noice.nvim",
        enabled = false,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            default = {
                mode = { "n", "v" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.default)
        end,
    },
}
