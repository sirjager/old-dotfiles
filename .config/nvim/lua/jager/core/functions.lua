-- Custom Functions

function Toggle_WrapLines()
  if vim.wo.wrap then
    vim.wo.wrap = false
    vim.print "Disabled Wrap Line"
  else
    vim.wo.wrap = true
    vim.print "Enabled Wrap Line"
  end
end

local line_number = 0
function Toggle_LineNumbers()
  if line_number == 0 then
    vim.wo.nu = true
    vim.wo.rnu = false
    vim.print "Showing Only Line Numbers"
    line_number = 1
  elseif line_number == 1 then
    vim.wo.rnu = true
    vim.print "Showing Relative Line Numbers With Current Line Number"
    line_number = 2
  elseif line_number == 2 then
    vim.wo.nu = false
    vim.print "Showing Relative Line Numbers Without Current Line Number"
    line_number = 3
  elseif line_number == 3 then
    vim.wo.nu = true
    vim.wo.rnu = false
    vim.print "Showing Only Line Numbers"
    line_number = 4
  else
    vim.wo.nu = false
    vim.wo.rnu = false
    vim.print "Hidding All Line Numbers"
    line_number = 0
  end
end
