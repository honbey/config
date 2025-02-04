local M = {}

function M.config()
	local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
	local servers = {
		"clangd",
		"pyright",
		"lua_ls",
		"bashls", -- bash-language-server@5.0.0
		"ts_ls",
		"rust_analyzer",
		"jdtls",
	}
	-- nvim-lspconfig config
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	for _, lsp in pairs(servers) do
		require("lspconfig")[lsp].setup({
			capabilities = lsp_capabilities,
		})
	end

	-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "LSP actions",
		callback = function()
			local bufmap = function(mode, lhs, rhs)
				local opts = { noremap = true, buffer = true }
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			-- Mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			bufmap("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>")
			bufmap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
			bufmap("n", "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<cr>")
			bufmap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>")
			bufmap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.declaration()<cr>")
			bufmap("n", "<leader>lD", "<cmd>lua vim.lsp.buf.definition()<cr>")
			bufmap("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
			bufmap("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>")
			bufmap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>")
			bufmap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>")

			bufmap("n", "<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<cr>")
			bufmap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
			bufmap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<cr>")
			bufmap("n", "<leader>df", "<cmd>lua vim.diagnostic.open_float()<cr>")

			bufmap("n", "<leader>wsa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>")
			bufmap("n", "<leader>wsr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>")
			bufmap("n", "<leader>wsl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>")
		end,
	})
end

return M
