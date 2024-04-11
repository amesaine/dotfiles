vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "LSP Format on save",
    group = vim.api.nvim_create_augroup("format-write", { clear = true }),
    callback = function()
        vim.lsp.buf.format()
    end
})
