require("neorg").setup(
    {
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.dirman"] = {
                -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        main = "~/neorg",
                        work = "~/neorg/work",
                        home = "~/neorg/home",
                        journal = "~/neorg/journal",
                        archive = "~/neorg/archive"
                    },
                    default_workspace = "main"
                }
            },
            ["core.export"] = {
                config = {export_dir = "~/neorg/export"}
            },
            ["core.export.markdown"] = {
                config = {extension = "md", extensions = "all"}
            },
            ["core.presenter"] = {
                config = {zen_mode = "zen-mode"}
            },
            ["core.summary"] = {},
            ["core.mode"] = {},
            ["core.manoeuvre"] = {},
            ["core.ui"] = {},
            ["core.ui.calendar"] = {},
            ["core.integrations.telescope"] = {},
            ["core.integrations.nvim-cmp"] = {},
            ["core.queries.native"] = {},
            ["core.completion"] = {config = {engine = "nvim-cmp", name = "[Norg]"}},
            ["core.journal"] = {
                config = {strategy = "nested"}
            },
            ["external.templates"] = {
                config = {
                    keywords = {
                        CITY = function()
                            local ls = require("luasnip")
                            local t = ls.text_node
                            return ls.choice_node(1, {t("Changsha 󰨶"), t("Hengyang "), t("Shenzhen 󰅆")})
                        end,
                        WEATHER = function()
                            local ls = require("luasnip")
                            local t = ls.text_node
                            return ls.choice_node(
                                1,
                                {
                                    t("Sunny "),
                                    t("Cloudy "),
                                    t("Rainy "),
                                    t("Showers "),
                                    t("Snow ")
                                }
                            )
                        end,
                        TODAY_NORG = function()
                            local ls = require("luasnip")
                            local s = require("neorg.modules.external.templates.default_snippets")
                            return ls.text_node(s.parse_date(0, s.file_tree_date(), [[%a, %d %b %Y]]))
                        end,
                        TODAY_OF_FILETREE_NEST = function()
                            local ls = require("luasnip")
                            local s = require("neorg.modules.external.templates.default_snippets")
                            return ls.text_node(s.parse_date(0, s.file_tree_date(), [[../../%Y/%m/%d]]))
                        end,
                        YESTERDAY_OF_FILETREE_NEST = function()
                            local ls = require("luasnip")
                            local s = require("neorg.modules.external.templates.default_snippets")
                            return ls.text_node(s.parse_date(-1, s.file_tree_date(), [[../../%Y/%m/%d]]))
                        end,
                        TOMORROW_OF_FILETREE_NEST = function()
                            local ls = require("luasnip")
                            local s = require("neorg.modules.external.templates.default_snippets")
                            return ls.text_node(s.parse_date(1, s.file_tree_date(), [[../../%Y/%m/%d]]))
                        end
                    }
                }
            },
            ["external.capture"] = {
                config = {
                    templates = {
                        {
                            description = "Add TODO items",
                            name = "TODO",
                            file = "~/neorg/refile",
                            enable = true,
                            datetree = true,
                            headline = "TODO"
                            -- path = {"A", "B"},
                            -- query = "(headline1) @neorg-capture-target",
                        }
                    }
                }
            }
        }
    }
)

vim.opt.conceallevel = 2
