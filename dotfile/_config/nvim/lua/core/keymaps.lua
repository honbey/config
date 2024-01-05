-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- keymaps
vim.keymap.set("i", "<C-g>", "<esc>")
vim.keymap.set("i", "<C-;>", "::") -- for C++ and Rust
-- b: buffer
vim.keymap.set("n", "<leader>bn", ":bn<cr>")
vim.keymap.set("n", "<leader>bp", ":bp<cr>")
vim.keymap.set("n", "<leader>bl", ":bn<cr>")
vim.keymap.set("n", "<leader>bh", ":bp<cr>")
vim.keymap.set("n", "<leader>bd", ":bdelete<cr>")
-- f: file tree / files | ft: toggle tree, ff: focus tree
vim.keymap.set("n", "<leader>fs", ":w<cr>")
vim.keymap.set("n", "<leader>fm", ":lua vim.lsp.buf.format()<cr>")
-- g: git
-- l: lazy.nvim
vim.keymap.set("n", "<leader>lz", ":Lazy<cr>")
vim.keymap.set("n", "<leader>ls", ":Lazy sync<cr>")
-- s: search
vim.keymap.set("n", "<leader>ss", "/")
vim.keymap.set("n", "<leader>sw", "/\\<lt>\\><left><left>")
-- s: symbols outline | so: toggle
-- s: telescope
-- t: neorg | tu: undone, td: done, ...
-- t: terminal
-- w: window
vim.keymap.set("n", "<leader>ww", "<c-w>w")
vim.keymap.set("n", "<leader>wr", "<c-w>r")
vim.keymap.set("n", "<leader>wR", "<c-w>R")
vim.keymap.set("n", "<leader>wh", "<c-w>h")
vim.keymap.set("n", "<leader>wj", "<c-w>j")
vim.keymap.set("n", "<leader>wk", "<c-w>k")
vim.keymap.set("n", "<leader>wl", "<c-w>l")
vim.keymap.set("n", "<leader>w1", "<c-w>o")
vim.keymap.set("n", "<leader>wx", ":x<cr>")
vim.keymap.set("n", "<leader>wn", ":sp<cr>")
vim.keymap.set("n", "<leader>wv", ":vs<cr>")
vim.keymap.set("n", "<leader>w[", ":tabp<cr>")
vim.keymap.set("n", "<leader>w]", ":tabn<cr>")
-- window resize
vim.keymap.set("n", "<m-9>", "<c-w><")
vim.keymap.set("n", "<m-0>", "<c-w>>")
vim.keymap.set("n", "<m-->", "<c-w>-")
vim.keymap.set("n", "<m-=>", "<c-w>+")

vim.api.nvim_exec(
    [[
         augroup FoldAutogroup
         autocmd!
         autocmd BufReadPost,FileReadPost * normal zR
         augroup END
  ]],
    true
)
