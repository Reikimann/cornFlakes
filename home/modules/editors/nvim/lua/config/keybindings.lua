local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false, desc = "which_key_ignore" }
vim.g.mapleader = ' '

map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)

map('i', 'jk', '<ESC>', opts)
map('i', 'kj', '<ESC>', opts)

map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

map('v', 'u', "t_", opts)

map('n', 'cu', "ct_", opts)

map("n", "J", "mzJ`z", opts)

map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

map("x", "<leader>P", [["_dP]], opts)

map("n", "<leader>y", [["+y]], opts)
map("v", "<leader>y", [["+y]], opts)

map("n", "<leader>d", [["_d]], opts)
map("v", "<leader>d", [["_d]], opts)
