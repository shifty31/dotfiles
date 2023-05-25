require("mason").setup({
    PATH = "prepend", -- "skip" seems to cause the spawning error
})

local lsp = require("lsp-zero")
-- local lsp_config = require("lspconfig")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
    'lua_ls',
})

lsp.skip_server_setup({ 'help' })

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.configure('ltex', {
    settings = {
        ltex = {
            language = "en-AU",
        },
    },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

local cmp_sources = {
    { name = 'path',     keyword_length = 2 },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'luasnip',  keyword_length = 2 },
    { name = 'buffer',   keyword_length = 3 },
}

-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    sources = cmp_sources,
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = '😂',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>q", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.diagnostic.config({
    virtual_text = true
})

local lspZero = require('lsp-zero').preset({})

lspZero.on_attach(function(client, bufnr)
    lspZero.default_keymaps({ buffer = bufnr })
    lspZero.buffer_autoformat()
end)

lsp.setup({
    root_dir = function(fname)
        return vim.loop.cwd()
    end
})
