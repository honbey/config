require("lazy").setup({

  -- starup time optimise
  "dstein64/vim-startuptime",
  "lewis6991/impatient.nvim",
  "nathom/filetype.nvim",

  -- buffer
  {
    "akinsho/bufferline.nvim", dependencies = {
      "kyazdani42/nvim-web-devicons",
    }
  },
  "moll/vim-bbye", -- for more sensible delete buffer cmd

  -- theme
  "gzagatti/vim-leuven-theme",

  -- file tree
  {
    "kyazdani42/nvim-tree.lua", dependencies = {
      "kyazdani42/nvim-web-devicons",
    }
  },

  -- language
  "neovim/nvim-lspconfig",
	"glepnir/lspsaga.nvim",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"nvim-treesitter/nvim-treesitter",
	"simrat39/rust-tools.nvim",
	"simrat39/symbols-outline.nvim",
  
  -- git
  "lewis6991/gitsigns.nvim",

  -- status line
  {
    "nvim-lualine/lualine.nvim", dependencies = {
      "kyazdani42/nvim-web-devicons",
    }
  },

  -- floating terminal
  "akinsho/toggleterm.nvim",

  -- file telescope
  {
    "nvim-telescope/telescope.nvim", dependencies = {
      "nvim-lua/plenary.nvim",
    }
  },

  -- indent guide
  "lukas-reineke/indent-blankline.nvim",

  -- startup screen
	"leslie255/aleph-nvim",

	-- english grammar check
	"rhysd/vim-grammarous",

	-- ascii image
	"samodostal/image.nvim",

  -- autopairs
  "windwp/nvim-autopairs",

  -- lastplace
  "ethanholz/nvim-lastplace",
})
