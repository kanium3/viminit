local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local lspconfig = require("lspconfig")
local on_attach = require("lsp.handler")
local codelldb_path = "/home/kanium/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb"
local liblldb_path = "/home/kanium/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so"

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/lua-language-server" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "use" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
			hint = {
				enable = true,
			},
		},
	},
})

lspconfig.prismals.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/prisma-language-server", "--stdio" },
})

lspconfig.taplo.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/taplo", "lsp", "stdio" },
})

lspconfig.crystalline.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/crystalline", "--stdio" },
})

lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/vscode-css-language-server", "--stdio" },
})

lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/vscode-html-language-server", "--stdio" },
})

lspconfig.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/tailwindcss-language-server", "--stdio" },
})

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/pyright-langserver", "--stdio" },
	single_file_support = true,
})

lspconfig.elixirls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
})

---@diagnostic disable-next-line: undefined-field
require("typescript").setup({
	server = { -- pass options to lspconfig's setup method
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { "/home/kanium/.local/share/nvim/mason/bin/typescript-language-server", "--stdio" },
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	},
})

require("flutter-tools").setup({
	lsp = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
})

lspconfig.svelte.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/svelteserver", "--stdio" },
})

lspconfig.sqls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/sqls" },
})

local rust_opts = {
	tools = {
		inlay_hints = {
			auto = false,
		},
	},
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { "/home/kanium/.local/share/nvim/mason/bin/rust-analyzer" },
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					enable = true,
					allFeatures = true,
					overrideCommand = {
						"cargo",
						"clippy",
						"--workspace",
						"--message-format=json",
						"--all-targets",
						"--all-features",
					},
				},
			},
		},
	},
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
}

require("rust-tools").setup(rust_opts)

lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

lspconfig.bufls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/kanium/.local/share/nvim/mason/bin/bufls", "serve" }
})
