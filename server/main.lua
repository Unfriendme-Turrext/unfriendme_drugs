RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	ESX.Players[playerId] = xPlayer.job.name
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(playerId, job)
	ESX.Players[playerId] = job.name
end)


RegisterServerEvent('unfriendme_scripts:additem') 
AddEventHandler('unfriendme_scripts:additem', function(ItemName)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem(ItemName, 1) then
		xPlayer.addInventoryItem(ItemName, 1)
		xPlayer.showNotification('You have recieved 1x ' .. ItemName)
	else
		xPlayer.showNotification('You cannot hold ' .. ItemName)
	end
end)

RegisterServerEvent('unfriendme_scripts:process') 
AddEventHandler('unfriendme_scripts:process', function(ItemName , ItemName2)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(ItemName)
	if xItem.count > 1 then
		if xPlayer.canCarryItem(ItemName2, 1) then
			xPlayer.removeInventoryItem(ItemName, 2)
			xPlayer.addInventoryItem(ItemName2, 1)
			xPlayer.showNotification('You have recieved 1x' .. ItemName)
		else
			xPlayer.showNotification('You cannot hold ' .. ItemName)
		end
	else
		xPlayer.showNotification("You don't have 2x " .. ItemName)
	end
	
end)