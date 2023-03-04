-- In here i will show you the file-name, line and what to change.

----------------
---- SERVER ----
----------------

-- file-name : qb-bankrobbery | server.lua
-- line : 164 (may differ mines heavily modified)
-- Replace event-recieveItem with the one below.
RegisterNetEvent('qb-bankrobbery:server:recieveItem', function(type, bankId, lockerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    if type == "small" then
        if #(GetEntityCoords(GetPlayerPed(src)) - Config.SmallBanks[bankId]["lockers"][lockerId]["coords"]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:receiveItem", extraInfo = " (smallbank "..bankId..") ", source = source}))
        end
        local itemType = math.random(#Config.RewardTypes)
        local WeaponChance = math.random(1, 50)
        local odd1 = math.random(1, 50)
        local tierChance = math.random(1, 100)
        local tier
        if tierChance < 50 then tier = 1 elseif tierChance >= 50 and tierChance < 80 then tier = 2 elseif tierChance >= 80 and tierChance < 95 then tier = 3 else tier = 4 end
        if WeaponChance ~= odd1 then
            if tier ~= 4 then
                 if Config.RewardTypes[itemType].type == "item" then
                    local item = Config.LockerRewards["tier"..tier][math.random(#Config.LockerRewards["tier"..tier])]
                    local itemAmount = math.random(item.minAmount, item.maxAmount)
                    Player.Functions.AddItem(item.item, itemAmount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Fleeca Locker) and recieved (%s) %s'):format(GetPlayerName(src), Player.PlayerData.license, itemAmount, item.item)) 
                elseif Config.RewardTypes[itemType].type == "money" then
                    local bags = math.random(1,4)
                    local info = {
                        worth = math.random(2300, 3200)
                    }
                    Player.Functions.AddItem('markedbills', bags, false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Fleeca Locker) and recieved (%s) bags of cash'):format(GetPlayerName(src), Player.PlayerData.license, bags)) 
                end
            else
                Player.Functions.AddItem('security_card_01', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_01'], "add")
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Fleeca Locker) and recieved a (security_card_01)'):format(GetPlayerName(src), Player.PlayerData.license)) 
            end
        else
            Player.Functions.AddItem('weapon_stungun', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_stungun'], "add")
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Fleeca Locker) and recieved a (weapon_stungun)'):format(GetPlayerName(src), Player.PlayerData.license)) 
        end
    elseif type == "paleto" then
        if #(GetEntityCoords(GetPlayerPed(source)) - Config.BigBanks["paleto"]["lockers"][lockerId]["coords"]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:receiveItem", extraInfo = " (paleto) ", source = source}))
        end
        local itemType = math.random(#Config.RewardTypes)
        local tierChance = math.random(1, 100) 
        local WeaponChance = math.random(1, 10)
        local odd1 = math.random(1, 10)
        local tier
        if tierChance < 25 then tier = 1 elseif tierChance >= 25 and tierChance < 70 then tier = 2 elseif tierChance >= 70 and tierChance < 95 then tier = 3 else tier = 4 end
        if WeaponChance ~= odd1 then
            if tier ~= 4 then
                 if Config.RewardTypes[itemType].type == "item" then
                    local item = Config.LockerRewardsPaleto["tier"..tier][math.random(#Config.LockerRewardsPaleto["tier"..tier])]
                    local itemAmount = math.random(item.minAmount, item.maxAmount)
                    Player.Functions.AddItem(item.item, itemAmount) 
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Paleto Locker) and recieved (%s) %s'):format(GetPlayerName(src), Player.PlayerData.license, itemAmount, item.item)) 
                 elseif Config.RewardTypes[itemType].type == "money" then
                    local bags = math.random(1,3)
                    local info = {
                        worth = math.random(4000, 6000)
                    }
                    Player.Functions.AddItem('markedbills', bags, false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Paleto Locker) and recieved (%s) bags of cash'):format(GetPlayerName(src), Player.PlayerData.license, bags)) 
                 end
            else
                Player.Functions.AddItem('security_card_02', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_02'], "add")
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Paleto Locker) and recieved a (security_card_02)'):format(GetPlayerName(src), Player.PlayerData.license)) 
            end
        else
            Player.Functions.AddItem('weapon_vintagepistol', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_vintagepistol'], "add")
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Paleto Locker) and recieved a (weapon_vintagepistol)'):format(GetPlayerName(src), Player.PlayerData.license)) 
        end
    elseif type == "pacific" then
        if #(GetEntityCoords(GetPlayerPed(source)) - Config.BigBanks["pacific"]["lockers"][lockerId]["coords"]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:receiveItem", extraInfo = " (pacific) ", source = source}))
        end
        local itemType = math.random(#Config.RewardTypes)
        local WeaponChance = math.random(1, 100)
        local odd1 = math.random(1, 100)
        local odd2 = math.random(1, 100)
        local tierChance = math.random(1, 100)
        local tier
        if tierChance < 10 then tier = 1 elseif tierChance >= 25 and tierChance < 50 then tier = 2 elseif tierChance >= 50 and tierChance < 95 then tier = 3 else tier = 4 end
        if WeaponChance ~= odd1 or WeaponChance ~= odd2 then
            if tier ~= 4 then
                if Config.RewardTypes[itemType].type == "item" then
                    local item = Config.LockerRewardsPacific["tier"..tier][math.random(#Config.LockerRewardsPacific["tier"..tier])]
                    local maxAmount
                    if tier == 3 then maxAmount = 7 elseif tier == 2 then maxAmount = 18 else maxAmount = 25 end
                    local itemAmount = math.random(maxAmount)
                    Player.Functions.AddItem(item.item, itemAmount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Pacific Locker) and recieved (%s) %s'):format(GetPlayerName(src), Player.PlayerData.license, itemAmount, item.item)) 
                elseif Config.RewardTypes[itemType].type == "money" then
                    local bags = math.random(1,2)
                    local info = {
                        worth = math.random(19000, 21000)
                    }
                    Player.Functions.AddItem('markedbills', bags, false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Pacific Locker) and recieved (%s) bags of cash'):format(GetPlayerName(src), Player.PlayerData.license, bags)) 
                end
            else
                local bags = math.random(1,2)
                local info = {
                    worth = math.random(19000, 21000)
                }
                Player.Functions.AddItem('markedbills', bags, false, info)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Pacific Locker) and recieved (%s) bags of cash'):format(GetPlayerName(src), Player.PlayerData.license, bags)) 
            end
        else
            local chance = math.random(1, 2)
            local odd = math.random(1, 2)
            if chance == odd then
                Player.Functions.AddItem('weapon_microsmg', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_microsmg'], "add")
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Pacific Locker) and recieved a (weapon_microsmg)'):format(GetPlayerName(src), Player.PlayerData.license)) 
            else
                Player.Functions.AddItem('weapon_minismg', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_minismg'], "add")
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Bank Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a (Pacific Locker) and recieved a (weapon_minismg)'):format(GetPlayerName(src), Player.PlayerData.license)) 
            end
        end
    end
end)

-- file-name : qb-houserobbery | server.lua
-- line : 40 (may differ mines heavily modified)
-- Replace event-searchCabin with the one below.
RegisterNetEvent('qb-houserobbery:server:searchCabin', function(cabin, house)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local luck = math.random(1, 10)
    local itemFound = math.random(1, 4)
    local itemCount = 1

    local Tier = 1
    if Config.Houses[house]["tier"] == 1 then
        Tier = 1
    elseif Config.Houses[house]["tier"] == 2 then
        Tier = 2
    elseif Config.Houses[house]["tier"] == 3 then
        Tier = 3
    end

    if itemFound < 4 then
        if luck == 10 then
            itemCount = 3
        elseif luck >= 6 and luck <= 8 then
            itemCount = 2
        end

        for _ = 1, itemCount, 1 do
            local randomItem = Config.Rewards[Tier][Config.Houses[house]["furniture"][cabin]["type"]][math.random(1, #Config.Rewards[Tier][Config.Houses[house]["furniture"][cabin]["type"]])]
            local itemInfo = QBCore.Shared.Items[randomItem]
            if math.random(1, 100) == 69 then
                randomItem = "painkillers"
                itemInfo = QBCore.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 2)
                TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'House Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (House Furniture) and recieved a %s'):format(GetPlayerName(src), Player.PlayerData.license, randomItem)) 
            elseif math.random(1, 100) == 35 then
                randomItem = "weed_og-kush_seed"
                itemInfo = QBCore.Shared.Items[randomItem]
                Player.Functions.AddItem(randomItem, 1)
                TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'House Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (House Furniture) and recieved a %s'):format(GetPlayerName(src), Player.PlayerData.license, randomItem)) 
            else
                if not itemInfo["unique"] then
                    local itemAmount = math.random(1, 3)
                    if randomItem == "plastic" then
                        itemAmount = math.random(15, 30)
                    elseif randomItem == "goldchain" then
                        itemAmount = math.random(1, 4)
                    elseif randomItem == "pistol_ammo" then
                        itemAmount = math.random(1, 3)
                    elseif randomItem == "weed_skunk" then
                        itemAmount = math.random(1, 6)
                    end

                    Player.Functions.AddItem(randomItem, itemAmount)
                    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'House Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (House Furniture) and recieved (%s) %s'):format(GetPlayerName(src), itemAmount, randomItem)) 
                else
                    Player.Functions.AddItem(randomItem, 1)
                    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'House Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (House Furniture) and recieved a %s'):format(GetPlayerName(src), randomItem)) 
                end
                TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
            end
            Wait(500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.emty_box"), 'error')
    end

    Config.Houses[house]["furniture"][cabin]["searched"] = true
    TriggerClientEvent('qb-houserobbery:client:setCabinState', -1, house, cabin, true)
end)

-- file-name : qb-jewelery | server.lua
-- line : 51 (may differ mines heavily modified)
-- Replace event-vitrineReward with the one below.
RegisterNetEvent('qb-jewellery:server:vitrineReward', function(vitrineIndex)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local otherchance = math.random(1, 4)
    local odd = math.random(1, 4)
    local cheating = false

    if Config.Locations[vitrineIndex] == nil or Config.Locations[vitrineIndex].isOpened ~= false then
        exploitBan(src, "Trying to trigger an exploitable event \"qb-jewellery:server:vitrineReward\"")
        return
    end
    if cachedPoliceAmount[source] == nil then
        DropPlayer(src, "Exploiting")
        return
    end

    local plrPed = GetPlayerPed(src)
    local plrCoords = GetEntityCoords(plrPed)
    local vitrineCoords = Config.Locations[vitrineIndex].coords

    if cachedPoliceAmount[source] >= Config.RequiredCops then
        if plrPed then
            local dist = #(plrCoords - vitrineCoords)
            if dist <= 25.0 then
                Config.Locations[vitrineIndex]["isOpened"] = true
                Config.Locations[vitrineIndex]["isBusy"] = false
                TriggerClientEvent('qb-jewellery:client:setVitrineState', -1, "isOpened", true, vitrineIndex)
                TriggerClientEvent('qb-jewellery:client:setVitrineState', -1, "isBusy", false, vitrineIndex)

                if otherchance == odd then
                    local item = math.random(1, #Config.VitrineRewards)
                    local amount = math.random(Config.VitrineRewards[item]["amount"]["min"], Config.VitrineRewards[item]["amount"]["max"])
                    if Player.Functions.AddItem(Config.VitrineRewards[item]["item"], amount) then
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.VitrineRewards[item]["item"]], 'add')
                        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Jewelery Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (Jewelery Case) and recieved (%s) %s '):format(GetPlayerName(src), Player.PlayerData.license, amount, randomItem)) 
                    else
                        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
                    end 
                else
                    local amount = math.random(2, 4)
                    if Player.Functions.AddItem("10kgoldchain", amount) then
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["10kgoldchain"], 'add')
                        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Jewelery Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (Jewelery Case) and recieved (%s) Gold Chain(s) '):format(GetPlayerName(src), Player.PlayerData.license, amount)) 
                    else
                        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
                    end
                end
            else
                cheating = true
            end
        end
    else
        cheating = true
    end

    if cheating then
        local license = Player.PlayerData.license
        if flags[license] then
            flags[license] = flags[license] + 1
        else
            flags[license] = 1
        end
        if flags[license] >= 3 then
            exploitBan("Getting flagged many times from exploiting the \"qb-jewellery:server:vitrineReward\" event")
        else
            DropPlayer(src, "Exploiting")
        end
    end
end)

-- file-name : qb-storerobbery | server.lua
-- line : 33 (may differ mines heavily modified)
-- Replace event-takemoney with the one below.
RegisterNetEvent('qb-storerobbery:server:takeMoney', function(register, isDone)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    if #(playerCoords - Config.Registers[register][1].xyz) > 3.0 or (not Config.Registers[register].robbed and not isDone) or (Config.Registers[register].time <= 0 and not isDone) then
        return DropPlayer(src, "Attempted exploit abuse")
    end

    -- Add any additional code you want above this comment to do whilst robbing a register, everything above the if statement under this will be triggered every 2 seconds when a register is getting robbed.

    if isDone then
        local bags = math.random(1,3)
        local info = {
            worth = math.random(cashA, cashB)
        }
        Player.Functions.AddItem('markedbills', bags, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Store Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (Store Register) and recieved (%s) bags of cash '):format(GetPlayerName(src), Player.PlayerData.license, bags)) 
        if math.random(1, 100) <= 10 then
            local code = SafeCodes[Config.Registers[register].safeKey]
            if Config.Safes[Config.Registers[register].safeKey].type == "keypad" then
                info = {
                    label = Lang:t("text.safe_code")..tostring(code)
                }
            else
                info = {
                    label = Lang:t("text.safe_code")..tostring(math.floor((code[1] % 360) / 3.60)).."-"..tostring(math.floor((code[2] % 360) / 3.60)).."-"..tostring(math.floor((code[3] % 360) / 3.60)).."-"..tostring(math.floor((code[4] % 360) / 3.60)).."-"..tostring(math.floor((code[5] % 360) / 3.60))
                }
            end
            Player.Functions.AddItem("stickynote", 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["stickynote"], "add")
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Store Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (Store Register) and recieved a (stickynote) '):format(GetPlayerName(src), Player.PlayerData.license)) 
        end
    end
end)

-- file-name : qb-storerobbery | server.lua
-- line : 87 (may differ mines heavily modified)
-- Replace event-SafeReward with the one below.
RegisterNetEvent('qb-storerobbery:server:SafeReward', function(safe)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    if #(playerCoords - Config.Safes[safe][1].xyz) > 3.0 or Config.Safes[safe].robbed then
        return DropPlayer(src, "Attempted exploit abuse")
    end

	local bags = math.random(1,3)
	local info = {
		worth = math.random(cashA, cashB)
	}
	Player.Functions.AddItem('markedbills', bags, false, info)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Store Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (Store Safe) and recieved (%s) bags of cash '):format(GetPlayerName(src), Player.PlayerData.license, bags)) 
    local luck = math.random(1, 100)
    local odd = math.random(1, 100)
    if luck <= 10 then
        Player.Functions.AddItem("rolex", math.random(3, 7))
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["rolex"], "add")
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Store Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (Store Safe) and recieved a (rolex) '):format(GetPlayerName(src), Player.PlayerData.license)) 
        if luck == odd then
            Wait(500)
            Player.Functions.AddItem("goldbar", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["goldbar"], "add")
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Store Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (Store Safe) and recieved a (goldbar) '):format(GetPlayerName(src), Player.PlayerData.license)) 
        end
    end
end)

-- file-name : qb-truckrobbery | server.lua
-- line : 54 (may differ mines heavily modified)
-- Replace event-graczZrobilnapad with the one below.
RegisterServerEvent('AttackTransport:graczZrobilnapad', function()
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local bags = math.random(1,3)
	local info = {
		worth = math.random(cashA, cashB)
	}
	xPlayer.Functions.AddItem('markedbills', bags, false, info)
	TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['markedbills'], "add")

	local chance = math.random(1, 100)
	TriggerClientEvent('QBCore:Notify', _source, 'You took '..bags..' bags of cash from the van')
	TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Truck Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (Armored Truck) and recieved (%s) bags of cash '):format(GetPlayerName(_source), xPlayer.PlayerData.license, bags)) 
	if chance >= 95 then
		xPlayer.Functions.AddItem('security_card_01', 1)
		TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['security_card_01'], "add")
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Truck Robbery', 'yellow', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed (Armored Truck) and recieved a (security_card_01) '):format(GetPlayerName(_source), xPlayer.PlayerData.license)) 
    end
	Wait(2500)
end)
