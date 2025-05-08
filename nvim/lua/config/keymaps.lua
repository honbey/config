-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- disbale `q:`
vim.keymap.set("n", "\\", "q")
vim.keymap.set("n", "q", "<nop>", { noremap = true })
vim.keymap.set("n", "Q", "<nop>", { noremap = true })

-- FIX: folke/snacks.nvim's terminal cannot use Ctrl-h to Backspace
vim.keymap.del("n", "<C-/>")
vim.keymap.del("n", "<C-_>")
vim.keymap.del("n", "<leader>fT")
--vim.keymap.set("t", "<C-h>", "<BS>", { noremap = true })

vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save File/Buffer" })
vim.keymap.set("n", "<leader>fS", function()
  vim.opt_local.wrap = not vim.wo.wrap
  vim.opt_local.spell = not vim.wo.spell
end, { desc = "Toggle Wrap&Spell" })
vim.keymap.set("n", "_", '"_')
vim.keymap.set("i", "<C-g>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-g>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>")
