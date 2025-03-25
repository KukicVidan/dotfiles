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
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { {'nvim-tree/nvim-web-devicons'}, {'ibhagwan/fzf-lua'} },
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = { enable = true },
                    shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                        { desc = ' Dotfiles', group = 'Number', action = 'FzfLua files cwd=~/dotfiles', key = 'd' },
                    },
                    project = {enable = false, limit = 5},
		    mru = { enable = false, limit = 4 },

                    footer = { 'Balkan Linux on  󰣇  btw' },
                },
            }
        end
    },
    -- Lualine plugin
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
    "tpope/vim-commentary",
  },
  --terminal
   {'akinsho/toggleterm.nvim', version = "*", opts = {
    open_mapping = [[`]],             -- Set backtick (`) to toggle the terminal
    direction = "horizontal",        -- Set the terminal at the bottom
    shell = "/bin/zsh",              -- Set the terminal to use Zsh
    size = 20,                       -- Set terminal size (can adjust as needed)
    persist_mode = true,             -- Keep terminal open when focus changes
  }}
    --indentation
 --    {
 --    "lukas-reineke/indent-blankline.nvim",
 --    main = "ibl",
 --    ---@module "ibl"
 --    ---@type ibl.config
 --    opts = {},
 --    },
 --
 --    --Formatting and Autocompletion
    
})

