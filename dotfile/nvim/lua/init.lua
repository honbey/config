-- basics
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.shiftround = true
vim.opt.updatetime = 300
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- vim.opt.formatoptions:remove { "c", "r", "o" }
if vim.fn.has("termguicolors") == 1 then
	vim.opt.termguicolors = true
end
-- tabs
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.cmd("autocmd FileType c,markdown,org,nginx,yaml setlocal tabstop=2")
vim.cmd("autocmd FileType c,markdown,org,nginx,yaml setlocal softtabstop=2")
vim.cmd("autocmd FileType c,markdown,org,nginx,yaml setlocal shiftwidth=2")
vim.cmd("autocmd FileType markdown,org,nginx,yaml setlocal expandtab")
-- listchar
vim.opt.list = true
vim.opt.listchars = "tab: ,space:·"
-- window
vim.wo.colorcolumn = "80,120"
vim.wo.signcolumn = "yes"
-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- lazy.nvim
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.loader.enable()

require("comkeym")
require("lazynvim")
