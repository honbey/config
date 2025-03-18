return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
      { "echasnovski/mini.pick", lazy = true },
    },
    config = true,
    lazy = true,
    keys = {
      { "<leader>gm", "<cmd>Neogit<cr>", desc = "Open Neogit(magit-like)" },
    },
  },
}
