local M = {}
function M.config()
	-- nvim-tree config
	require("nvim-tree").setup({
		disable_netrw = true,
		hijack_netrw = true,
		-- open_on_setup        = true,
		auto_reload_on_write = true,
		open_on_tab = false,
		hijack_cursor = false,
		update_cwd = false,
		diagnostics = {
			enable = false,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
			ignore_list = {},
		},
		system_open = {
			cmd = nil,
			args = {},
		},
		filters = {
			dotfiles = true,
			custom = {},
		},
		git = {
			enable = true,
			ignore = true,
			timeout = 500,
		},
		view = {
			width = 25,
			-- height = 30,
			side = "left",
			number = false,
			relativenumber = false,
			signcolumn = "yes",
		},
		trash = {
			cmd = "trash",
			require_confirm = true,
		},
		actions = {
			change_dir = {
				global = false,
			},
			open_file = {
				quit_on_open = false,
			},
		},
	})
	vim.cmd([[
    let g:nvim_tree_icons = {
        \ 'default': '',
        \ 'symlink': '',
        \ 'git': {
        \   'unstaged': "✗",
        \   'staged': "✓",
        \   'unmerged': "",
        \   'renamed': "➜",
        \   'untracked': "★",
        \   'deleted': "",
        \   'ignored': "◌"
        \   },
        \ 'folder': {
        \   'arrow_open': "",
        \   'arrow_closed': "",
        \   'default': "",
        \   'open': "",
        \   'empty': "",
        \   'empty_open': "",
        \   'symlink': "",
        \   'symlink_open': "",
        \   }
        \ }
    ]])

	-- barbar buffer(tab) line
	vim.g.barbar_auto_setup = false
	require("barbar").setup({
		animation = false,
		auto_hide = false,
		tabpages = true,
		clickable = true,
		exclude_name = { "package.json" },
		focus_on_close = "left",
		icons = {
			buffer_number = false,
			button = "",
			preset = "default",
			modified = { button = "" },
			pinned = { button = "", filename = true },
		},
		sidebar_filetypes = {
			NvimTree = { event = "BufWinLeave", text = "File Explorer", align = "left" },
			Outline = { event = "BufWinLeave", text = "Symbols Outline", align = "right" },
		},
		no_name_title = nil,
	})
end

return M
