-- In here i will show you the file-name, line and what to change.

----------------
---- SERVER ----
----------------

-- file-name : qb-adminmenu | server.lua
-- line : 62 (may differ mines heavily modified)
-- Add this under --Events.
RegisterNetEvent('qb-adminmenu:StaffLogs', function(type, state, player)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(player)
    if type == 'invisibility' then
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Invisibility (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Toggled invisibility (%s)'):format(GetPlayerName(src), Staff.PlayerData.license, tostring(state)))
    elseif type == 'godmode' then
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'God-Mode (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Toggled godmode (%s)'):format(GetPlayerName(src), Staff.PlayerData.license, tostring(state)))
    elseif type == 'noclip' then
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'No-Clip (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Toggled noclip (%s)'):format(GetPlayerName(src), Staff.PlayerData.license, tostring(state)))
    elseif type == 'blips' then
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Blips (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Toggled blips (%s)'):format(GetPlayerName(src), Staff.PlayerData.license, tostring(state)))
    elseif type == 'names' then
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Names (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Toggled names (%s)'):format(GetPlayerName(src), Staff.PlayerData.license, tostring(state)))
    elseif type == 'devmode' then
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dev-Mode (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Toggled devmode (%s)'):format(GetPlayerName(src), Staff.PlayerData.license, tostring(state)))
    elseif type == 'spectate' then
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Spectate (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Toggled spectate (%s)'):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(player)), Player.PlayerData.license, tostring(state)))
    elseif type == 'freeze' then
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Freeze (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Toggled freeze (%s)'):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(player)), Player.PlayerData.license, tostring(state)))
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 92 (may differ mines heavily modified)
-- Replace event-kill with the one below.
RegisterNetEvent('qb-admin:server:kill', function(player)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(player.id)
    if QBCore.Functions.HasPermission(src, permissions['kill']) or IsPlayerAceAllowed(src, 'command')  then
        TriggerClientEvent('hospital:client:KillPlayer', player.id)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Kill (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Killed a player'):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(player.id)), Player.PlayerData.license))
    else
        BanPlayer(src)
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 104 (may differ mines heavily modified)
-- Replace event-revive with the one below.
RegisterNetEvent('qb-admin:server:revive', function(player)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(player.id)
    if QBCore.Functions.HasPermission(src, permissions['revive']) or IsPlayerAceAllowed(src, 'command')  then
        TriggerClientEvent('hospital:client:Revive', player.id)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Revive (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Revived a player'):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(player.id)), Player.PlayerData.license))
    else
        BanPlayer(src)
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 170 (may differ mines heavily modified)
-- Replace event-freeze with the one below.
RegisterNetEvent('qb-admin:server:freeze', function(player)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['freeze']) or IsPlayerAceAllowed(src, 'command') then
        local target = GetPlayerPed(player.id)
        if not frozen then
            frozen = true
            FreezeEntityPosition(target, true)
            TriggerEvent('qb-adminmenu:StaffLogs', 'freeze', frozen, target)
        else
            frozen = false
            FreezeEntityPosition(target, false)
            TriggerEvent('qb-adminmenu:StaffLogs', 'freeze', frozen, target)
        end
    else
        BanPlayer(src)
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 188 (may differ mines heavily modified)
-- Replace event-goto with the one below.
RegisterNetEvent('qb-admin:server:goto', function(player)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(player.id)
    if QBCore.Functions.HasPermission(src, permissions['goto']) or IsPlayerAceAllowed(src, 'command') then
        local admin = GetPlayerPed(src)
        local coords = GetEntityCoords(GetPlayerPed(player.id))
        SetEntityCoords(admin, coords)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Go To (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Teleported to player'):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(player.id)), Player.PlayerData.license))
    else
        BanPlayer(src)
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 202 (may differ mines heavily modified)
-- Replace event-intovehicle with the one below.
RegisterNetEvent('qb-admin:server:intovehicle', function(player)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(player.id)
    if QBCore.Functions.HasPermission(src, permissions['intovehicle']) or IsPlayerAceAllowed(src, 'command') then
        local admin = GetPlayerPed(src)
        local targetPed = GetPlayerPed(player.id)
        local vehicle = GetVehiclePedIsIn(targetPed,false)
        local seat = -1
        if vehicle ~= 0 then
            for i=0,8,1 do
                if GetPedInVehicleSeat(vehicle,i) == 0 then
                    seat = i
                    break
                end
            end
            if seat ~= -1 then
                SetPedIntoVehicle(admin,vehicle,seat)
                TriggerClientEvent('QBCore:Notify', src, Lang:t("sucess.entered_vehicle"), 'success', 5000)
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Into Vehicle (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Teleported into player vehicle'):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(player.id)), Player.PlayerData.license))
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_free_seats"), 'danger', 5000)
            end
        end
    else
        BanPlayer(src)
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 231 (may differ mines heavily modified)
-- Replace event-bring with the one below.
RegisterNetEvent('qb-admin:server:bring', function(player)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(player.id)
    if QBCore.Functions.HasPermission(src, permissions['bring']) or IsPlayerAceAllowed(src, 'command') then
        local admin = GetPlayerPed(src)
        local coords = GetEntityCoords(admin)
        local target = GetPlayerPed(player.id)
        SetEntityCoords(target, coords)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bring Player (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Teleported player to them'):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(player.id)), Player.PlayerData.license))
    else
        BanPlayer(src)
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 246 (may differ mines heavily modified)
-- Replace event-inventory with the one below.
RegisterNetEvent('qb-admin:server:inventory', function(player)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(player.id)
    if QBCore.Functions.HasPermission(src, permissions['inventory']) or IsPlayerAceAllowed(src, 'command') then
        TriggerClientEvent('qb-admin:client:inventory', src, player.id)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Open Inventory (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Opened players inventory'):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(player.id)), Player.PlayerData.license))
    else
        BanPlayer(src)
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 258 (may differ mines heavily modified)
-- Replace event-cloth with the one below.
RegisterNetEvent('qb-admin:server:cloth', function(player)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(player.id)
    if QBCore.Functions.HasPermission(src, permissions['clothing']) or IsPlayerAceAllowed(src, 'command') then
        TriggerClientEvent('qb-clothing:client:openMenu', player.id)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Give Clothing (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Gave player clothing menu'):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(player.id)), Player.PlayerData.license))
    else
        BanPlayer(src)
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 293 (may differ mines heavily modified)
-- Replace event-giveweapon with the one below.
RegisterServerEvent('qb-admin:giveWeapon', function(weapon)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        local Staff = QBCore.Functions.GetPlayer(src)
        Staff.Functions.AddItem(weapon, 1)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Spawn Weapon (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Spawned in a (%s) '):format(GetPlayerName(src), Staff.PlayerData.license, weapon))
    else
        BanPlayer(src)
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 304 (may differ mines heavily modified)
-- Replace event-savecar with the one below.
RegisterNetEvent('qb-admin:server:SaveCar', function(mods, vehicle, _, plate)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        local Staff = QBCore.Functions.GetPlayer(src)
        local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
        if result[1] == nil then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                Staff.PlayerData.license,
                Staff.PlayerData.citizenid,
                vehicle.model,
                vehicle.hash,
                json.encode(mods),
                plate,
                0
            })
            TriggerClientEvent('QBCore:Notify', src, Lang:t("success.success_vehicle_owner"), 'success', 5000)
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Save Car (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Used admincar to save a car in their garage '):format(GetPlayerName(src), Staff.PlayerData.license))
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.failed_vehicle_owner"), 'error', 3000)
        end
    else
        BanPlayer(src)
    end
end)

-- file-name : qb-adminmenu | server.lua
-- line : 331 (may differ mines heavily modified)
-- Replace maxmods with the one below.
QBCore.Commands.Add('maxmods', Lang:t("desc.max_mod_desc"), {}, false, function(source)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('qb-admin:client:maxmodVehicle', src)
    TriggerEvent('qb-log:server:CreateLog', 'testing', 'Vehicle Mods (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Added maxmods to their vehicle '):format(GetPlayerName(src), Staff.PlayerData.license))
end, 'admin')

-- file-name : qb-adminmenu | server.lua
-- line : 338 (may differ mines heavily modified)
-- Replace blips with the one below.
QBCore.Commands.Add('blips', Lang:t("commands.blips_for_player"), {}, false, function(source)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('qb-admin:client:toggleBlips', src)
    TriggerEvent('qb-log:server:CreateLog', 'testing', 'Blips (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Toggled blips '):format(GetPlayerName(src), Staff.PlayerData.license))
end, 'admin')

-- file-name : qb-adminmenu | server.lua
-- line : 345 (may differ mines heavily modified)
-- Replace names with the one below.
QBCore.Commands.Add('names', Lang:t("commands.player_name_overhead"), {}, false, function(source)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('qb-admin:client:toggleNames', src)
    TriggerEvent('qb-log:server:CreateLog', 'testing', 'Names (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Toggled names '):format(GetPlayerName(src), Staff.PlayerData.license))
end, 'admin')

-- file-name : qb-adminmenu | server.lua
-- line : 357 (may differ mines heavily modified)
-- Replace noclip with the one below.
QBCore.Commands.Add('noclip', Lang:t("commands.toogle_noclip"), {}, false, function(source)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('qb-admin:client:ToggleNoClip', src)
    TriggerEvent('qb-log:server:CreateLog', 'testing', 'Noclip (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Toggled noclip '):format(GetPlayerName(src), Staff.PlayerData.license))
end, 'admin')

-- file-name : qb-adminmenu | server.lua
-- line : 364 (may differ mines heavily modified)
-- Replace admincar with the one below.
QBCore.Commands.Add('admincar', Lang:t("commands.save_vehicle_garage"), {}, false, function(source, _)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('qb-admin:client:SaveCar', source)
    TriggerEvent('qb-log:server:CreateLog', 'testing', 'Save Car (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Used admincar to save a car in their garage '):format(GetPlayerName(src), Staff.PlayerData.license))
end, 'admin')

-- file-name : qb-adminmenu | server.lua
-- line : 489 (may differ mines heavily modified)
-- Replace setmodel with the one below.
QBCore.Commands.Add('setmodel', Lang:t("commands.change_ped_model"), {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Set Model (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Changed their model to (%s) '):format(GetPlayerName(src), Staff.PlayerData.license, tostring(model)))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Set Model (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Changed players model to (%s) '):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(target), Trgt.PlayerData.license, tostring(model)))
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_set_model"), 'error')
    end
end, 'admin')

-- file-name : qb-adminmenu | server.lua
-- line : 557 (may differ mines heavily modified)
-- Replace setammo with the one below.
QBCore.Commands.Add('setammo', Lang:t("commands.ammo_amount_set"), {{name='amount', help='Amount of bullets, for example: 20'}, {name='weapon', help='Name of the weapon, for example: WEAPON_VINTAGEPISTOL'}}, false, function(source, args)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Set Ammo (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Set ammo for %s to %s '):format(GetPlayerName(src), Staff.PlayerData.license, tostring(weapon), amount))
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, 'current', amount)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Set Ammo (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Set ammo to %s '):format(GetPlayerName(src), Staff.PlayerData.license, amount))
    end
end, 'admin')

----------------
---- CLIENT ----
----------------

-- file-name : qb-adminmenu | events.lua
-- line : 26 (may differ mines heavily modified)
-- Replace event-spectate with the one below.
RegisterNetEvent('qb-admin:client:spectate', function(targetPed)
    local myPed = PlayerPedId()
    local targetplayer = GetPlayerFromServerId(targetPed)
    local target = GetPlayerPed(targetplayer)
    if not isSpectating then
        isSpectating = true
        SetEntityVisible(myPed, false) -- Set invisible
        SetEntityCollision(myPed, false, false) -- Set collision
        SetEntityInvincible(myPed, true) -- Set invincible
        NetworkSetEntityInvisibleToNetwork(myPed, true) -- Set invisibility
        lastSpectateCoord = GetEntityCoords(myPed) -- save my last coords
        NetworkSetInSpectatorMode(true, target) -- Enter Spectate Mode
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'spectate', isSpectating, targetPed)
    else
        isSpectating = false
        NetworkSetInSpectatorMode(false, target) -- Remove From Spectate Mode
        NetworkSetEntityInvisibleToNetwork(myPed, false) -- Set Visible
        SetEntityCollision(myPed, true, true) -- Set collision
        SetEntityCoords(myPed, lastSpectateCoord) -- Return Me To My Coords
        SetEntityVisible(myPed, true) -- Remove invisible
        SetEntityInvincible(myPed, false) -- Remove godmode
        lastSpectateCoord = nil -- Reset Last Saved Coords
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'spectate', isSpectating, targetPed)
    end
end)

-- file-name : qb-adminmenu | client.lua
-- line : 400 (may differ mines heavily modified)
-- Replace menu2_admin_invisible with the one below.
local invisible = false
menu2_admin_invisible:On('change', function(_, _, _)
    if not invisible then
        invisible = true
        SetEntityVisible(PlayerPedId(), false, 0)
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'invisibility', invisible)
    else
        invisible = false
        SetEntityVisible(PlayerPedId(), true, 0)
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'invisibility', invisible)
    end
end)

-- file-name : qb-adminmenu | client.lua
-- line : 415 (may differ mines heavily modified)
-- Replace menu2_admin_god_mode with the one below.
local godmode = false
menu2_admin_god_mode:On('change', function(_, _, _)
    godmode = not godmode
    TriggerServerEvent('qb-adminmenu:StaffLogs', 'godmode', godmode)
    if godmode then
        while godmode do
            Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end)

-- file-name : qb-adminmenu | client.lua
-- line : 1005 (may differ mines heavily modified)
-- Replace menu7_dev_info_mode with the one below.
menu7_dev_info_mode:On('change', function(_, _, _)
    developermode = not developermode
    TriggerEvent('qb-admin:client:ToggleDevmode')
    if developermode then
	    SetPlayerInvincible(PlayerId(), true)
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'devmode', developermode)
    else
	    SetPlayerInvincible(PlayerId(), false)
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'devmode', developermode)
    end
end)

-- file-name : qb-adminmenu | blipsnames.lua
-- line : 16 (may differ mines heavily modified)
-- Replace toggleBlips with the one below.
RegisterNetEvent('qb-admin:client:toggleBlips', function()
    if not ShowBlips then
        ShowBlips = true
        NetCheck1 = true
        QBCore.Functions.Notify(Lang:t("success.blips_activated"), "success")
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'blips', ShowBlips)
    else
        ShowBlips = false
        QBCore.Functions.Notify(Lang:t("error.blips_deactivated"), "error")
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'blips', ShowBlips)
    end
end)

-- file-name : qb-adminmenu | blipsnames.lua
-- line : 29 (may differ mines heavily modified)
-- Replace toggleNames with the one below.
RegisterNetEvent('qb-admin:client:toggleNames', function()
    if not ShowNames then
        ShowNames = true
        NetCheck2 = true
        QBCore.Functions.Notify(Lang:t("success.names_activated"), "success")
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'names', ShowNames)
    else
        ShowNames = false
        QBCore.Functions.Notify(Lang:t("error.names_deactivated"), "error")
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'names', ShowNames)
    end
end)

-- file-name : qb-adminmenu | noclip.lua
-- line : 225 (may differ mines heavily modified)
-- Replace ToggleNoClip with the one below.
ToggleNoClip = function(state)
    IsNoClipping = state or not IsNoClipping
    PlayerPed    = PlayerPedId()
    PlayerIsInVehicle = IsPedInAnyVehicle(PlayerPed, false)
    if PlayerIsInVehicle ~= 0 and IsPedDrivingVehicle(PlayerPed, GetVehiclePedIsIn(PlayerPed, false)) then
        NoClipEntity = GetVehiclePedIsIn(PlayerPed, false)
        SetVehicleEngineOn(NoClipEntity, not IsNoClipping, true, IsNoClipping)
        NoClipAlpha = PedFirstPersonNoClip == true and 0 or 51
    else
        NoClipEntity = PlayerPed
        NoClipAlpha = VehFirstPersonNoClip == true and 0 or 51
    end

    if IsNoClipping then
        FreezeEntityPosition(PlayerPed)
        SetupCam()
        PlaySoundFromEntity(-1, "SELECT", PlayerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'noclip', IsNoClipping)
        if not PlayerIsInVehicle then
            ClearPedTasksImmediately(PlayerPed)
            if PedFirstPersonNoClip then
                Wait(1000) -- Wait for the cinematic effect of the camera transitioning into first person 
            end
        else
            if VehFirstPersonNoClip then
                Wait(1000) -- Wait for the cinematic effect of the camera transitioning into first person 
            end
        end

    else
        local groundCoords      = GetGroundCoords(GetEntityCoords(NoClipEntity))
        SetEntityCoords(NoClipEntity, groundCoords.x, groundCoords.y, groundCoords.z)
        Wait(50)
        DestroyCamera()
        PlaySoundFromEntity(-1, "CANCEL", PlayerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
        TriggerServerEvent('qb-adminmenu:StaffLogs', 'noclip', IsNoClipping)
    end
    
    QBCore.Functions.Notify(IsNoClipping and Lang:t("success.noclip_enabled") or Lang:t("success.noclip_disabled"))
    SetUserRadioControlEnabled(not IsNoClipping)
   
    if IsNoClipping then
        RunNoClipThread()
    end
end
