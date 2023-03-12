-- In here i will show you the file-name, line and what to change.

-- file-name : ps-weedplanting | sv_planting.lua
-- line : 228
-- Replace HarvestPlant with the one below.
RegisterNetEvent('ps-weedplanting:server:HarvestPlant', function(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if not WeedPlants[entity] then return end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - WeedPlants[entity].coords) > 10 then return end
    if calcGrowth(entity) ~= 100 then return end

    if DoesEntityExist(entity) then
        local health = calcHealth(entity)
        if WeedPlants[entity].gender == 'female' then
            local info = { health = health }
            Player.Functions.AddItem(Shared.BranchItem, 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.BranchItem], 'add', 1)
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Weed Planting', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Weed Plant Harvested'):format(GetPlayerName(src), Player.PlayerData.license))
        else -- male seed added
            local mSeeds = math.floor(health / 50)
            local fSeeds = math.floor(health / 20)
            Player.Functions.AddItem(Shared.MaleSeed, mSeeds, false)
            Player.Functions.AddItem(Shared.FemaleSeed, fSeeds, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.MaleSeed], 'add', mSeeds)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.FemaleSeed], 'add', fSeeds)
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Weed Planting', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Weed Plant Harvested'):format(GetPlayerName(src), Player.PlayerData.license))
        end
        
        DeleteEntity(entity)
        MySQL.query('DELETE from weedplants WHERE id = :id', {
            ['id'] = WeedPlants[entity].id
        })
        WeedPlants[entity] = nil
    end
end)

-- file-name : ps-weedplanting | sv_planting.lua
-- line : 262
-- Replace PoliceDestroy with the one below.
RegisterNetEvent('ps-weedplanting:server:PoliceDestroy', function(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if not WeedPlants[entity] then return end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.type ~= Shared.CopJob then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - WeedPlants[entity].coords) > 10 then return end

    if DoesEntityExist(entity) then
        MySQL.query('DELETE from weedplants WHERE id = :id', {
            ['id'] = WeedPlants[entity].id
        })

        TriggerClientEvent('ps-weedplanting:client:FireGoBrrrrrrr', -1, WeedPlants[entity].coords)
        Wait(Shared.FireTime)
        DeleteEntity(entity)

        WeedPlants[entity] = nil
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Weed Planting', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Department:** %s | **Grade:** %s\n **Info:** Plant Destroyed By Police'):format(GetPlayerName(src), Player.PlayerData.license, Player.PlayerData.job.name, Player.PlayerData.job.grade.level))
    end
end)

-- file-name : ps-weedplanting | sv_planting.lua
-- line : 262
-- Replace CreateNewPlant with the one below.
RegisterNetEvent('ps-weedplanting:server:CreateNewPlant', function(coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - coords) > Shared.rayCastingDistance + 10 then return end
    if Player.Functions.RemoveItem(Shared.FemaleSeed, 1) and Player.Functions.RemoveItem(Shared.PlantTubItem, 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.FemaleSeed], 'remove', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.PlantTubItem], 'remove', 1)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Weed Planting', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Planted A New Weed Plant'):format(GetPlayerName(src), Player.PlayerData.license))
        local ModelHash = Shared.WeedProps[1]
        local plant = CreateObjectNoOffset(ModelHash, coords.x, coords.y, coords.z + Shared.ObjectZOffset, true, true, false)
        FreezeEntityPosition(plant, true)
        local time = os.time()
        MySQL.insert('INSERT into weedplants (coords, time, fertilizer, water, gender) VALUES (:coords, :time, :fertilizer, :water, :gender)', {
            ['coords'] = json.encode(coords),
            ['time'] = time,
            ['fertilizer'] = json.encode({}),
            ['water'] = json.encode({}),
            ['gender'] = 'female'
        }, function(data)
            WeedPlants[plant] = {
                id = data,
                coords = coords,
                time = time,
                fertilizer = {},
                water = {},
                gender = 'female'
            }
        end)
    end
end)

-- file-name : ps-weedplanting | sv_processing.lua
-- line : 3
-- Replace ProcessBranch with the one below.
RegisterNetEvent('ps-weedplanting:server:ProcessBranch', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local item = Player.Functions.GetItemByName(Shared.BranchItem)
    if item then
        if Player.Functions.RemoveItem(Shared.BranchItem, 1, item.slot) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.BranchItem], 'remove', 1)
            Player.Functions.AddItem(Shared.WeedItem, 2, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.WeedItem], 'add', 2)
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Weed Planting (Processing)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Weed Plant Branch'):format(GetPlayerName(src), Player.PlayerData.license))
        end
    end
end)

-- file-name : ps-weedplanting | sv_processing.lua
-- line : 18
-- Replace PackageWeed with the one below.
RegisterNetEvent('ps-weedplanting:server:PackageWeed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local item = Player.Functions.GetItemByName(Shared.WeedItem)
    if item and item.amount >= 20 then
        Player.Functions.RemoveItem(Shared.WeedItem, 20, item.slot)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.WeedItem], 'remove', 20)
        Player.Functions.AddItem(Shared.PackedWeedItem, 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.PackedWeedItem], 'add', 1)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Weed Planting (Processing)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Packaged Dried Weed'):format(GetPlayerName(src), Player.PlayerData.license))
    else
        TriggerClientEvent('QBCore:Notify', src,_U('not_enough_dryweed'), 'error')
    end
end)

-- file-name : ps-weedplanting | sv_weedrun.lua
-- line : 5
-- Replace CollectPackageGoods with the one below.
RegisterNetEvent('ps-weedplanting:server:CollectPackageGoods', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local citizenid = Player.PlayerData.citizenid
    if not packageCache[citizenid] then return end

    if packageCache[citizenid] == 'waiting' then
        TriggerClientEvent('QBCore:Notify', src, _U('still_waiting'), 'error', 2500)
    elseif packageCache[citizenid] == 'done' then
        packageCache[citizenid] = nil
        TriggerClientEvent('ps-weedplanting:client:PackageGoodsReceived', src)
        if Player.Functions.AddItem(Shared.SusPackageItem, 1) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.SusPackageItem], 'add', 1)
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Weed Planting (Run)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Package For Weed Run'):format(GetPlayerName(src), Player.PlayerData.license))
        end
    end
end)

-- file-name : ps-weedplanting | sv_weedrun.lua
-- line : 35
-- Replace WeedrunDelivery with the one below.
RegisterNetEvent('ps-weedplanting:server:WeedrunDelivery', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.Functions.RemoveItem(Shared.SusPackageItem, 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.SusPackageItem], 'remove', 1)
        Wait(2000)
        local payout = math.random(Shared.PayOut[1], Shared.PayOut[2])
        Player.Functions.AddMoney('cash', payout)
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Weed Planting (Run)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Delivered Weed Package For ($%s)'):format(GetPlayerName(src), Player.PlayerData.license, payout))
    end
end)