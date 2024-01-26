local ok, pkg = pcall(require, "nx")
if not ok then
  return
end

pkg.setup{}

