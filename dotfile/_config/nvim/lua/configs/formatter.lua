local M = {}

function M.config()
    -- Utilities for creating configurations
    local util = require("formatter.util")

    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    require("formatter").setup(
        {
            logging = true,
            log_level = vim.log.levels.WARN,
            -- All formatter configurations are opt-in
            filetype = {
                lua = {
                    require("formatter.filetypes.lua").luafmt
                },
                c = {
                    require("formatter.filetypes.c").clangformat
                },
                cpp = {
                    require("formatter.filetypes.cpp").clangformat
                },
                sh = {
                    require("formatter.filetypes.sh").shfmt
                },
                python = {
                    -- Configuration for black for venv
                    function()
                        return {
                            exe = "/opt/data/pyvenv/work/bin/black", -- this should be available on your $PATH
                            args = {
                                "-q",
                                "--stdin-filename",
                                util.escape_path(util.get_current_buffer_file_name()),
                                "-"
                            },
                            stdin = true
                        }
                    end
                },
                javascript = {
                    require("formatter.filetypes.javascript").prettier
                },
                typescript = {
                    require("formatter.filetypes.typescript").prettier
                },
                typescriptreact = {
                    require("formatter.filetypes.typescriptreact").prettier
                },
                json = {
                    require("formatter.filetypes.json").jq
                },
                rust = {
                    require("formatter.filetypes.rust").rustfmt
                },
                java = {
                    require("formatter.filetypes.java").clangformat
                },
                go = {
                    require("formatter.filetypes.go").gofmt
                },
                ["*"] = {
                    -- "formatter.filetypes.any" defines default configurations for any
                    -- filetype
                    require("formatter.filetypes.any").remove_trailing_whitespace
                }
            }
        }
    )

    -- https://www.cnblogs.com/youngxhui/p/17730419.html
    vim.api.nvim_exec(
        [[
        augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost *.h,*.hpp,*.c,*.cpp,*.lua,*.sh,*.py,*.json,*.js,*.ts FormatWrite
        augroup END
 ]],
        true
    )

    -- https://github.com/mhartington/formatter.nvim
    --local augroup = vim.api.nvim_create_augroup
    --local autocmd = vim.api.nvim_create_autocmd
    --augroup("__formatter__", { clear = true })
    --autocmd("BufWritePost", {
    --    group = "__formatter__",
    --    command = ":FormatWrite",
    --})
end

return M
