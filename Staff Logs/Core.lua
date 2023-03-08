-- In here i will show you the file-name, line and what to change.

----------------
---- SERVER ----
----------------

-- file-name : qb-core | commands.lua
-- line : 186 (may differ mines heavily modified)
-- Replace 'car' with the one below.
QBCore.Commands.Add('car', Lang:t("command.car.help"), {{ name = Lang:t("command.car.params.model.name"), help = Lang:t("command.car.params.model.help") }}, true, function(source, args)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Command:SpawnVehicle', src, args[1])
    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Vehicle Spawned (staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Spawned a **%s** '):format(GetPlayerName(src), Staff.PlayerData.license, args[1]))
end, 'admin')

-- file-name : qb-core | commands.lua
-- line : 199 (may differ mines heavily modified)
-- Replace 'givemoney' with the one below.
QBCore.Commands.Add('givemoney', Lang:t("command.givemoney.help"), { { name = Lang:t("command.givemoney.params.id.name"), help = Lang:t("command.givemoney.params.id.help") }, { name = Lang:t("command.givemoney.params.moneytype.name"), help = Lang:t("command.givemoney.params.moneytype.help") }, { name = Lang:t("command.givemoney.params.amount.name"), help = Lang:t("command.givemoney.params.amount.help") } }, true, function(source, args)
    local src = source
    local Target = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Staff = QBCore.Functions.GetPlayer(src)
    if Target then
        Target.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Money Given (staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Gave %s ($%s) '):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(args[1]), Target.PlayerData.license, args[2], args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

-- file-name : qb-core | commands.lua
-- line : 211 (may differ mines heavily modified)
-- Replace 'setmoney' with the one below.
QBCore.Commands.Add('setmoney', Lang:t("command.setmoney.help"), { { name = Lang:t("command.setmoney.params.id.name"), help = Lang:t("command.setmoney.params.id.help") }, { name = Lang:t("command.setmoney.params.moneytype.name"), help = Lang:t("command.setmoney.params.moneytype.help") }, { name = Lang:t("command.setmoney.params.amount.name"), help = Lang:t("command.setmoney.params.amount.help") } }, true, function(source, args)
    local src = source
    local Target = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Staff = QBCore.Functions.GetPlayer(src)
    if Target then
        Target.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Money Set (staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Set %s ($%s) '):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(args[1]), Target.PlayerData.license, args[2], args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

-- file-name : qb-core | commands.lua
-- line : 230 (may differ mines heavily modified)
-- Replace 'setjob' with the one below.
QBCore.Commands.Add('setjob', Lang:t("command.setjob.help"), { { name = Lang:t("command.setjob.params.id.name"), help = Lang:t("command.setjob.params.id.help") }, { name = Lang:t("command.setjob.params.job.name"), help = Lang:t("command.setjob.params.job.help") }, { name = Lang:t("command.setjob.params.grade.name"), help = Lang:t("command.setjob.params.grade.help") } }, true, function(source, args)
    local src = source
    local Target = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Staff = QBCore.Functions.GetPlayer(src)
    if Target then
        Target.Functions.SetJob(tostring(args[2]), tonumber(args[3]))
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Job Set (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Set Job To %s | Grade %s '):format(GetPlayerName(source), Staff.PlayerData.license, GetPlayerName(args[1]), Target.PlayerData.license, args[2], args[3]))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

-- file-name : qb-core | commands.lua
-- line : 249 (may differ mines heavily modified)
-- Replace 'setgang' with the one below.
QBCore.Commands.Add('setgang', Lang:t("command.setgang.help"), { { name = Lang:t("command.setgang.params.id.name"), help = Lang:t("command.setgang.params.id.help") }, { name = Lang:t("command.setgang.params.gang.name"), help = Lang:t("command.setgang.params.gang.help") }, { name = Lang:t("command.setgang.params.grade.name"), help = Lang:t("command.setgang.params.grade.help") } }, true, function(source, args)
    local src = source
    local Target = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Staff = QBCore.Functions.GetPlayer(src)
    if Target then
        Target.Functions.SetGang(tostring(args[2]), tonumber(args[3]))
        TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Gang Set (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Set Gang To %s | Grade %s '):format(GetPlayerName(source), Staff.PlayerData.license, GetPlayerName(args[1]), Target.PlayerData.license, args[2], args[3]))        
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')

-- file-name : qb-core | commands.lua
-- line : 118 (may differ mines heavily modified)
-- Replace 'tpm' with the one below.
QBCore.Commands.Add('tpm', Lang:t("command.tpm.help"), {}, false, function(source)
    local src = source
    local Staff = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Command:GoToMarker', src)
    TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'TPM (staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Info:** Used TPM Command. '):format(GetPlayerName(src), Staff.PlayerData.license))
end, 'admin')
