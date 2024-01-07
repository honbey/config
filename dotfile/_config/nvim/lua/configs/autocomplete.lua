local M = {}

function M.config()
    vim.opt.completeopt = {"menu", "menuone", "noselect"}
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Setup nvim-cmp. https://github.com/hrsh7th/nvim-cmp
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local has_words_before = function()
        if table.unpack then
            unpack = table.unpack
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup(
        {
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- luasnip
                    luasnip.lsp_expand(args.body)
                    -- vsnip
                    -- vim.fn["vsnip#anonymous"](args.body)
                    -- snippy
                    -- require('snippy').expand_snippet(args.body)
                    -- ultisnip
                    -- vim.fn["UltiSnips#Anon"](args.body)
                end
            },
            sources = {
                {name = "buffer"},
                {name = "luasnip"},
                {name = "nvim_lsp"},
                {name = "path"}
            },
            formatting = {
                fields = {"menu", "abbr", "kind"},
                format = function(entry, item)
                    local menu_icon = {
                        buffer = "ß",
                        luasnip = "»",
                        neorg = "∂",
                        nvim_lsp = "λ",
                        path = "˜"
                    }

                    item.menu = menu_icon[entry.source.name]
                    return item
                end
            },
            mapping = {
                ["<CR>"] = cmp.mapping.confirm({select = false}),
                ["<C-m>"] = cmp.mapping.confirm({select = true}),
                ["<C-y>"] = cmp.config.disable,
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
                ["<C-e>"] = cmp.mapping(
                    {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close()
                    }
                ),
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
            },
            window = {
                documentation = cmp.config.window.bordered()
            }
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
    cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})
    cmp.setup.cmdline(":", {sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})})

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

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {map_char = {tex = ""}})

    -- web-devicons
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
end

return M
