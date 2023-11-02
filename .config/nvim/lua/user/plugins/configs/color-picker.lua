local ok, pkg = pcall(require, "color-picker")
if not ok then
  return
end

pkg.setup()
