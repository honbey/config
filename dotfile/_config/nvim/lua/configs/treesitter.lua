local M = {}
function M.config()
    -- nvim-treesitter config
    require("nvim-treesitter.install").command_extra_args = {
        curl = {"--proxy", "http://127.0.0.1:1080"}
    }
    require "nvim-treesitter.configs".setup {
        -- ensure_installed = "maintained", -- for installing all maintained parsers
        ensure_installed = {
            -- main
            "c",
            "cpp",
            -- script
            "lua",
            "python",
            "javascript",
            -- should learn
            "rust",
            "go",
            -- info security
            "php",
            "java",
            "kotlin",
            -- other
            "hjson",
            "json",
            "json5",
            "toml",
            "xml",
            "yaml",
            "org",
            "markdown",
            "markdown_inline"
        }, -- for installing specific parsers
        sync_install = true, -- install synchronously
        ignore_install = {}, -- parsers to not install
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = {"org"} -- disable standard vim highlighting
        }
    }
end

return M
