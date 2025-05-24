-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- disbale `q:`
vim.keymap.set("n", "\\", "q")
vim.keymap.set("n", "q", "<nop>", { noremap = true })
vim.keymap.set("n", "Q", "<nop>", { noremap = true })

-- not use ctrl-hjkl to navigate windows
vim.keymap.del("n", "<c-h>")
vim.keymap.del("n", "<c-j>")
vim.keymap.del("n", "<c-k>")
vim.keymap.del("n", "<c-l>")

vim.keymap.set("n", "_", '"_')
vim.keymap.set("i", "<C-g>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-g>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-g>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>")
