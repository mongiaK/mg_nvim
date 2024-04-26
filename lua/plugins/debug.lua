local dap_config = require("plugin_config.dap")

return {
    -- 调试插件
    {
        "mfussenegger/nvim-dap",
        config = dap_config.config
    }

}
