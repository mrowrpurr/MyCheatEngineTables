print("[loaded HelloLua.lua]")

dofile("Divine Divinity/Common.lua")

-- SOME_GLOBAL = 0

if not SOME_GLOBAL then
  print("HelloLua.m.lua: SOME_GLOBAL is not defined!")
  SOME_GLOBAL = 5
end

function enable()
  print("HelloLua.m.lua: enable() !")
  SOME_GLOBAL = SOME_GLOBAL + 1
  print("SOME_GLOBAL = " .. SOME_GLOBAL)
end

function disable()
  print("HelloLua.m.lua: disable() !!")
end
