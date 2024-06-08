local M = {}

function M.config()
	require("outline").setup({
		guides = {
			enabled = true,
		},
		keymaps = {
			close = { "<Esc>", "q" },
			code_actions = { "<f12>", "a" },
			fold = "h",
			fold_all = "H",
			fold_reset = "R",
			goto_location = "<Cr>",
			hover_symbol = "<C-space>",
			peek_location = "o",
			rename_symbol = "r",
			toggle_preview = "K",
			unfold = "l",
			unfold_all = "L",
		},
		outline_items = {
			highlight_hovered_item = true,
			show_symbol_details = true,
		},
		outline_window = {
			auto_close = false,
			position = "right",
			relative_width = true,
			show_numbers = false,
			show_relative_numbers = false,
			width = 20,
		},
		preview_window = {
			auto_preview = true,
			open_hover_on_preview = true,
			winhl = "Normal:Pmenu",
		},
		provider = {
			lsp = {
				blacklist_clients = {},
			},
		},
		symbol_folding = {
			auto_unfold_hover = true,
			markers = { "", "" },
		},
		symbols = {
			-- filter = {
			-- 	exclude = true,
			-- },
			icons = {
				Array = {
					hl = "Structure",
					icon = "",
				},
				Boolean = {
					hl = "Boolean",
					icon = "⊨",
				},
				Class = {
					hl = "Structure",
					icon = "𝓒",
				},
				Constant = {
					hl = "Identifier",
					icon = "",
				},
				Constructor = {
					hl = "Function",
					icon = "",
				},
				Enum = {
					hl = "Structure",
					icon = "ℰ",
				},
				EnumMember = {
					hl = "Variable",
					icon = "",
				},
				Event = {
					hl = "Special",
					icon = "",
				},
				Field = {
					hl = "Identifier",
					icon = "",
				},
				File = {
					hl = "Special",
					icon = "",
				},
				Function = {
					hl = "Function",
					icon = "",
				},
				Interface = {
					hl = "Structure",
					icon = "ﰮ",
				},
				Key = {
					hl = "Keyword",
					icon = "",
				},
				Method = {
					hl = "Function",
					icon = "ƒ",
				},
				Module = {
					hl = "Special",
					icon = "",
				},
				Namespace = {
					hl = "Special",
					icon = "",
				},
				Null = {
					hl = "Normal",
					icon = "NULL",
				},
				Number = {
					hl = "Number",
					icon = "#",
				},
				Object = {
					hl = "Structure",
					icon = "⦿",
				},
				Operator = {
					hl = "Operator",
					icon = "+",
				},
				Package = {
					hl = "Special",
					icon = "",
				},
				Property = {
					hl = "Identifier",
					icon = "",
				},
				String = {
					hl = "String",
					icon = "𝓐",
				},
				Struct = {
					hl = "Structure",
					icon = "𝓢",
				},
				TypeParameter = {
					hl = "Type",
					icon = "𝙏",
				},
				Variable = {
					hl = "Identifier",
					icon = "",
				},
			},
		},
	})
end

return M
