-- plugins.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- File explorer plugin
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				view = { side = "right" }, -- Move file explorer to the right side
			})
		end,
	},
	-- Color scheme plugin
	{
		"luisiacc/gruvbox-baby",
		config = function()
			vim.g.gruvbox_baby_background_color = "dark"
			vim.cmd("colorscheme gruvbox-baby")
		end,
	},
	-- Dashboard plugin
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" }, { "ibhagwan/fzf-lua" } },
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				config = {
					week_header = { enable = true },
					shortcut = {
						{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
						{ desc = " Dotfiles", group = "Number", action = "FzfLua files cwd=~/dotfiles", key = "d" },
					},
					project = { enable = false, limit = 5 },
					mru = { enable = false, limit = 4 },

					footer = { "Balkan Linux on  󰣇  btw" },
				},
			})
		end,
	},
	-- Lualine plugin
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"tpope/vim-commentary",
	},
	--terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[`]], -- Set backtick (`) to toggle the terminal
			direction = "horizontal", -- Set the terminal at the bottom
			shell = "/bin/zsh", -- Set the terminal to use Zsh
			size = 20, -- Set terminal size (can adjust as needed)
			persist_mode = true, -- Keep terminal open when focus changes
		},
	},
	--indentation
	--    {
	--	    "lukas-reineke/indent-blankline.nvim",
	--	    main = "ibl",
	--	    ---@module "ibl"
	--	    ---@type ibl.config
	--	    opts = {},
	--	    },

	--Formatting and Autocompletion--
	--autocompletion

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("mason").setup() -- Mason for installing LSPs
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "lua_ls", "ts_ls", "bashls", "cssls", "jsonls" },
			})

			local lspconfig = require("lspconfig")

			-- Enable LSPs for different languages
			lspconfig.clangd.setup({}) -- C/C++
			lspconfig.lua_ls.setup({ -- Lua
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } }, -- Fix 'vim' not found
						workspace = { checkThirdParty = false },
					},
				},
			})
			lspconfig.ts_ls.setup({}) -- JavaScript/TypeScript
			lspconfig.bashls.setup({}) -- Shell
			lspconfig.cssls.setup({}) -- CSS
			lspconfig.jsonls.setup({}) -- JSON
		end,
	},
	--Formating --
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- C Formatter
					null_ls.builtins.formatting.clang_format,

					-- Lua Formatter
					null_ls.builtins.formatting.stylua,

					-- JavaScript/TypeScript Formatter
					null_ls.builtins.formatting.prettier,

					-- Shell Formatter
					null_ls.builtins.formatting.shfmt,

					-- CSS Formatter
					null_ls.builtins.formatting.prettier,

					-- JSON Formatter
					null_ls.builtins.formatting.prettier,
				},
			})
		end,
	},


-- SMOOTH SCROOLING --

{
  "karb94/neoscroll.nvim",
  opts = {
    mappings = {}, -- Disable default mappings
  },
  config = function()
    local neoscroll = require("neoscroll")

    -- Custom key mappings for scrolling
    local keymap = {
      ["<C-Down>"] = function()
        neoscroll.scroll(5, {duration = 70, move_cursor = false}) -- Scroll down without moving the cursor
      end, -- Scroll down
      ["<C-Up>"] = function()
        neoscroll.scroll(-5, {duration = 70, move_cursor = false}) -- Scroll up without moving the cursor
      end, -- Scroll up
    }

    -- Set the key mappings
    local modes = { "n", "v", "x" }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func, { silent = true })
    end
  end,
},

	--SmearCursor
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*", -- Ovim omogućavaš colorizer za sve fajlove
			})
		end,
	},

	--Show #Colors
	{
		"norcalli/nvim-colorizer.lua",
		opts = {},
	},
})
