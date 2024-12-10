return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = vim.cmd.TSUpdate,
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = { "lua", "vim", "vimdoc", "query", "python", "javascript", "html", "yaml", "toml" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
    { "nvim-treesitter/nvim-treesitter-context" },
}
