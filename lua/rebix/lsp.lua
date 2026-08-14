vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	{ src = "https://github.com/stevearc/conform.nvim" },

	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },

	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },

	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },

	{ src = "https://github.com/j-hui/fidget.nvim" },

    { src = "https://github.com/windwp/nvim-autopairs" },
})

require("conform").setup({
	formatters_by_ft = {},
})

require("fidget").setup({})

require("nvim-autopairs").setup({})

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"vtsls",
		"tailwindcss",
        "pyright",
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},

			diagnostics = {
				globals = { "vim" },
			},

			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},

			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "4",
				},
			},
		},
	},
})

vim.lsp.config("tailwindcss", {
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"heex",
	},
})

vim.lsp.enable({
	"lua_ls",
	"vtsls",
	"tailwindcss",
    "pyright",
})

local cmp = require("cmp")
local cmp_select = {
	behavior = cmp.SelectBehavior.Select,
}

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done()
)

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

vim.diagnostic.config({
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
