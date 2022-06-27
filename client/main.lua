local PlayingAnim = false

RegisterNetEvent('esx:playerLoaded') -- Store the players data
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
	Blip()
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
CreateThread(function()
	while true do
		Wait(0)
		local sleep = true
		local PlayerPed = PlayerPedId() 
		local PlayerCoords = GetEntityCoords(PlayerPed)
		for k, v in pairs(Config.Drugs) do
			if #(v.Exit - PlayerCoords) < 4 then
				sleep = false
				if v.EnableTeleport then
					Draw3DText(v.Exit.x, v.Exit.y, v.Exit.z, 'Press ~r~[E] to Enter')
				end
				if #(v.Exit - PlayerCoords) < 4 and IsControlJustReleased(0, 38) then
					tp(PlayerPed, v.Enter.x, v.Enter.y, v.Enter.z)
				end
			end
		if #(v.Enter - PlayerCoords) < 4 then
			sleep = false
			if v.EnableTeleport then
				Draw3DText(v.Enter.x,v.Enter. y, v.Enter.z, 'Press ~r~[E] to Exit')
			end
			if #(v.Enter - PlayerCoords) < 3 and IsControlJustReleased(0, 38) then
				tp(PlayerPed, v.Exit.x, v.Exit.y, v.Exit.z)
			end
		end
		if #(v.Process - PlayerCoords) < 4 then
			sleep = false
			if v.DrawMarker then
				DrawMarker(v.Marker, v.Process.x,v.Process.y,v.Process.z - 1, 0.0,0.0,0.0,0.0,0.0,0.0, v.MarkerSize.x,
				v.MarkerSize.y, v.MarkerSize.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
			if v.Draw3dText then
				Draw3DText(v.Process.x,v.Process.y,v.Process.z, v.ProcessText)
			end
			if #(v.Process - PlayerCoords) < 3 and IsControlJustReleased(0, 38) then
				TriggerServerEvent('unfriendme_scripts:process', v.Item, v.ProcessedItem)
			end
		end
		if #(v.Collect - PlayerCoords) < 4 then	
			sleep = false
			if v.DrawMarker then
				DrawMarker(v.Marker, v.Collect.x, v.Collect.y, v.Collect.z - 1, 0.0,0.0,0.0,0.0,0.0,0.0, v.MarkerSize.x,
				v.MarkerSize.y, v.MarkerSize.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
			if v.Draw3dText then
				Draw3DText(v.Collect.x, v.Collect.y, v.Collect.z, v.CollectText)
			end
			if #(v.Collect - PlayerCoords) < 3  and IsControlJustReleased(0, 38) and PlayingAnim == false then
				if v.PlayAnim and PlayingAnim == false then
					PlayingAnim = true
					playanim = true
					anim = v.AnimName
					TriggerEvent('unfriendme_scripts:animation', playanim, anim, v.Item)
				else
					playanim = false
					anim = v.AnimName
					TriggerEvent('unfriendme_scripts:animation', playanim, anim, v.Item)
				end
			end
		end
	end
	if sleep then
		Wait(500)
	  end
	end
end)

function tp(ped, x, y, z)
    CreateThread( 
      function()
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
          Wait(0)
        end
        SetEntityCoords(ped, x, y, z)
        DoScreenFadeIn(250)
		ESX.ShowNotification('You have been teleported')
      end)
end
function Blip()
	for k, v in pairs(Config.Blips) do
		if v.Show then
			local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
			SetBlipSprite(blip, v.Blip)
			SetBlipScale(blip, v.Size)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, v.Color)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(v.Name)
			EndTextCommandSetBlipName(blip)
		end
    end
end

RegisterNetEvent('unfriendme_scripts:animation', function(playanim, anim, Item)
	if playanim then
		print(PlayingAnim)
		TaskStartScenarioInPlace(PlayerPedId(), anim, 0, true)
		Wait(10000)
		TriggerServerEvent('unfriendme_scripts:additem', Item)
		ClearPedTasksImmediately(PlayerPedId())
		PlayingAnim = false
	else
		TriggerServerEvent('unfriendme_scripts:additem', Item)
		PlayingAnim = false
		Wait(5)
	end
end)
function Draw3DText(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
  end
