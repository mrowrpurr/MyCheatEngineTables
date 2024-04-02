-- -- require("lldebugger").start()
-- -- LOCAL_LUA_DEBUGGER_VSCODE
-- if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
--   -- require("lldebugger").start()
--   print("VS Code debugger env found")

--   package.loaded["lldebugger"] = assert(loadfile(os.getenv("LOCAL_LUA_DEBUGGER_FILEPATH")))()
--   require("lldebugger").start()
-- end

function hex(integer)
  return string.format("%x", integer)
end

function getAddy(addressString)
  local address = getAddressList().getMemoryRecordByDescription(addressString)
  if address then
    return address.CurrentAddress
  else
    print("Address not found: " .. addressString)
    return nil
  end
end
