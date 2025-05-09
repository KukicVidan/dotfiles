-- core.lua
vim.g.mapleader = ' '  -- Set the Leader key

vim.o.termguicolors = true
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Ensure clipboard is enabled
vim.o.clipboard = "unnamedplus"  -- This allows you to yank/paste from the system clipboard

-- Numbers
vim.o.relativenumber = false  -- Enable relative line numbers
vim.o.number = true
vim.opt.hlsearch = false  -- Disable search highlighting
vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = "/",
    command = "set hlsearch",
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = "/",
    command = "set nohlsearch",
})

