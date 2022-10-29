local on_attach = function(client, bufnr)
	require("lsp_signature").on_attach()

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end

	if client.name == "sqls" then
		require("sqls").on_attach(client, bufnr)
	end

	if client.name ~= "rust_analyzer" and client.server_capabilities.codeLensProvider then
		require("virtualtypes").on_attach(client, bufnr)
	end

	if client.server_capabilities.inlayHintProvider then
		require("lsp-inlayhints").on_attach(client, bufnr)
	end

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>lua require('actions-preview').code_actions()<CR>", opts)
	buf_set_keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<leader>fr", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
end

return on_attach
