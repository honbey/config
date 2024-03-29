local M = {}

function M.config()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    alpha.setup(dashboard.opts)
    -- Disable folding on alpha buffer:
    vim.cmd("autocmd FileType alpha setlocal nofoldenable")
end

return M
