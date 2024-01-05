require("lazy").setup(
    {
        -- theme
        {
            "gzagatti/vim-leuven-theme",
            lazy = false,
            priority = 1000,
            config = function()
                -- edge
                vim.g.edge_style = "aura" -- neon, aura
                vim.g.edge_better_performance = 1
                -- theme
                vim.opt.guicursor = "a:blinkon0-Cursor,i-ci:ver100"
                vim.cmd("set background=light")
                vim.cmd("colorscheme leuven")
            end
        },
        -- starup time optimise
        {
            "dstein64/vim-startuptime",
            cmd = "StartupTime",
            -- init is called during startup. Configuration for vim plugins typically should be set in an init function
            init = function()
                vim.g.startuptime_tries = 10
            end
        },
        -- startup screen
        {
            "goolord/alpha-nvim",
            dependencies = {
                "nvim-tree/nvim-web-devicons",
                lazy = true
            },
            config = function()
                require("alpha").setup(require("alpha.themes.startify").config)
            end
        },
        -- lastplace
        {
            "farmergreg/vim-lastplace" -- replace "ethanholz/nvim-lastplace"
        },
        -- buffer
        {
            "akinsho/bufferline.nvim",
            dependencies = {
                "kyazdani42/nvim-web-devicons",
                lazy = true
            }
        },
        -- file tree
        {
            "kyazdani42/nvim-tree.lua",
            keys = {
                {"<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "NvimTreeToggle"},
                {"<leader>ff", "<cmd>NvimTreeFocus<cr>", desc = "NvimTreeToggle"}
            },
            dependencies = {
                "kyazdani42/nvim-web-devicons",
                lazy = true
            }
        },
        -- language
        "neovim/nvim-lspconfig",
        "nvimdev/lspsaga.nvim",
        "nvim-treesitter/nvim-treesitter",
        {
            "simrat39/symbols-outline.nvim",
            keys = {
                {"<leader>so", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline"}
            }
        },
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline"
            }
        },
        {
            "L3MON4D3/LuaSnip",
            keys = {
                {
                    "<C-l>",
                    function()
                        local ls = require("luasnip")
                        if ls.choice_active() then
                            ls.change_choice(1)
                        end
                    end,
                    mode = {"i", "s"},
                    desc = "Choice next node"
                },
                {
                    "<C-h>",
                    function()
                        local ls = require("luasnip")
                        if ls.choice_active() then
                            ls.change_choice(1)
                        end
                    end,
                    mode = {"i", "s"},
                    desc = "Choice previous node"
                }
            }
        },
        {
            "folke/trouble.nvim",
            dependencies = {
                "nvim-tree/nvim-web-devicons",
                lazy = true
            },
            opts = {}
        },
        {
            "simrat39/rust-tools.nvim",
            ft = "rust",
            config = function()
                require("rust-tools").setup()
                -- vim.keymap.set("n", "<leader>rt", "<cmd>lua require('rust-tools.inlay_hints').toggle_inlay_hints()<cr>")
                -- vim.keymap.set("n", "<leader>rs", "<cmd>lua require('rust-tools.inlay_hints').set_inlay_hints()<cr>")
                -- vim.keymap.set("n", "<leader>rd", "<cmd>lua require('rust-tools.inlay_hints').diable_inlay_hints()<cr>")
            end
        },
        -- formatter
        {
            "mhartington/formatter.nvim",
            event = "BufWrite"
        },
        -- git
        {
            "lewis6991/gitsigns.nvim",
            lazy = false,
            keys = {
                {"<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>"},
                {"<leader>gn", "<cmd>Gitsigns next_hunk<cr>"},
                {"<leader>gc", "<cmd>Gitsigns preview_hunk<cr>"},
                {"<leader>gr", "<cmd>Gitsigns reset_hunk<cr>"},
                {"<leader>gR", "<cmd>Gitsigns reset_buffer"},
                {"<leader>gb", "<cmd>Gitsigns blame_line<cr>"},
                {"<leader>gd", "<cmd>Gitsigns diffthis<cr>"},
                {"<leader>gs", "<cmd>Gitsigns select_hunk<cr>"}
            }
        },
        -- status line
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {
                "kyazdani42/nvim-web-devicons",
                lazy = true
            }
        },
        -- floating terminal
        {
            "akinsho/toggleterm.nvim",
            keys = {
                {"<leader>tt", "<cmd>ToggleTerm direction=tab<cr>"},
                {"<leader>tf", "<cmd>ToggleTerm direction=float<cr>"},
                {"<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>"},
                {"<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>"},
                {"<leader>tn", "<cmd>lua require('toggleterm.terminal').Terminal:new():toggle()<cr>"},
                {"<C-g>", "<C-\\><C-n>", mode = {"t"}}
            }
        },
        -- floating cmd line
        {
            "VonHeikemen/fine-cmdline.nvim",
            dependencies = {
                "MunifTanjim/nui.nvim"
            },
            keys = {
                {"<cr>", "<cmd>FineCmdline<cr>", desc = "Float CLI", noremap = true}
            }
        },
        -- file telescope
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim"
            },
            keys = {
                {"<leader>sf", "<cmd>Telescope find_files<cr>"},
                {"<leader>sg", "<cmd>Telescope git_files<cr>"},
                {"<leader>sb", "<cmd>Telescope buffers<cr>"},
                {"<C-p>", "<cmd>Telescope registers<cr>", mode = {"n", "i"}}
            }
        },
        -- indent guide
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            config = function()
                require("ibl").setup()
            end
        },
        -- ascii image
        {
            "samodostal/image.nvim",
            event = "VeryLazy",
            opts = {}
        },
        -- better ui
        {
            "stevearc/dressing.nvim",
            event = "VeryLazy"
        },
        -- autopairs
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter"
        },
        -- neorg
        {
            "nvim-neorg/neorg",
            build = ":Neorg sync-parsers",
            ft = "norg",
            keys = {
                {"<leader>oo", "<cmd>Neorg workspace<cr>", desc = "Open Neorg workspace"},
                {"<leader>ojj", "<cmd>Neorg journal today<cr>", desc = "Journal of today"},
                {"<leader>ojy", "<cmd>Neorg journal yesterday<cr>", desc = "Journal of yesterday"},
                {"<leader>ojt", "<cmd>Neorg journal tomorrow<cr>", desc = "Journal of tomorrow"},
                {"<leader>oji", "<cmd>Neorg templates journal<cr>", desc = "Generate journal"},
                {
                    "<leader>dc",
                    "<cmd>lua require('neorg').modules.get_module('core.ui.calendar').select_date({})<cr>",
                    desc = "Show calendar",
                    ft = "norg"
                }
            },
            dependencies = {
                {"nvim-lua/plenary.nvim"},
                {"nvim-neorg/neorg-telescope"},
                {"pysan3/neorg-templates", dependencies = {"L3MON4D3/LuaSnip"}},
                {"pritchett/neorg-capture"}
            }
        },
        {
            "lukas-reineke/headlines.nvim",
            dependencies = "nvim-treesitter/nvim-treesitter",
            opts = {}
        },
        {
            "folke/todo-comments.nvim",
            dependencies = {"nvim-lua/plenary.nvim"},
            event = "BufRead",
            config = function()
                require("todo-comments").setup()
            end
        },
        -- zen mode
        {
            "folke/zen-mode.nvim",
            opts = {} -- TODO: config
        }
    }
)
