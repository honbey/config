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
                vim.cmd("set background=light")
                vim.cmd("colorscheme leuven")
            end
        },
        -- starup time optimise
        "lewis6991/impatient.nvim",
        "nathom/filetype.nvim",
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
                require "alpha".setup(require "alpha.themes.startify".config)
            end
        },
        -- lastplace
        -- "ethanholz/nvim-lastplace",
        {
            "farmergreg/vim-lastplace"
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
            dependencies = {
                "kyazdani42/nvim-web-devicons",
                lazy = true
            }
        },
        -- language
        "neovim/nvim-lspconfig",
        "glepnir/lspsaga.nvim",
        "nvim-treesitter/nvim-treesitter",
        "simrat39/symbols-outline.nvim",
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
            ft = "lua"
        },
        {
            "simrat39/rust-tools.nvim",
            ft = "rust"
        },
        -- formatter
        {
            "mhartington/formatter.nvim",
            event = "BufWrite"
        },
        -- git
        {
            "lewis6991/gitsigns.nvim"
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
            lazy = true
        },
        -- file telescope
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim"
            }
        },
        -- indent guide
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl"
        },
        -- ascii image
        -- TODO: https://github.com/3rd/image.nvim
        {
            "samodostal/image.nvim",
            event = "VeryLazy"
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
            dependencies = {
                "nvim-lua/plenary.nvim"
            }
        },
        {
            "lukas-reineke/headlines.nvim",
            dependencies = "nvim-treesitter/nvim-treesitter",
            config = true -- or `opts = {}`
        },
        -- fold/unfold
        {
            "Wansmer/treesj",
            keys = {
                "<leader>j"
            },
            opts = {
                use_default_keymaps = false,
                max_join_length = 150
            }
        }

        -- TODO: add below plugins
        -- michaelb/sniprun
        -- monaqa/dial.nvim
        -- folke/noice.nvim
        -- dhruvasagar/vim-table-mode
    }
)
