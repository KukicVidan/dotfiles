-- appearance.lua
vim.cmd("colorscheme gruvbox-baby")

-- Set Nvim Tree background color
vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = '#000000' }) --#070603 old color
-- Set Nvim Tree background color
vim.api.nvim_set_hl(0, 'NvimTreeNormalNC', { bg = '#000000' })

require('lualine').setup {
	options = {
		--theme = 'codedark',
		theme = 'jellybeans',
		component_separators = { left = '|', right = '|' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = { 'toggleterm' },
			winbar = {},
		},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { { 'filename', path = 1 } },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = { 'fileformat', { 'filename', path = 1 }, 'filetype' },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
