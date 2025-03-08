-- Set the Leader key
vim.g.mapleader = ' '

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


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
      require("nvim-tree").setup()
    end,
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
-------------------------------------------------------------
------------------------------------------------------------
-- Toggle file explorer
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Add a file
vim.api.nvim_set_keymap('n', '<Leader>a', ':lua require("nvim-tree.api").fs.create()<CR>', { noremap = true, silent = true })

-- Delete a file
vim.api.nvim_set_keymap('n', '<Leader>d', ':lua require("nvim-tree.api").fs.remove()<CR>', { noremap = true, silent = true })

-- Rename a file
vim.api.nvim_set_keymap('n', '<Leader>r', ':lua require("nvim-tree.api").fs.rename()<CR>', { noremap = true, silent = true })
-- Opens New Tab
vim.api.nvim_set_keymap('n', '<Leader><CR>', ':lua require("nvim-tree.api").node.open.tab()<CR>', { noremap = true, silent = true })
-- Move to the next tab
vim.api.nvim_set_keymap('n', '<Leader><Tab>', ':tabnext<CR>', { noremap = true, silent = true })
-- Move to a specific tab using Space + Number
for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<Leader>' .. i, ':tabnext ' .. i .. '<CR>', { noremap = true, silent = true })
end
-- Close the current tab with Space + w
vim.api.nvim_set_keymap('n', '<Leader>w', ':tabclose<CR>', { noremap = true, silent = true })
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
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
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
    lualine_a = {},
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
----------------------------#########-------------------------
