local alpha_config = require("plugin_config.alpha")

return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = alpha_config.option()
    },
    {
        "kassio/neoterm",
        lazy = true,
    }
}
