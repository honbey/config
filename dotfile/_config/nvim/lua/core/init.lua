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
if (vim.fn.has("termguicolors") == 1) then
    vim.opt.termguicolors = true
end
-- tabs
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.cmd("autocmd FileType nginx setlocal tabstop=4")
vim.cmd("autocmd FileType nginx setlocal shiftwidth=4")
vim.cmd("autocmd FileType nginx setlocal softtabstop=4")
-- listchar
vim.opt.list = true
vim.opt.listchars = "tab:->"
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
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

require("core.gui")
require("core.keymaps")
require("core.lazynvim")

vim.loader.enable()

-- disable some useless standard plugins to save startup time
-- these features have been better covered by plugins
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1

-- Load plugin configs
require("configs.autocomplete").config()
require("configs.bufferline").config()
require("configs.filetree").config()
require("configs.formatter").config()
require("configs.git").config()
require("configs.lspconfig").config()
require("configs.startscreen").config()
require("configs.statusline").config()
require("configs.treesitter").config()
require("configs.symbols_outline").config()
require("configs.terminal").config()
