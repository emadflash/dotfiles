-- https://github.com/hrsh7th/nvim-cmp/commit/cdb77665bbf23bd2717d424ddf4bf98057c30bb3
-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    vim.keymap.set("n", "<c-[>", vim.diagnostic.goto_prev, {buffer=bufnr})
    vim.keymap.set("n", "<c-]>", vim.diagnostic.goto_next, {buffer=bufnr})
    vim.keymap.set("n", "?", vim.lsp.buf.hover, {buffer=bufnr})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=bufnr})
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=bufnr})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=bufnr})
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=bufnr})
    buf_set_keymap('n', '<c-f>', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
end

lsp['clangd'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}

require('rust-tools').setup({})
lsp['rust_analyzer'].setup {
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
}

--require("indent_blankline").setup {
    --show_current_context = true,
    --show_current_context_start = true,
--}

--require('telescope').load_extension("fzf")

-- nvim-cmp
vim.opt.completeopt={"menu", "menuone", "noselect"}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  end,
},
window = {
  -- completion = cmp.config.window.bordered(),
  -- documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'vsnip' }, -- For vsnip users.
  -- { name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
}, {
  { name = 'buffer' },
})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
}, {
  { name = 'buffer' },
})
})


-- Nvim tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "lua", "rust" },  -- A list of parser names, or "all"
  sync_install = false,  -- Install parsers synchronously (only applied to `ensure_installed`)
  ignore_install = { "javascript" }, -- List of parsers to ignore installing (for "all")

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,    -- `false` will disable the whole extension
    disable = { "c", "rust" },    -- list of language parsers that will be disabled

    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    additional_vim_regex_highlighting = false,
  },
}
