local ok1, dap = pcall(require, "dap")
if not ok1 then
  return
end

local ok2, dapui = pcall(require, "dapui")
if not ok2 then
  return
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- keymaps set in keymaps.lua
