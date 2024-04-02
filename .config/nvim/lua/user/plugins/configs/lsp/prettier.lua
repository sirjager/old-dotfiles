local ok, prettier = pcall(require, "prettier")
if not ok then
  return
end

prettier.setup {
  bin = "prettierd",
  filetypes = {
    "css",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "json",
    "scss",
    "less",
    "markdown",
    "mdx",
    "astro",
    "yaml",
    "html",
    "vue",
  },
}
