VORP = exports.vorp_inventory:vorp_inventoryApi()

VORP.RegisterUsableItem("campfire", function(data)
    count = VORP.getItemCount(data.source, "campfire")
	if count >= 1 then
		VORP.subItem(data.source, "campfire", 1)
		TriggerClientEvent('prop:campfire', data.source)
	end	
end)