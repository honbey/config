local M = {}

function M.config()
	require("luasnip.loaders.from_vscode").lazy_load()
	local ls = require("luasnip")
	local s = ls.snippet
	local sn = ls.snippet_node
	local t = ls.text_node
	local i = ls.insert_node
	local f = ls.function_node
	local c = ls.choice_node
	local d = ls.dynamic_node
	local r = ls.restore_node

	local dateTZ = function()
		return { os.date("%Y-%m-%d %X +0800") }
	end

	-- Reference: https://sbulav.github.io/vim/neovim-setting-up-luasnip/
	ls.add_snippets(nil, {
		markdown = {
			s({
				trig = "datez",
				namr = "DateTZ",
				dscr = "Datetime with Timezone",
			}, {
				f(dateTZ, {}),
			}),
			s({
				trig = "meta",
				namr = "Metadate",
				dscr = "Yaml metadata format for Ink Blog",
			}, {
				t({ "title: " }),
				i(1),
				t({ "", "author: " }),
				i(2, "me"),
				t({ "", "date: " }),
				f(dateTZ, {}),
				t({ "", "update: " }),
				f(dateTZ, {}),
				t({ "", "cover: " }),
				i(3, "/img"),
				t({ "", "draft: false", "top: false", "tags: " }),
				t({ "", "    - " }),
				i(4, "Tags"),
				t({ "", "type: post", "hide: false", "toc: true", "---", "", "" }),
				i(5, "Preview"),
				t({ "", "", "<!--more-->", "", "" }),
				i(0, "Contents"),
			}),
		},
	})
end

return M
