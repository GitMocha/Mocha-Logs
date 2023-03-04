-- In here i will show you the file-name, line and what to change.

----------------
---- SERVER ----
----------------

-- file-name : qb-inventory | server.lua (can be placed into other inventorys, this is just the one i was using at the time. You may also have other itemData for example "labkey", just make a copy before adding this and then add the missing stuff back)
-- line : 2357 (may differ mines heavily modified)
-- Replace 'giveitem' with the one below.
QBCore.Commands.Add("giveitem", "Give An Item (Admin Only)", {{name="id", help="Player ID"},{name="item", help="Name of the item (not a label)"}, {name="amount", help="Amount of items"}}, false, function(source, args)
	local src = source
	local id = tonumber(args[1])
	local Player = QBCore.Functions.GetPlayer(id)
	local Staff = QBCore.Functions.GetPlayer(src)
	local amount = tonumber(args[3]) or 1
	local itemData = QBCore.Shared.Items[tostring(args[2]):lower()]
	if Player then
			if itemData then
				-- check iteminfo
				local info = {}
				if itemData["name"] == "id_card" then
					info.citizenid = Player.PlayerData.citizenid
					info.firstname = Player.PlayerData.charinfo.firstname
					info.lastname = Player.PlayerData.charinfo.lastname
					info.birthdate = Player.PlayerData.charinfo.birthdate
					info.gender = Player.PlayerData.charinfo.gender
					info.nationality = Player.PlayerData.charinfo.nationality
				elseif itemData["name"] == "driver_license" then
					info.firstname = Player.PlayerData.charinfo.firstname
					info.lastname = Player.PlayerData.charinfo.lastname
					info.birthdate = Player.PlayerData.charinfo.birthdate
					info.type = "Class C Driver License"
				elseif itemData["type"] == "weapon" then
					amount = 1
					info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
					info.quality = 100
				elseif itemData["name"] == "harness" then
					info.uses = 20
				elseif itemData["name"] == "markedbills" then
					info.worth = math.random(5000, 10000)
				elseif itemData["name"] == "labkey" then
					info.lab = exports["qb-methlab"]:GenerateRandomLab()
				elseif itemData["name"] == "printerdocument" then
					info.url = "https://cdn.discordapp.com/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png"
				end

				if AddItem(id, itemData["name"], amount, false, info) then
					TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Item Given (Staff)', 'white', ('**Name:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Item Given %s | Amount %s '):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(args[1])), Player.PlayerData.license, itemData["name"], amount))
					QBCore.Functions.Notify(source, "You Have Given " ..GetPlayerName(id).." "..amount.." "..itemData["name"].. "", "success")
				else
					QBCore.Functions.Notify(source,  Lang:t("notify.cgitem"), "error")
				end
			else
				QBCore.Functions.Notify(source,  Lang:t("notify.idne"), "error")
			end
	else
		QBCore.Functions.Notify(source,  Lang:t("notify.pdne"), "error")
	end
end, "admin")

-- file-name : qb-inventory | server.lua (can be placed into other inventorys)
-- line : 2428 (may differ mines heavily modified)
-- Replace 'clearinv' with the one below.
QBCore.Commands.Add('clearinv', 'Clear Players Inventory (Admin Only)', { { name = 'id', help = 'Player ID' } }, false, function(source, args)
	local src = source
    local playerId = args[1] ~= '' and tonumber(args[1]) or source
    local Player = QBCore.Functions.GetPlayer(playerId)
    local Staff = QBCore.Functions.GetPlayer(src)
    if Player then
        ClearInventory(playerId)
		TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Inventory Cleared (Staff)', 'white', ('**Staff:** %s | **License:** ||(%s)||\n **Player:** %s | **License:** ||(%s)||\n **Info:** Cleared Player Inventory'):format(GetPlayerName(src), Staff.PlayerData.license, GetPlayerName(tonumber(args[1])), Player.PlayerData.license))
    else
        QBCore.Functions.Notify(source, "Player not online", 'error')
    end
end, 'admin')