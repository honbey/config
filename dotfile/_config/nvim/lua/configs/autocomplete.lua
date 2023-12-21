local M = {}

function M.config()
    -- Setup nvim-cmp.
    -- https://github.com/hrsh7th/nvim-cmp
    local cmp = require("cmp")
    cmp.setup(
        {
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- luasnip
                    require("luasnip").lsp_expand(args.body)
                    -- vsnip
                    -- vim.fn["vsnip#anonymous"](args.body)
                    -- snippy
                    -- require('snippy').expand_snippet(args.body)
                    -- ultisnip
                    -- vim.fn["UltiSnips#Anon"](args.body)
                end
            },
            mapping = {
                ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
                ["<C-y>"] = cmp.config.disable,
                ["<C-e>"] = cmp.mapping(
                    {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close()
                    }
                ),
                -- Accept currently selected item...
                -- Set `select` to `false` to only confirm explicitly selected items:
                ["<CR>"] = cmp.mapping.confirm({select = true})
            },
            sources = cmp.config.sources(
                {
                    {name = "nvim_lsp"}
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                },
                {{name = "buffer"}}
            )
        }
    )

    -- You can also set special config for specific filetypes:
    --    cmp.setup.filetype('gitcommit', {
    --        sources = cmp.config.sources({
    --            { name = 'cmp_git' },
    --        }, {
    --            { name = 'buffer' },
    --        })
    --    })

    -- nvim-cmp for commands
    cmp.setup.cmdline(
        "/",
        {
            sources = {
                {name = "buffer"}
            }
        }
    )
    cmp.setup.cmdline(
        ":",
        {
            sources = cmp.config.sources(
                {
                    {name = "path"}
                },
                {
                    {name = "cmdline"}
                }
            )
        }
    )

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")

    cmp.setup(
        {
            mapping = {
                ["<C-n>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),
                ["<C-p>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),
                ["<TAB>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),
                ["<S-TAB>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                )

                -- ... Your other mappings ...
            }

            -- ... Your other configuration ...
        }
    )

    -- autopairs
    -- Reference: https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/autopairs.lua
    local status_ok, npairs = pcall(require, "nvim-autopairs")
    if not status_ok then
        return
    end

    npairs.setup {
        check_ts = true,
        ts_config = {
            lua = {"string", "source"},
            javascript = {"string", "template_string"},
            java = false
        },
        disable_filetype = {"TelescopePrompt", "spectre_panel"},
        fast_wrap = {
            map = "<M-e>",
            chars = {"{", "[", "(", '"', "'"},
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr"
        }
    }

    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {map_char = {tex = ""}})

    -- nvim-lspconfig config
    -- List of all pre-configured LSP servers:
    -- github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    -- local opts = { noremap=true, silent=true }
    -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = {noremap = true, silent = true, buffer = bufnr}
        -- k: general
        -- l: lsp
        -- s: workspace
        vim.keymap.set("n", "<leader>ks", ":Lspsaga show_line_diagnostics<cr>")
        vim.keymap.set("n", "<leader>kS", ":Lspsaga show_cursor_diagnostics<cr>")
        vim.keymap.set("n", "<leader>kd", ":Lspsaga preview_definition<cr>")
        vim.keymap.set("n", "<leader>kR", ":Lspsaga rename<cr>")
        vim.keymap.set("n", "<leader>kc", ":Lspsaga code_action<cr>")
        vim.keymap.set("n", "<leader>kl", ":Lspsaga lsp_finder<cr>")
        vim.keymap.set("n", "<leader>kp", ":Lspsaga diagnostic_jump_prev<cr>")
        vim.keymap.set("n", "<leader>kn", ":Lspsaga diagnostic_jump_next<cr>")
        vim.keymap.set("n", "<leader>ko", ":SymbolsOutline<cr>")

        vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, bufopts)
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<leader>lc", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.formatting, bufopts)
        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "<leader>lD", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, bufopts)

        vim.keymap.set("n", "<leader>sa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<leader>sr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set(
            "n",
            "<leader>sl",
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            bufopts
        )

        vim.keymap.set(
            "n",
            "<leader>rt",
            function()
                require("rust-tools.inlay_hints").toggle_inlay_hints()
            end
        )
        vim.keymap.set(
            "n",
            "<leader>rs",
            function()
                require("rust-tools.inlay_hints").set_inlay_hints()
            end
        )
        vim.keymap.set(
            "n",
            "<leader>rd",
            function()
                require("rust-tools.inlay_hints").diable_inlay_hints()
            end
        )
    end

    require "lspconfig".gopls.setup {}
    local servers = {
        "clangd",
        "pyright",
        "lua_ls",
        "bashls",
        "tsserver",
        "rust_analyzer",
        "jdtls"
    }
    for _, lsp in pairs(servers) do
        require("lspconfig")[lsp].setup {}
    end
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

    -- TypeScript / JavaScript: vscode-langservers-extracted / ts-language-server

    local devicons = require("nvim-web-devicons")
    cmp.register_source(
        "devicons",
        {
            complete = function(_, _, callback)
                local items = {}
                for _, icon in pairs(devicons.get_icons()) do
                    table.insert(
                        items,
                        {
                            label = icon.icon .. "  " .. icon.name,
                            insertText = icon.icon,
                            filterText = icon.name
                        }
                    )
                end
                callback({items = items})
            end
        }
    )

    -- change the lsp symbol kind
    --local kind = require('lspsaga.lspkind')
    --kind[type_number][2] = icon -- see lua/lspsaga/lspkind.lua

    -- use default config

    require("rust-tools").setup()
end

return M
