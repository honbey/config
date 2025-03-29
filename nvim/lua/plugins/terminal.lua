return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = "<c-`>",
    },
    -- stylua: ignore
    keys = {
      { "<leader>ft", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Terminal" },
      { "<leader>tt", "<cmd>lua require('toggleterm.terminal').Terminal:new():toggle()<cr>", desc = "Terminal" },
      { "<C-`>", "<cmd>ToggleTerm<cr>", mode = { "n" } },
      { "<C-`>", "<cmd>close<cr>", mode = { "t" } },
      { "<C-[>", "<C-\\><C-n>", mode = { "t" } },
    },
  },
}
