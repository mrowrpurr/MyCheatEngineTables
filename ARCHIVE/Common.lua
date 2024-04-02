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
