local ____lualib = require("lualib_bundle")
local __TS__NumberToString = ____lualib.__TS__NumberToString
local ____exports = {}
function ____exports.hex(int)
    return __TS__NumberToString(int, 16)
end
function ____exports.getAddress(addressString)
    local address = getAddressList().getMemoryRecordByDescription(addressString)
    if address == nil then
        print("Address not found: " .. addressString)
    end
    return address and address.CurrentAddress
end
return ____exports
