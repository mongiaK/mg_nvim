local neotree_config = require("plugin_config.neotree")

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = neotree_config.option()
    },
    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
    },
    {
        "folke/noice.nvim",
        enabled = true,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
}
