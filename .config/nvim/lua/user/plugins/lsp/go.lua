local ok, go = pcall(require, "go")
if not ok then
  return
end

local ok2, godap = pcall(require, "dap-go")
if not ok2 then
  return
end

godap.setup({})

go.setup {
  lsp_inlay_hints = { enable = false },
}
