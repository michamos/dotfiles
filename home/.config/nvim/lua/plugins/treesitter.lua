return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = vim.cmd.TSUpdate,
        config = function () 
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "lua", "vim", "vimdoc", "query", "python", "javascript", "html", "yaml", "toml" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end,
        dependencies = {"nvim-treesitter/nvim-treesitter-context"},
    },
}
