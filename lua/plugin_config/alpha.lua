local _M = {}

function _M.option()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
███╗   ███╗ ██████╗ ███╗   ██╗ ██████╗ ██╗ █████╗
████╗ ████║██╔═══██╗████╗  ██║██╔════╝ ██║██╔══██╗
██╔████╔██║██║   ██║██╔██╗ ██║██║  ███╗██║███████║
██║╚██╔╝██║██║   ██║██║╚██╗██║██║   ██║██║██╔══██║
██║ ╚═╝ ██║╚██████╔╝██║ ╚████║╚██████╔╝██║██║  ██║
╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝  ╚═╝
      ]]
    dashboard.section.header.val = vim.split(logo, "\n")
    return dashboard
end

return _M
