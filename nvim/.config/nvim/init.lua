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

-- Initialize lazy.nvim
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
  -- Color scheme
  {
    "luisiacc/gruvbox-baby",
    config = function()
      vim.g.gruvbox_baby_background_color = "dark"
      -- Options: "medium" (default), "soft", "dark"    
      vim.cmd("colorscheme gruvbox-baby")
    end,
  },

})

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

