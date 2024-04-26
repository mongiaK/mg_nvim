local keymaps = require("config.keymaps")
local leetbuddy_config = require("plugin_config.leetbuddy")

return {
    {
        "Dhanus3133/LeetBuddy.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = leetbuddy_config.config,
        keys = keymaps.LeetBuddyKeyMaps(),
    }
}
