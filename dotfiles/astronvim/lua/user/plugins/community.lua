return {
	-- Add the community repository of plugin specifications
	"AstroNvim/astrocommunity",
	-- example of imporing a plugin, comment out to use it or add your own
	-- available plugins can be found at https://github.com/AstroNvim/astrocommunity

	-- Colorscheme
	{ import = "astrocommunity.colorscheme.nightfox" },
	-- utility
	{ import = "astrocommunity.scrolling.mini-animate" },
	{ import = "astrocommunity.utility.noice-nvim" },
	{
		"folke/noice.nvim",
		opts = {
			presets = { lsp_doc_border = true },
		},
	},
	{ import = "astrocommunity.project.project-nvim" },

	-- Language
	{ import = "astrocommunity.pack.svelte" },
	{ import = "astrocommunity.pack.astro" },
	{ import = "astrocommunity.pack.typescript" },
	{ import = "astrocommunity.pack.go" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.yaml" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.pack.tailwindcss" },
	{ import = "astrocommunity.pack.toml" },
	{ import = "astrocommunity.pack.docker" },
}
