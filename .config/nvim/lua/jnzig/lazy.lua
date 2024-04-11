local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

local palette

require("lazy").setup(
    {
        {
            "Mofiqul/dracula.nvim",
            name = "dracula",
            priority = 1000,
            config = function()
                local dracula = require("dracula")
                dracula.setup({
                    transparent_bg = true,
                    italic_comment = true,
                })
                vim.cmd.colorscheme("dracula-soft")
                palette = dracula.colors()
            end
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = function() require("nvim-treesitter.install").update({ with_sync = true })() end,
            config = function()
                require('nvim-treesitter.configs').setup({
                    ignore_install = {},
                    modules = {},
                    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "go", "bash", "javascript", "typescript", "python" },
                    sync_install = false,
                    auto_install = true,
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                    },
                })
            end
        },
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.6',
            dependencies = {
                'nvim-lua/plenary.nvim',
                "nvim-tree/nvim-web-devicons"
            },
            config = function()
                local builtin = require('telescope.builtin')
                vim.keymap.set('n', '<leader>tn', builtin.find_files, {})
                vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
                vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
                vim.keymap.set('n', '<leader>ts', function()
                    builtin.grep_string({ search = vim.fn.input("Grep > ") })
                end)
            end
        },
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                local harpoon = require("harpoon")

                harpoon:setup({
                    settings = {
                        save_on_toggle = true,
                        sync_on_ui_close = true
                    }
                })

                vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
                vim.keymap.set("n", "<leader>hp", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

                vim.keymap.set("n", "<A-n>", function() harpoon:list():select(1) end)
                vim.keymap.set("n", "<A-e>", function() harpoon:list():select(2) end)
                vim.keymap.set("n", "<A-i>", function() harpoon:list():select(3) end)
                vim.keymap.set("n", "<A-o>", function() harpoon:list():select(4) end)
            end
        },
        "folke/neodev.nvim",
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "L3MON4D3/LuaSnip", version = "v2.*",                          opts = {} },
        { "hrsh7th/nvim-cmp", event = { "InsertEnter", "CmdlineEnter" }, },
        'hrsh7th/cmp-nvim-lsp',
        {
            "j-hui/fidget.nvim",
            opts = {
                notification = {
                    window = {
                        normal_hl = "Comment", -- Base highlight group in the notification window
                        winblend = 100,        -- Background color opacity in the notification window
                        border = "none",       -- Border around the notification window
                        zindex = 45,           -- Stacking priority of the notification window
                        max_width = 0,         -- Maximum width of the notification window
                        max_height = 0,        -- Maximum height of the notification window
                        x_padding = 1,         -- Padding from right edge of window boundary
                        y_padding = 0,         -- Padding from bottom edge of window boundary
                        align = "bottom",      -- How to align the notification window
                        relative = "editor",   -- What the notification window position is relative to
                    },
                },
            },
        },
        { 'mbbill/undotree', keys = { { "<leader>ut", vim.cmd.UndotreeToggle } } },
        {
            'numToStr/Comment.nvim',
            opts = {
                toggler = { line = "<leader>cm", block = "<leader>cb" },
                opleader = { line = "<leader>cm", block = "<leader>cb" },
            },
        },
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            opts = {
                keymaps = {
                    insert = false,
                    insert_line = false,
                    normal = "s",
                    normal_cur = "ss",
                    normal_line = "S",
                    normal_cur_line = "SS",
                    visual = "s",
                    visual_line = "S",
                    delete = "ds",
                    change = "cs",
                    change_line = "cS",
                },
            },
        },
        {
            'windwp/nvim-autopairs',
            event = "InsertEnter",
            opts = {},
        },
        {
            "ggandor/leap.nvim",
            event = "VeryLazy",
            config = function()
                local leap = require("leap")

                leap.opts.safe_labels = {}
                leap.opts.labels = "arstgoienhqwdpyul"
                leap.opts.max_phase_one_targets = 0
                leap.opts.special_keys.next_group = '<backspace>'

                vim.keymap.set({ 'n', 'x', 'o' }, 't', '<Plug>(leap)')
                vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
                vim.api.nvim_set_hl(0, "LeapLabelPrimary", { bg = palette["yellow"], fg = palette["black"] })
                vim.api.nvim_set_hl(0, "LeapLabelSecondary", { bg = palette["cyan"], fg = palette["black"] })
            end
        },
        {
            "tpope/vim-fugitive",
            -- config = function()
            --     -- set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
            --     local fugitive_statusline = vim.fn.FugitiveStatusline()
            --     vim.opt.statusline = '%<%f %h%m%r' .. fugitive_statusline .. '=%-14.(%l,%c%V%)% %P'
            -- end
        },
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            build = "cd app && npm install",
            init = function()
                vim.g.mkdp_filetypes = { "markdown" }
                vim.g.mkdp_echo_preview_url = 1
            end,
            ft = { "markdown" },
            --keys = {
            --   { "<leader>mdp", vim.cmd("MarkdownPreviewToggle") }
            --}
        },
        {
            "folke/trouble.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            opts = {},
            config = function()
                vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
                vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
                vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
                vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
                vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
                vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
            end
        },
    }
)
