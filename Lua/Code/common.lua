local ____lualib = require("lualib_bundle")
local __TS__NumberToString = ____lualib.__TS__NumberToString
local __TS__StringPadStart = ____lualib.__TS__StringPadStart
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
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
function ____exports.getAddressString(address, padding)
    if padding == nil then
        padding = 8
    end
    return __TS__StringPadStart(
        string.upper(__TS__NumberToString(address, 16)),
        padding,
        "0"
    )
end
function ____exports.readSimpleFloat(address)
    local floatString = tostring(readFloat(address))
    if __TS__StringIncludes(floatString, "e") then
        return nil
    end
    if __TS__StringIncludes(floatString, "nan") then
        return nil
    end
    return floatString
end
return ____exports
