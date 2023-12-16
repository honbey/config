local function set_bg_light()
	vim.cmd('set background=light')
end

local function set_bg_dark()
	vim.cmd('set background=dark')
end

-- vim.g.mapleader = ';'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- keymaps
vim.keymap.set('i', '<C-g>', '<esc>')
vim.keymap.set('i', '<C-;>', '::') -- for C++ and Rust
vim.keymap.set('n', '<leader>vl', set_bg_light)
vim.keymap.set('n', '<leader>vd', set_bg_dark)
-- vim.keymap.set('n', '<leader>', ':')
-- f: file tree / files
vim.keymap.set('n', '<leader>ft', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>ff', ':NvimTreeFocus<cr>')
vim.keymap.set('n', '<leader>fs', ':w<cr>')
-- y: telescope
vim.keymap.set('n', '<leader>yd', function() require 'telescope.builtin'.find_files {} end)
vim.keymap.set('n', '<leader>yg', function() require 'telescope.builtin'.git_files {} end)
vim.keymap.set('n', '<leader>yb', function() require 'telescope.builtin'.buffers {} end)
vim.keymap.set({ 'n', 'i' }, '<C-p>', function() require 'telescope.builtin'.registers {} end)
-- w: window
vim.keymap.set('n', '<leader>ws', ':w<cr>')
vim.keymap.set('n', '<leader>ww', '<c-w>w')
vim.keymap.set('n', '<leader>wr', '<c-w>r')
vim.keymap.set('n', '<leader>wR', '<c-w>R')
vim.keymap.set('n', '<leader>wh', '<c-w>h')
vim.keymap.set('n', '<leader>wj', '<c-w>j')
vim.keymap.set('n', '<leader>wk', '<c-w>k')
vim.keymap.set('n', '<leader>wl', '<c-w>l')
vim.keymap.set('n', '<leader>w1', '<c-w>o')
vim.keymap.set('n', '<leader>wx', ':x<cr>')
vim.keymap.set('n', '<leader>wn', ':sp<cr>')
vim.keymap.set('n', '<leader>wv', ':vs<cr>')
vim.keymap.set('n', '<leader>w[', ':tabp<cr>')
vim.keymap.set('n', '<leader>w]', ':tabn<cr>')
-- window resize
vim.keymap.set('n', '<m-9>', '<c-w><')
vim.keymap.set('n', '<m-0>', '<c-w>>')
vim.keymap.set('n', '<m-->', '<c-w>-')
vim.keymap.set('n', '<m-=>', '<c-w>+')
-- b: buffer
vim.keymap.set('n', '<leader>bn', ':bn<cr>')
vim.keymap.set('n', '<leader>bp', ':bp<cr>')
vim.keymap.set('n', '<leader>bd', ':Bdelete<cr>')
-- p: plugins
vim.keymap.set('n', '<leader>pi', ':PackerInstall<cr>')
vim.keymap.set('n', '<leader>pc', ':PackerClean<cr>')
-- s: search
vim.keymap.set('n', '<leader>ss', '/')
vim.keymap.set('n', '<leader>sw', '/\\<lt>\\><left><left>')

-- t: terminal
-- use <leader>tb to toggle terminal, this can be set in lua/configs/terminal.lua
-- the default position is also set in lua/configs/terminal.lua
vim.keymap.set('t', '<C-g>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=tab<cr>')
vim.keymap.set('n', '<leader>tn', function() require('toggleterm.terminal').Terminal:new():toggle() end)
vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<cr>')
vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<cr>')
vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<cr>')

-- g: git
vim.keymap.set('n', '<leader>gu', ':Gitsigns undo_stage_hunk<cr>')
vim.keymap.set('n', '<leader>gn', ':Gitsigns next_hunk<cr>')
vim.keymap.set('n', '<leader>gc', ':Gitsigns preview_hunk<cr>')
vim.keymap.set('n', '<leader>gr', ':Gitsigns reset_hunk<cr>')
vim.keymap.set('n', '<leader>gR', ':Gitsigns reset_buffer')
vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<cr>')
vim.keymap.set('n', '<leader>gd', ':Gitsigns diffthis<cr>')
vim.keymap.set('n', '<leader>gs', ':<C-U>Gitsigns select_hunk<CR>')
