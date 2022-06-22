AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	ESX.Players[playerId] = xPlayer.job.name
end)
AddEventHandler('esx:setJob', function(playerId, job)
	ESX.Players[playerId] = job.name
end)
RegisterNetEvent('unfriendme_scripts:additem', function(ItemName)
	for k, v in pairs(Config.Drugs) do
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local ped = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(ped)
	if #(v.Collect - playerCoords) < 30   then
	if xPlayer.canCarryItem(ItemName, 1) then
		xPlayer.addInventoryItem(ItemName, 1)
		xPlayer.showNotification('You have recieved 1x ' .. ItemName)
	else
		xPlayer.showNotification('You cannot hold ' .. ItemName)
	  end
    end
  end
end)
RegisterNetEvent('unfriendme_scripts:process', function(ItemName , ItemName2)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(ItemName)
	local ped = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(ped)
	if #(v.Process - playerCoords) < 30   then
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
   end
end)
