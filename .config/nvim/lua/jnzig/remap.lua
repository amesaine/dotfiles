-- Set the mapleader to a space
vim.g.mapleader = " "

-- Execute Ex command (Vim command-line)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Rearrange lines in visual mode: Move selected lines down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- Rearrange lines in visual mode: Move selected lines up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines in normal mode
vim.keymap.set("n", "J", "mzJ`z")
-- Scroll half a page down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Scroll half a page up
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Search for the next occurrence and center the screen
vim.keymap.set("n", "n", "nzzzv")
-- Search for the previous occurrence and center the screen
vim.keymap.set("n", "N", "Nzzzv")

-- Delete and paste in a single command, a common clipboard operation
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to the system clipboard (requires proper clipboard setup)
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- Copy to the system clipboard in visual mode
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete and clear register in a single command
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Use Ctrl+C in insert mode to escape to normal mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Map Q to do nothing (NOP)
vim.keymap.set("n", "Q", "<nop>")

-- Format code using LSP
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format)

-- Navigate between quickfix and location lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace (case-insensitive) with confirmation
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make a file executable (e.g., a shell script)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Change working directory inside neovim
vim.keymap.set("n", "<leader><leader>", function()
    local cur = vim.fn.expand("%")

    if vim.fn.filereadable(cur) == 1 then
        vim.cmd("cd" .. vim.fn.expand("%:h"))
    else
        vim.cmd("cd %")
    end
end)
