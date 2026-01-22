return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = vim.cmd.TSUpdate,
    },
    {
        'MeanderingProgrammer/treesitter-modules.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            ensure_installed = { "lua", "vim", "vimdoc", "query", "python", "javascript", "html", "yaml", "toml", "json", "regex", "typst" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = false,
                    node_incremental = " ",
                    scope_incremental = false,
                    node_decremental = " ",
                },
            },
        },
    },
    { "nvim-treesitter/nvim-treesitter-context" },
}
