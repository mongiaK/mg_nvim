local alpha_config = require("plugin_config.alpha")
local keymaps = require("config.keymaps")
return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = alpha_config.option()
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true,
        keys = keymaps.ToggleTermKeyMaps()
    }
}
