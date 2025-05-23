-- keymaps.lua
vim.api.nvim_set_keymap('n', '<Space>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>a', ':lua require("nvim-tree.api").fs.create()<CR>',
	{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>d', ':lua require("nvim-tree.api").fs.remove()<CR>',
	{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>r', ':lua require("nvim-tree.api").fs.rename()<CR>',
	{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>t', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Tab>', ':tabnext<CR>', { noremap = true, silent = true })
for i = 1, 9 do
	vim.api.nvim_set_keymap('n', '<Space>' .. i, ':tabnext ' .. i .. '<CR>', { noremap = true, silent = true })
end
vim.api.nvim_set_keymap('n', '<Space>w', ':tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Up>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Down>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Left>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Right>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>s', ':lua require("nvim-tree.api").node.open.vertical()<CR>',
	{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '(', ':set showmatch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ')', ':set showmatch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'x', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'c', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })



-- Move lines with Alt+Arrow keys
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { noremap = true })
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { noremap = true })


vim.api.nvim_set_keymap('n', '<leader>q', 'ysiW', { noremap = false })
