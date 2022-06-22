RegisterNetEvent('esx:playerLoaded') -- Store the players data
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew)
	print("Player Loaded. New | " .. isNew)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:playerLogout') -- When a player logs out (multicharacter), reset their data
AddEventHandler('esx:playerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

-- These two functions can perform the same task
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	print('PlayerData.job was set to '..job)
	if ESX.PlayerData.job.name ~= job.name then
		print('You are now in a different job')
	end
	ESX.PlayerData.job = job
end)

function OnPlayerData(key, val, last)
	if type(val) == 'table' then val = json.encode(val) end
	print('PlayerData.'..key..' was set to '..val)
	if key == 'job' then
		if last.name ~= val.name then
			print('You are now in a different job')
		end
	elseif key == 'dead' then -- However, this function can be used for other PlayerData
		if val == true then
			print('You die too easily')
			SetTimeout(2000, function()
				if ESX.PlayerData.dead then
					print('Why are you still dead?')
				end
			end)
		end
	end
end
-----------------------------------------------

Citizen.CreateThread(function()
	while true do
		local Sleep = 1500
		local PlayerPed = PlayerPedId() 
		local PlayerCoords = GetEntityCoords(PlayerPed)
		for k, v in pairs(Config.Drugs) do
			if #(v.Collect - PlayerCoords) < 7 then
				
				Sleep = 5
				local x, y, z = table.unpack(v.Collect)
				if v.DrawMarker then
					DrawMarker(v.Marker, x, y, z - 1, 0.0,0.0,0.0,0.0,0.0,0.0, v.MarkerSize.x,
					v.MarkerSize.y, v.MarkerSize.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
				if v.Draw3dText then
					ESX.Game.Utils.DrawText3D(v.Collect, v.CollectText)
				end
				if #(v.Collect - PlayerCoords) < 3  and IsControlJustReleased(0, 38) then
					TriggerServerEvent('unfriendme_scripts:additem', v.Item)
				end
			end
		end
		
		Wait(Sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		local Sleep2 = 1500
		local PlayerPed = PlayerPedId() 
		local PlayerCoords = GetEntityCoords(PlayerPed)
		for k, v in pairs(Config.Drugs) do
			if #(v.Process - PlayerCoords) < 7 then
				Sleep2 = 5
				local x, y, z = table.unpack(v.Process)

				
				if v.DrawMarker then
					DrawMarker(v.Marker, x, y, z - 1, 0.0,0.0,0.0,0.0,0.0,0.0, v.MarkerSize.x,
					v.MarkerSize.y, v.MarkerSize.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
				if v.Draw3dText then
					ESX.Game.Utils.DrawText3D(v.Process, v.ProcessText)
				end
				if #(v.Process - PlayerCoords) < 3 and IsControlJustReleased(0, 38) then
					TriggerServerEvent('unfriendme_scripts:process', v.Item, v.ProcessedItem)
				end
			end
		end
		Wait(Sleep2)
	end
end)

Citizen.CreateThread(function()
	while true do
		local Sleep4 = 1500
		local PlayerPed = PlayerPedId() 
		local PlayerCoords = GetEntityCoords(PlayerPed)
		for k, v in pairs(Config.Drugs) do
			if #(v.Enter - PlayerCoords) < 7 then
				Sleep4 = 5
				local x, y, z = table.unpack(v.Exit)
				if v.EnableTeleport then
					ESX.Game.Utils.DrawText3D(v.Enter, 'Press ~r~[E] to Exit')
				end
				if #(v.Enter - PlayerCoords) < 3 and IsControlJustReleased(0, 38) then
					Teleport(PlayerPed, {x = x, y = y, z = z, heading = v.ExitHeading})
				end
			end
		end
		Wait(Sleep4)
	end
end)   

Citizen.CreateThread(function()
	while true do
		local Sleep5 = 1500
		local PlayerPed = PlayerPedId() 
		local PlayerCoords = GetEntityCoords(PlayerPed)
		for k, v in pairs(Config.Drugs) do
			if #(v.Exit - PlayerCoords) < 7 then
				Sleep5 = 5
				local x, y, z = table.unpack(v.Enter)
				if v.EnableTeleport then
					ESX.Game.Utils.DrawText3D(v.Exit, 'Press ~r~[E] to Enter')
				end
				if #(v.Exit - PlayerCoords) < 3 and IsControlJustReleased(0, 38) then
					Teleport(PlayerPed, {x = x, y = y, z = z, heading = v.EnterHeading})
				end
			end
		end
		Wait(Sleep5)
	end
end)

function Teleport(playerPed, entercoords)
	ESX.Game.Teleport(playerPed, entercoords, function()
		ESX.ShowNotification('You have been teleported')
	end)
end


CreateThread(function()
    for k, v in pairs(Config.Blips) do
		if v.Show then
			local x, y, z = table.unpack(v.Pos)
			local blip = AddBlipForCoord(x, y, z)
			SetBlipSprite(blip, v.Blip)
			SetBlipScale(blip, v.Size)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, v.Color)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(v.Name)
			EndTextCommandSetBlipName(blip)
		end
    end
end)