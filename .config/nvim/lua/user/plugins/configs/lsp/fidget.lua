local ok1, pkg = pcall(require, "fidget")
if not ok1 then
  return
end

pkg.setup()
