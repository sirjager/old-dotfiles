-- Use a protected call so we don't error out on first use
local ok, pkg = pcall(require, "darcubox")
if not ok then
  return
end

pkg.setup {
  options = {
    transparent = false,
    styles = {
      comments = {},
      functions = {},
      keywords = {},
      types = {},
    },
  },
}
