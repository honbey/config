return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = "<C-/>",
    },
    -- stylua: ignore
    keys = {
      { "<leader>ft", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Terminal" },
      { "<leader>tt", "<cmd>lua require('toggleterm.terminal').Terminal:new():toggle()<cr>", desc = "Terminal" },
      { "<C-_>", "<cmd>ToggleTerm<cr>", mode = { "n" } },
      { "<C-_>", "<cmd>close<cr>", mode = { "t" } },
    },
  },
}
