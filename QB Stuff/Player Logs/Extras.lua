-- In here i will show you the file-name, line and what to change.

----------------
---- SERVER ----
----------------

-- [Un Managed Showroom]

-- file-name : qb-vehicleshop | server.lua
-- line : 140 (may differ mines heavily modified)
-- Replace event-financePayment with the one below.
RegisterNetEvent('qb-vehicleshop:server:financePayment', function(paymentAmount, vehData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.PlayerData.money['cash']
    local bank = Player.PlayerData.money['bank']
    local plate = vehData.vehiclePlate
    paymentAmount = tonumber(paymentAmount)
    local minPayment = tonumber(vehData.paymentAmount)
    local timer = (Config.PaymentInterval * 60)
    local newBalance, newPaymentsLeft, newPayment = calculateNewFinance(paymentAmount, vehData)
    if newBalance > 0 then
        if Player and paymentAmount >= minPayment then
            if cash >= paymentAmount then
                Player.Functions.RemoveMoney('cash', paymentAmount)
                MySQL.update('UPDATE player_vehicles SET balance = ?, paymentamount = ?, paymentsleft = ?, financetime = ? WHERE plate = ?', {newBalance, newPayment, newPaymentsLeft, timer, plate})
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Finance)', 'blue', ('**Customer:** %s | **License:** ||(%s)||\n **New Payment:** ($%s) | Cash\n **Outstanding:** %s\n **Remaining Payments:** %s\n **Vehicle Plate:** %s '):format(GetPlayerName(src), Player.PlayerData.license, paymentAmount, newBalance, newPaymentsLeft, plate))
            elseif bank >= paymentAmount then
                Player.Functions.RemoveMoney('bank', paymentAmount)
                MySQL.update('UPDATE player_vehicles SET balance = ?, paymentamount = ?, paymentsleft = ?, financetime = ? WHERE plate = ?', {newBalance, newPayment, newPaymentsLeft, timer, plate})
                TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Finance)', 'blue', ('**Customer:** %s | **License:** ||(%s)||\n **New Payment:** ($%s) | Bank\n **Outstanding:** %s\n **Remaining Payments:** %s\n **Vehicle Plate:** %s '):format(GetPlayerName(src), Player.PlayerData.license, paymentAmount, newBalance, newPaymentsLeft, plate))
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.minimumallowed') .. comma_value(minPayment), 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.overpaid'), 'error')
    end  
end)    

-- file-name : qb-vehicleshop | server.lua
-- line : 173 (may differ mines heavily modified)
-- Replace event-financePaymentFull with the one below.
RegisterNetEvent('qb-vehicleshop:server:financePaymentFull', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.PlayerData.money['cash']
    local bank = Player.PlayerData.money['bank']
    local vehBalance = data.vehBalance
    local vehPlate = data.vehPlate
    if Player and vehBalance ~= 0 then
        if cash >= vehBalance then
            Player.Functions.RemoveMoney('cash', vehBalance)
            MySQL.update('UPDATE player_vehicles SET balance = ?, paymentamount = ?, paymentsleft = ?, financetime = ? WHERE plate = ?', {0, 0, 0, 0, vehPlate})
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Finance)', 'blue', ('**Customer:** %s | **License:** ||(%s)||\n **Payment:** ($%s) | Cash\n **Vehicle Plate:** %s\n **Remaining Payments:** 0\n **Remaining Balance:** 0 '):format(GetPlayerName(src), Player.PlayerData.license, vehBalance, vehPlate))
        elseif bank >= vehBalance then
            Player.Functions.RemoveMoney('bank', vehBalance)
            MySQL.update('UPDATE player_vehicles SET balance = ?, paymentamount = ?, paymentsleft = ?, financetime = ? WHERE plate = ?', {0, 0, 0, 0, vehPlate})
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Finance)', 'blue', ('**Customer:** %s | **License:** ||(%s)||\n **Payment:** ($%s) | Bank\n **Vehicle Plate:** %s\n **Remaining Payments:** 0\n **Remaining Balance:** 0 '):format(GetPlayerName(src), Player.PlayerData.license, vehBalance, vehPlate))
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.alreadypaid'), 'error')
    end
end)

-- file-name : qb-vehicleshop | server.lua
-- line : 198 (may differ mines heavily modified)
-- Replace event-buyShowroomVehicle with the one below.
RegisterNetEvent('qb-vehicleshop:server:buyShowroomVehicle', function(vehicle)
    local src = source
    vehicle = vehicle.buyVehicle
    local Player = QBCore.Functions.GetPlayer(src)
    local cid = Player.PlayerData.citizenid
    local cash = Player.PlayerData.money['cash']
    local bank = Player.PlayerData.money['bank']
    local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
    local plate = GeneratePlate()
    if cash > tonumber(vehiclePrice) then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            cid,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            'pillboxgarage',
            0
        })
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.purchased'), 'success')
        TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        Player.Functions.RemoveMoney('cash', vehiclePrice, 'vehicle-bought-in-showroom')
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Purchase)', 'blue', ('**Customer:** %s | **License:** ||(%s)||\n **Price:** ($%s) | Bank\n **Vehicle:** %s | **Vehicle Plate:** %s '):format(GetPlayerName(src), Player.PlayerData.license, vehiclePrice, vehicle, plate))
    elseif bank > tonumber(vehiclePrice) then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            cid,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            'pillboxgarage',
            0
        })
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.purchased'), 'success')
        TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        Player.Functions.RemoveMoney('bank', vehiclePrice, 'vehicle-bought-in-showroom')
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Purchase)', 'blue', ('**Customer:** %s | **License:** ||(%s)||\n **Price:** ($%s) | Cash\n **Vehicle:** %s | **Vehicle Plate:** %s '):format(GetPlayerName(src), Player.PlayerData.license, vehiclePrice, vehicle, plate))
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
    end
end)

-- file-name : qb-vehicleshop | server.lua
-- line : 243 (may differ mines heavily modified)
-- Replace event-financeVehicle with the one below.
RegisterNetEvent('qb-vehicleshop:server:financeVehicle', function(downPayment, paymentAmount, vehicle)
    local src = source
    downPayment = tonumber(downPayment)
    paymentAmount = tonumber(paymentAmount)
    local Player = QBCore.Functions.GetPlayer(src)
    local cid = Player.PlayerData.citizenid
    local cash = Player.PlayerData.money['cash']
    local bank = Player.PlayerData.money['bank']
    local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
    local timer = (Config.PaymentInterval * 60)
    local minDown = tonumber(round((Config.MinimumDown / 100) * vehiclePrice))
    if downPayment > vehiclePrice then return TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notworth'), 'error') end
    if downPayment < minDown then return TriggerClientEvent('QBCore:Notify', src, Lang:t('error.downtoosmall'), 'error') end
    if paymentAmount > Config.MaximumPayments then return TriggerClientEvent('QBCore:Notify', src, Lang:t('error.exceededmax'), 'error') end
    local plate = GeneratePlate()
    local balance, vehPaymentAmount = calculateFinance(vehiclePrice, downPayment, paymentAmount)
    if cash >= downPayment then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, balance, paymentamount, paymentsleft, financetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            cid,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            'pillboxgarage',
            0,
            balance,
            vehPaymentAmount,
            paymentAmount,
            timer
        })
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.purchased'), 'success')
        TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        Player.Functions.RemoveMoney('cash', downPayment, 'vehicle-bought-in-showroom')
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Finance)', 'blue', ('**Customer:** %s | **License:** ||(%s)||\n **Down Payment:** ($%s) | Cash\n **Vehicle Price:** ($%s)\n **Remaining Payments:** %s\n **Vehicle:** %s | **Vehicle Plate:** %s '):format(GetPlayerName(src), Player.PlayerData.license, downPayment, vehiclePrice, paymentAmount, vehicle, plate))
    elseif bank >= downPayment then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, balance, paymentamount, paymentsleft, financetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            cid,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            'pillboxgarage',
            0,
            balance,
            vehPaymentAmount,
            paymentAmount,
            timer
        })
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.purchased'), 'success')
        TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        Player.Functions.RemoveMoney('bank', downPayment, 'vehicle-bought-in-showroom')
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Finance)', 'blue', ('**Customer:** %s | **License:** ||(%s)||\n **Down Payment:** ($%s) | Bank\n **Vehicle Price:** ($%s)\n **Remaining Payments:** %s\n **Vehicle:** %s | **Vehicle Plate:** %s '):format(GetPlayerName(src), Player.PlayerData.license, downPayment, vehiclePrice, paymentAmount, vehicle, plate))
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
    end
end)

-- file-name : qb-vehicleshop | server.lua
-- line : 303 (may differ mines heavily modified)
-- Replace event-sellShowroomVehicle with the one below.
RegisterNetEvent('qb-vehicleshop:server:sellShowroomVehicle', function(data, playerid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Customer = QBCore.Functions.GetPlayer(tonumber(playerid))

    if not Customer then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.Invalid_ID'), 'error')
        return
    end

    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerid))) < 3 then
        local cid = Customer.PlayerData.citizenid
        local cash = Customer.PlayerData.money['cash']
        local bank = Customer.PlayerData.money['bank']
        local vehicle = data
        local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
        local commission = round(vehiclePrice * Config.Commission)
        local plate = GeneratePlate()
        if cash >= tonumber(vehiclePrice) then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                Customer.PlayerData.license,
                cid,
                vehicle,
                GetHashKey(vehicle),
                '{}',
                plate,
                'pillboxgarage',
                0
            })
            TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', Customer.PlayerData.source, vehicle, plate)
            Customer.Functions.RemoveMoney('cash', vehiclePrice, 'vehicle-bought-in-showroom')
            Player.Functions.AddMoney('bank', commission)
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.earned_commission', {amount = comma_value(commission)}), 'success')
            exports['qb-management']:AddMoney(Player.PlayerData.job.name, vehiclePrice)
            TriggerClientEvent('QBCore:Notify', Customer.PlayerData.source, Lang:t('success.purchased'), 'success')
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Sale)', 'blue', ('**Salesman:** %s | **License:** ||(%s)||\n **Customer:** %s | **License:** ||(%s)||\n **Vehicle Price:** ($%s) Cash | **Commission** %s\n **Vehicle:** %s | **Vehicle Plate:** %s '):format(GetPlayerName(src), Player.PlayerData.license, GetPlayerName(src), Customer.PlayerData.license, vehiclePrice, commission, vehicle, plate))
        elseif bank >= tonumber(vehiclePrice) then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                Customer.PlayerData.license,
                cid,
                vehicle,
                GetHashKey(vehicle),
                '{}',
                plate,
                'pillboxgarage',
                0
            })
            TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', Customer.PlayerData.source, vehicle, plate)
            Customer.Functions.RemoveMoney('bank', vehiclePrice, 'vehicle-bought-in-showroom')
            Player.Functions.AddMoney('bank', commission)
            exports['qb-management']:AddMoney(Player.PlayerData.job.name, vehiclePrice)
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.earned_commission', {amount = comma_value(commission)}), 'success')
            TriggerClientEvent('QBCore:Notify', Customer.PlayerData.source, Lang:t('success.purchased'), 'success')
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Sale)', 'blue', ('**Salesman:** %s | **License:** ||(%s)||\n **Customer:** %s | **License:** ||(%s)||\n **Vehicle Price:** ($%s) Bank | **Commission** %s\n **Vehicle:** %s | **Vehicle Plate:** %s '):format(GetPlayerName(src), Player.PlayerData.license, GetPlayerName(src), Customer.PlayerData.license, vehiclePrice, commission, vehicle, plate))
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.playertoofar'), 'error')
    end
end)

-- file-name : qb-vehicleshop | server.lua
-- line : 366 (may differ mines heavily modified)
-- Replace event-sellfinanceVehicle with the one below.
RegisterNetEvent('qb-vehicleshop:server:sellfinanceVehicle', function(downPayment, paymentAmount, vehicle, playerid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Customer = QBCore.Functions.GetPlayer(tonumber(playerid))

    if not Customer then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.Invalid_ID'), 'error')
        return
    end

    if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(playerid))) < 3 then
        downPayment = tonumber(downPayment)
        paymentAmount = tonumber(paymentAmount)
        local cid = Customer.PlayerData.citizenid
        local cash = Customer.PlayerData.money['cash']
        local bank = Customer.PlayerData.money['bank']
        local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
        local timer = (Config.PaymentInterval * 60)
        local minDown = tonumber(round((Config.MinimumDown / 100) * vehiclePrice))
        if downPayment > vehiclePrice then return TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notworth'), 'error') end
        if downPayment < minDown then return TriggerClientEvent('QBCore:Notify', src, Lang:t('error.downtoosmall'), 'error') end
        if paymentAmount > Config.MaximumPayments then return TriggerClientEvent('QBCore:Notify', src, Lang:t('error.exceededmax'), 'error') end
        local commission = round(vehiclePrice * Config.Commission)
        local plate = GeneratePlate()
        local balance, vehPaymentAmount = calculateFinance(vehiclePrice, downPayment, paymentAmount)
        if cash >= downPayment then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, balance, paymentamount, paymentsleft, financetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
                Customer.PlayerData.license,
                cid,
                vehicle,
                GetHashKey(vehicle),
                '{}',
                plate,
                'pillboxgarage',
                0,
                balance,
                vehPaymentAmount,
                paymentAmount,
                timer
            })
            TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', Customer.PlayerData.source, vehicle, plate)
            Customer.Functions.RemoveMoney('cash', downPayment, 'vehicle-bought-in-showroom')
            Player.Functions.AddMoney('bank', commission)
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.earned_commission', {amount = comma_value(commission)}), 'success')
            exports['qb-management']:AddMoney(Player.PlayerData.job.name, vehiclePrice)
            TriggerClientEvent('QBCore:Notify', Customer.PlayerData.source, Lang:t('success.purchased'), 'success')
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Finance)', 'blue', ('**Salesman:** %s | **License:** ||(%s)||\n **Customer:** %s | **License:** ||(%s)||\n **Vehicle Price:** ($%s) Cash | **Commission** %s\n **Down Payment:** %s | **Remaining Payments:** %s\n **Vehicle:** %s | **Vehicle Plate:** %s '):format(GetPlayerName(src), Player.PlayerData.license, GetPlayerName(src), Customer.PlayerData.license, vehiclePrice, commission, downPayment, paymentAmount, vehicle, plate))
        elseif bank >= downPayment then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, balance, paymentamount, paymentsleft, financetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
                Customer.PlayerData.license,
                cid,
                vehicle,
                GetHashKey(vehicle),
                '{}',
                plate,
                'pillboxgarage',
                0,
                balance,
                vehPaymentAmount,
                paymentAmount,
                timer
            })
            TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', Customer.PlayerData.source, vehicle, plate)
            Customer.Functions.RemoveMoney('bank', downPayment, 'vehicle-bought-in-showroom')
            Player.Functions.AddMoney('bank', commission)
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.earned_commission', {amount = comma_value(commission)}), 'success')
            exports['qb-management']:AddMoney(Player.PlayerData.job.name, vehiclePrice)
            TriggerClientEvent('QBCore:Notify', Customer.PlayerData.source, Lang:t('success.purchased'), 'success')
            TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Dealership (Finance)', 'blue', ('**Salesman:** %s | **License:** ||(%s)||\n **Customer:** %s | **License:** ||(%s)||\n **Vehicle Price:** ($%s) Bank | **Commission** %s\n **Down Payment:** %s | **Remaining Payments:** %s\n **Vehicle:** %s | **Vehicle Plate:** %s '):format(GetPlayerName(src), Player.PlayerData.license, GetPlayerName(src), Customer.PlayerData.license, vehiclePrice, commission, downPayment, paymentAmount, vehicle, plate))
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.notenoughmoney'), 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.playertoofar'), 'error')
    end
end)
  
-- file-name : qb-drugs | server | cornerselling.lua
-- line : 25 (may differ mines heavily modified)
-- Replace event-giveStealItems with the one below.
RegisterNetEvent('qb-drugs:server:giveStealItems', function(drugType, amount)
    local src = source
    local availableDrugs = getAvailableDrugs(src)
    local Player = QBCore.Functions.GetPlayer(src)

    if not availableDrugs or not Player then return end

    local item = availableDrugs[drugType].item

    Player.Functions.AddItem(availableDrugs[drugType].item, amount)
    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Cornersell (Player)', 'white', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Retreived %s stolen %s from npc. '):format(GetPlayerName(src), Player.PlayerData.license, amount, item))
end)

-- file-name : qb-drugs | server | cornerselling.lua
-- line : 38 (may differ mines heavily modified)
-- Replace event-giveStealItems with the one below.
RegisterNetEvent('qb-drugs:server:sellCornerDrugs', function(drugType, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local availableDrugs = getAvailableDrugs(src)

    if not availableDrugs or not Player then return end

    local item = availableDrugs[drugType].item
   
    local hasItem = Player.Functions.GetItemByName(item)
    if hasItem.amount >= amount then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.offer_accepted"), 'success')
        Player.Functions.RemoveItem(item, amount)
        Player.Functions.AddMoney('cash', price, "sold-cornerdrugs")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
        TriggerClientEvent('qb-drugs:client:refreshAvailableDrugs', src, getAvailableDrugs(src))
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Cornersell (Player)', 'white', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Sold %s %s to an npc for ($%s). '):format(GetPlayerName(src), Player.PlayerData.license, amount, item, price))
    else
        TriggerClientEvent('qb-drugs:client:cornerselling', src)
    end 
end)

-- file-name : qb-drugs | server | cornerselling.lua
-- line : 60 (may differ mines heavily modified)
-- Replace event-giveStealItems with the one below.
RegisterNetEvent('qb-drugs:server:robCornerDrugs', function(drugType, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local availableDrugs = getAvailableDrugs(src)

    if not availableDrugs or not Player then return end

    local item = availableDrugs[drugType].item

    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
    TriggerClientEvent('qb-drugs:client:refreshAvailableDrugs', src, getAvailableDrugs(src))
    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Cornersell (Player)', 'white', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Had %s %s stolen by an npc. '):format(GetPlayerName(src), Player.PlayerData.license, amount, item))
end)

-- file-name : qb-doorlock | server.lua
-- line : 319 (may differ mines heavily modified)
-- Replace "newdoor" command with the one below.
QBCore.Commands.Add('newdoor', Lang:t("general.newdoor_command_description"), {}, false, function(source)
	local src = source
	local Staff = QBCore.Functions.GetPlayer(src) 
	TriggerClientEvent('qb-doorlock:client:addNewDoor', src)
	TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Door Create (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Used newdoor Command. '):format(GetPlayerName(src), Staff.PlayerData.license))
end, Config.CommandPermission)

-- file-name : qb-cityhall | server.lua
-- line : 105 (may differ mines heavily modified)
-- Replace "ApplyJob" command with the one below
RegisterNetEvent('qb-cityhall:server:ApplyJob', function(job, cityhallCoords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local ped = GetPlayerPed(src)
    local pedCoords = GetEntityCoords(ped)

    local data = {
        ["src"] = src,
        ["job"] = job
    }
    if #(pedCoords - cityhallCoords) >= 20.0 or not availableJobs[job] then
        return false -- DropPlayer(source, "Attempted exploit abuse")
    end
    if QBCore.Shared.QBJobsStatus then
        exports["qb-jobs"]:submitApplication(data, "Jobs")
    else
        local JobInfo = QBCore.Shared.Jobs[job]
        Player.Functions.SetJob(data.job, 0)
        TriggerClientEvent('QBCore:Notify', data.src, Lang:t('info.new_job', { job = JobInfo.label }))
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Cityhall Job (Player)', 'white', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Applied New Job **%s**. '):format(GetPlayerName(src), Player.PlayerData.license, data.job))
    end
end) 

-- file-name : qb-policejob | server.lua
-- line : 780 (may differ mines heavily modified)
-- Replace JailPlayer with the one below
RegisterNetEvent('police:server:JailPlayer', function(playerId, time)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if not Player or not OtherPlayer or Player.PlayerData.job.name ~= "police" then return end

    local currentDate = os.date("*t")
    if currentDate.day == 31 then
        currentDate.day = 30
    end

    OtherPlayer.Functions.SetMetaData("injail", time)
    OtherPlayer.Functions.SetMetaData("criminalrecord", {
        ["hasRecord"] = true,
        ["date"] = currentDate
    })
    TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
    TriggerClientEvent('QBCore:Notify', src, Lang:t("info.sent_jail_for", {time = time}))
    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Jailing (Player)', 'white', ('**Officer:** %s | **License:** ||(%s)||\n **Job:** %s | **Grade:** %s\n **Citizen:** %s | **License:** ||(%s)||\n **Info:** Jailed Player For %s Months.'):format(GetPlayerName(src), Player.PlayerData.license, Player.PlayerData.job.name, Player.PlayerData.job.grade.level, GetPlayerName(playerId), OtherPlayer.PlayerData.license, time))
end)  

-- file-name : qb-policejob | server.lua
-- line : 672 (may differ mines heavily modified)
-- Replace CuffPlayer with the one below
RegisterNetEvent('police:server:CuffPlayer', function(playerId, isSoftcuff)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local Player = QBCore.Functions.GetPlayer(src)
    local CuffedPlayer = QBCore.Functions.GetPlayer(playerId)
    if not Player or not CuffedPlayer or (not Player.Functions.GetItemByName("handcuffs") and Player.PlayerData.job.name ~= "police") then return end

    TriggerClientEvent("police:client:GetCuffed", CuffedPlayer.PlayerData.source, Player.PlayerData.source, isSoftcuff)
    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Cuffing (Player)', 'white', ('**Officer:** %s | **License:** ||(%s)||\n **Job:** %s | **Grade:** %s\n **Citizen:** %s | **License:** ||(%s)||\n **Info:** Cuffed Player. '):format(GetPlayerName(src), Player.PlayerData.license, Player.PlayerData.job.name, Player.PlayerData.job.grade.level, GetPlayerName(playerId), CuffedPlayer.PlayerData.license))
end)

-- file-name : qb-policejob | client.lua
-- line : 423 (may differ mines heavily modified)
-- Replace EvidenceStashDrawer with the one below
RegisterNetEvent('police:client:EvidenceStashDrawer', function(data)
    local currentEvidence = data.currentEvidence
    local pos = GetEntityCoords(PlayerPedId())
    local takeLoc = Config.Locations["evidence"][currentEvidence]

    local PlayerData = QBCore.Functions.GetPlayerData()
    local fullname = PlayerData.charinfo.firstname.." "..PlayerData.charinfo.lastname
    local cid = PlayerData.citizenid

    if not takeLoc then return end

    if #(pos - takeLoc) <= 1.0 then
        local drawer = exports['qb-input']:ShowInput({
            header = Lang:t('info.evidence_stash', {value = currentEvidence}),
            submitText = "open",
            inputs = {
                {
                    type = 'number',
                    isRequired = true,
                    name = 'slot',
                    text = Lang:t('info.slot')
                }
            }
        })
        if drawer then
            if not drawer.slot then return end
            TriggerServerEvent("inventory:server:OpenInventory", "stash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawer.slot}), {
                maxweight = 4000000,
                slots = 500,
            })
            TriggerEvent("inventory:client:SetCurrentStash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawer.slot}))
            TriggerServerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Evidence Locker (Police)', 'blue', ('**Officer Name:** %s | **Citizen ID:** %s\n **Department:** %s | **Grade:** %s\n **Locker Number:** %s\n **Info:** Officer Accessed Evidence Locker '):format(fullname, cid, PlayerData.job.label, PlayerData.job.grade.level, drawer.slot))
        end
    else
        exports['qb-menu']:closeMenu()
    end
end)

-- file-name : qb-policejob | client.lua
-- line : 478 (may differ mines heavily modified)
-- Replace openArmoury with the one below
RegisterNetEvent('qb-police:client:openArmoury', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local fullname = PlayerData.charinfo.firstname.." "..PlayerData.charinfo.lastname
    local cid = PlayerData.citizenid

    local authorizedItems = {
        label = Lang:t('menu.pol_armory'),
        slots = 30,
        items = {}
    }
    local index = 1
    for _, armoryItem in pairs(Config.Items.items) do
        for i=1, #armoryItem.authorizedJobGrades do
            if armoryItem.authorizedJobGrades[i] == PlayerJob.grade.level then
                authorizedItems.items[index] = armoryItem
                authorizedItems.items[index].slot = index
                index = index + 1
            end
        end
    end
    SetWeaponSeries()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", authorizedItems)
    TriggerServerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Armoury Shop (Police)', 'blue', ('**Officer Name:** %s | **Citizen ID:** %s\n **Department:** %s | **Grade:** %s\n **Info:** Officer Accessed Armoury'):format(fullname, cid, PlayerData.job.label, PlayerData.job.grade.level))
end)

-- file-name : keep-drivingmodes | client.lua
-- line : 41
-- Replace SwitchTheVehicleMode with the one below
-- Also add (local QBCore = exports['qb-core']:GetCoreObject()) to the top of the lua file
function SwitchTheVehicleMode(vehicle)
     local PlayerData = QBCore.Functions.GetPlayerData()
     local fullname = PlayerData.charinfo.firstname.." "..PlayerData.charinfo.lastname 
     
     local playerped = PlayerPedId()
     local Driver = GetPedInVehicleSeat(vehicle, -1)
     if playerped ~= Driver then
          TriggerServerEvent('keep-drivingmodes:server:Notification', "You are not driver of this vehicle!", "error")
          return
     end
     local mode = get_next_state(vehicle)
     if not mode then
          TriggerServerEvent('keep-drivingmodes:server:Notification', "This vehicle do not have modes!", "error")
          return
     end
     local current = mode.current
     local settings = mode.vehicle_settings[current]
     local setting = settings.settings
     local duration = setting.non_handling.duration * 1000

     TriggerServerEvent('keep-drivingmodes:server:Notification', settings.label .. " Enabled", "primary")
     SetVehicleEnginePowerMultiplier(vehicle, setting.non_handling.EnginePowerMultiplier)

     TriggerServerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Vehicle Modes', 'white', ('**Name:** %s \n**CID:** %s\n **Mode:** %s '):format(fullname, PlayerData.citizenid, settings.label))

     CreateThread(function()
          local timeout = 0
          while timeout < setting.non_handling.intrupt_duration do
               SetVehicleCurrentRpm(vehicle, 0)
               timeout = timeout + 1
               Wait(1)
          end
     end)
end
