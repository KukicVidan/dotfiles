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
			vim.g.gruvbox_baby_color_overrides = {
				background = "#070603", -- Replace with your desired HEX color
			}
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

					footer = { "Folk Frequency on  󰣇  btw" },
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
	--{
	--	"lukas-reineke/indent-blankline.nvim",
	--	main = "ibl",
	--	---@module "ibl"
	--	---@type ibl.config
	--	opts = {},
	--},

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
				ensure_installed = { "clangd", "lua_ls", "ts_ls", "bashls", "cssls", "jsonls", "rust_analyzer" },
			})

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.cssls.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({ capabilities = capabilities })
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

					-- Rust Formatter (rustfmt)
					null_ls.builtins.formatting.rustfmt,
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
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
					neoscroll.scroll(5, { duration = 70, move_cursor = false }) -- Scroll down without moving the cursor
				end,                              -- Scroll down
				["<C-Up>"] = function()
					neoscroll.scroll(-5, { duration = 70, move_cursor = false }) -- Scroll up without moving the cursor
				end,                              -- Scroll up
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

	--Code SNippets

	{
		"rafamadriz/friendly-snippets",
		dependencies = { "L3MON4D3/LuaSnip" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	-- fzf-lua plugin setup
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Configuration for fzf-lua
			require("fzf-lua").setup({
				previewers = {
					media = {
						enabled = true,
						tools = { "viu" },
					},
				},
			})
		end
	},

	--###################   THIS IS AI #######################--

	-- Custom Parameters (with defaults)
	{
		"David-Kunz/gen.nvim",
		opts = {
			model = "gemma3:4b", -- The default model to use.
			quit_map = "q", -- set keymap to close the response window
			retry_map = "<c-r>", -- set keymap to re-send the current prompt
			accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
			host = "localhost", -- The host running the Ollama service.
			port = "11434", -- The port on which the Ollama service is listening.
			display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
			show_prompt = false, -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
			show_model = false, -- Displays which model you are using at the beginning of your chat session.
			no_auto_close = false, -- Never closes the window automatically.
			file = false, -- Write the payload to a temporary file to keep the command short.
			hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
			init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
			-- Function to initialize Ollama
			command = function(options)
				local body = { model = options.model, stream = true }
				return "curl --silent --no-buffer -X POST http://" ..
				    options.host .. ":" .. options.port .. "/api/chat -d $body"
			end,
			-- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
			-- This can also be a command string.
			-- The executed command must return a JSON object with { response, context }
			-- (context property is optional).
			-- list_models = '<omitted lua function>', -- Retrieves a list of model names
			result_filetype = "markdown", -- Configure filetype of the result buffer
			debug = false -- Prints errors and the command which is run.
		}
	},

	--Telescope
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
		},



		config = function()
			require('telescope').setup {
				pickers = {
					find_files = {
						theme = "ivy",
						hidden = true, -- show hidden files (dotfiles)
					},
					live_grep = {
						theme = "ivy", -- search inside files with ivy layout
					},
					buffers = {
						theme = "ivy", -- switch open buffers (open files)
					},
					help_tags = {
						theme = "ivy", -- search Neovim help docs
					},
				}
			}

			-- Keymaps with beginner comments
			vim.keymap.set("n", "<space>ff", require('telescope.builtin').find_files) -- Find files in project
			vim.keymap.set("n", "<space>fg", require('telescope.builtin').live_grep) -- Search inside files for text
			vim.keymap.set("n", "<space>fb", require('telescope.builtin').buffers) -- Switch between open files
			vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags) -- Search through Neovim help
		end

	},

})
