local status_ok, mason, mason_lspconfig

status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end
mason.setup({})

status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = {
    "lua_ls",
    "clangd",
    "pyright",
    "jsonls",
    "tsserver",
  -- does not seem to be supported anymore
  --  "prettierd"
  },

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = false,
})

-- Setup each lsp
mason_lspconfig.setup_handlers({
  function(server_name)
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }

    if server_name == "jsonls" then
      local jsonls_opts = require("user.lsp.settings.jsonls")
      opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server_name == "sumneko_lua" then
      local sumneko_opts = require("user.lsp.settings.sumneko_lua")
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server_name == 'clangd' then
      -- @todo move these into a json file
      local clangd_opts = {
        cmd = {
          'clangd',
          '-j=16',
          '--background-index',
          '--background-index-priority=normal',
          '--pch-storage=memory',
          --'--log=verbose',
        }
      }
      opts = vim.tbl_deep_extend("force", clangd_opts, opts)
    end
    require("lspconfig")[server_name].setup(opts)
  end
})
