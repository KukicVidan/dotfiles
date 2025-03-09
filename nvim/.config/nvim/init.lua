-- Set the Leader key
vim.g.mapleader = ' '

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Ensure clipboard is enabled
vim.o.clipboard = "unnamedplus"  -- This allows you to yank/paste from the system clipboard

--numbers
vim.o.relativenumber = true  -- Enable relative line numbers
    
        



-- Ensure lazy.nvim is installed
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
------------------------------------------
-- Initialize lazy.nvim--------------------
require("lazy").setup({
  -- List your plugins here

 -- File explorer
{
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        side = "right", -- Move file explorer to the right side
      },
    })
  end
},

  ----------------------------------------------------------
  -- Color scheme
  {
    "luisiacc/gruvbox-baby",
    config = function()
      vim.g.gruvbox_baby_background_color = "dark"
      -- Options: "medium" (default), "soft", "dark"    
      vim.cmd("colorscheme gruvbox-baby")
    end,
  },
  ---------------------------------------------------------
  ---Dashboard  
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
        project = {
          enable = true,
          limit = 5,
          icon = ' ',
          label = '',
          items = {
            { desc = ' Empty Project', cwd = '', action = 'FzfLua files' }, 
            { desc = '󰉖 Configs', cwd = '/home/vidan/.config', action = 'FzfLua files cwd=/home/vidan/.config' },
            { desc = ' Dotfiles', cwd = '/home/vidan/dotfiles', action = 'FzfLua files cwd=/home/vidan/dotfiles' },
            { desc = ' Scripts', cwd = '/home/vidan/scripts', action = 'FzfLua files cwd=/home/vidan/dotfiles/hypr/.config/hypr/scripts' },
            { desc = ' Downloads', cwd = '/home/vidan/Downloads', action = 'FzfLua files cwd=/home/vidan/Downloads' },
          }
        },
        mru = { enable = false, limit = 4 },
        footer = {  'Balkan Linux on  󰣇  btw'}
      },
    }
  end
},


  ----------------------------------------------------------
  --Lua Line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},
  ------------------------------------------------------------
 -- Hyprland syntax highlighting
 



 --
})
-------------------------------------------------------------
---------------------------KEYBINDS---------------------------
------------------------------------------------------------
	-- Toggle file explorer with Space + e
vim.api.nvim_set_keymap('n', '<Space>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Add a file with Space + a
vim.api.nvim_set_keymap('n', '<Space>a', ':lua require("nvim-tree.api").fs.create()<CR>', { noremap = true, silent = true })

-- Delete a file with Space + d
vim.api.nvim_set_keymap('n', '<Space>d', ':lua require("nvim-tree.api").fs.remove()<CR>', { noremap = true, silent = true })

-- Rename a file with Space + r
vim.api.nvim_set_keymap('n', '<Space>r', ':lua require("nvim-tree.api").fs.rename()<CR>', { noremap = true, silent = true })

-- Open New Tab with Space + t (vertical split)
vim.api.nvim_set_keymap('n', '<Space>t', ':tabnew<CR>', { noremap = true, silent = true })

-- Move to the next tab with Space + Tab
vim.api.nvim_set_keymap('n', '<Space><Tab>', ':tabnext<CR>', { noremap = true, silent = true })

-- Move to a specific tab using Space + Number
for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<Space>' .. i, ':tabnext ' .. i .. '<CR>', { noremap = true, silent = true })
end

-- Close the current tab with Space + w
vim.api.nvim_set_keymap('n', '<Space>w', ':tabclose<CR>', { noremap = true, silent = true })


-- Split window vertically (left-right) with Ctrl + s
vim.api.nvim_set_keymap('n', '<C-s>', ':vsplit<CR>', { noremap = true, silent = true })

-- Navigate splits using Space + arrow keys
vim.api.nvim_set_keymap('n', '<Space><Up>', '<C-w>k', { noremap = true, silent = true })  -- Up
vim.api.nvim_set_keymap('n', '<Space><Down>', '<C-w>j', { noremap = true, silent = true })  -- Down
vim.api.nvim_set_keymap('n', '<Space><Left>', '<C-w>h', { noremap = true, silent = true })  -- Left
vim.api.nvim_set_keymap('n', '<Space><Right>', '<C-w>l', { noremap = true, silent = true })  -- Right


-- Split with the file from the file explorer (when in NvimTree) and current file
vim.api.nvim_set_keymap('n', '<Space>s', ':lua require("nvim-tree.api").node.open.vertical()<CR>', { noremap = true, silent = true })



-- Enable showmatch for parentheses, braces, etc. (enabled by default)
vim.api.nvim_set_keymap('n', '(', ':set showmatch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ')', ':set showmatch<CR>', { noremap = true, silent = true })

-- Disable default cut (x) and copy (c) bindings to avoid accidental usage
vim.api.nvim_set_keymap('n', 'x', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'c', '', { noremap = true, silent = true })

-- Map copy to clipboard
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })

-- Map paste from clipboard
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })




--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

vim.opt.hlsearch = false  -- Disable search highlighting
vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = "/",
    command = "set hlsearch",
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = "/",
    command = "set nohlsearch",
})


----------------#######LUALINE CONF#########---------------------------
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'codedark',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{'filename',path =1}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {'fileformat',{'filename',path=1}, 'filetype'},
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
--------------------#########-------------------------

