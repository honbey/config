return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    opts = {
      integrations = {
        snacks = true,
      },
    },
    lazy = true,
    cmd = "Neogit",
  },
}
