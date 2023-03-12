-- In here i will show you the file-name, line and what to change.

-- file-name : ps-drugprocessing | server | chemicals.lua
-- line : 3
-- Replace pickedUpChemicals with the one below.
RegisterServerEvent('ps-drugprocessing:pickedUpChemicals', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("chemicals", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicals"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.chemicals"), "success")
		TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Chemicals)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Chemical Container From Chemical Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

-- file-name : ps-drugprocessing | server | chemicals.lua
-- line : 14
-- Replace processHydrochloric_acid with the one below.
RegisterServerEvent('ps-drugprocessing:processHydrochloric_acid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('hydrochloric_acid', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['hydrochloric_acid'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.hydrochloric_acid"), "success")
			TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Chemicals)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Container Into Hydrochloric Acid'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

-- file-name : ps-drugprocessing | server | chemicals.lua
-- line : 32
-- Replace processsodium_hydroxide with the one below.
RegisterServerEvent('ps-drugprocessing:processsodium_hydroxide', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('sodium_hydroxide', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sodium_hydroxide'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.sodium_hydroxide"), "success")
			TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Chemicals)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Container Into Sodium Hydroxide'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

-- file-name : ps-drugprocessing | server | chemicals.lua
-- line : 50
-- Replace processprocess_sulfuric_acid with the one below.
RegisterServerEvent('ps-drugprocessing:processprocess_sulfuric_acid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('sulfuric_acid', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sulfuric_acid'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.sulfuric_acid"), "success")
			TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Chemicals)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n  **Info:** Processed Container Into Sulfuric Acid'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

-- file-name : ps-drugprocessing | server | chemicals.lua
-- line : 68
-- Replace process_lsa with the one below.
RegisterServerEvent('ps-drugprocessing:process_lsa', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('lsa', 1) then 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsa'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.lsa"), "success")
			TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Chemicals)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n  **Info:** Processed Container Into LSA'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

----------------------------------------------------------------------------

-- file-name : ps-drugprocessing | server | coke.lua
-- line : 3
-- Replace pickedUpCocaLeaf with the one below.
RegisterServerEvent('ps-drugprocessing:pickedUpCocaLeaf', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("coca_leaf", 1) then 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["coca_leaf"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coca_leaf"), "success")
		TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Coke)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Coke Leaf From Coke Plant Location'):format(GetPlayerName(src), Player.PlayerData.license))
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_coca_leaf"), "error")
	end
end)

-- file-name : ps-drugprocessing | server | coke.lua
-- line : 16
-- Replace processCocaLeaf with the one below.
RegisterServerEvent('ps-drugprocessing:processCocaLeaf', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('coca_leaf', Config.CokeProcessing.CokeLeaf) then
		if Player.Functions.AddItem('coke', Config.CokeProcessing.ProcessCokeLeaf) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove", Config.CokeProcessing.CokeLeaf)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "add", Config.CokeProcessing.ProcessCokeLeaf)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke"), "success")
			TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Coke)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Coke Leaf Into Coke'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('coca_leaf', Config.CokeProcessing.CokeLeaf)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_coca_leaf"), "error")
	end
end)

-- file-name : ps-drugprocessing | server | coke.lua
-- line : 34
-- Replace processCocaPowder with the one below.
RegisterServerEvent('ps-drugprocessing:processCocaPowder', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('coke', Config.CokeProcessing.Coke) then
		if Player.Functions.RemoveItem('bakingsoda', Config.CokeProcessing.BakingSoda) then
			if Player.Functions.AddItem('coke_small_brick', Config.CokeProcessing.SmallCokeBrick) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "remove", Config.CokeProcessing.Coke)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", Config.CokeProcessing.BakingSoda)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke_small_brick'], "add", Config.CokeProcessing.SmallCokeBrick)
				TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke_small_brick"), "success")
				TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Coke)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Coke and Baking Soda Into Small Brick'):format(GetPlayerName(src), Player.PlayerData.license))
			else
				Player.Functions.AddItem('coke', Config.CokeProcessing.Coke)
				Player.Functions.AddItem('bakingsoda', Config.CokeProcessing.BakingSoda)
			end
		else
			Player.Functions.AddItem('coke', Config.CokeProcessing.Coke)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_bakingsoda"), "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_cokain"), "error")
	end
end)

-- file-name : ps-drugprocessing | server | coke.lua
-- line : 59
-- Replace processCocaBrick with the one below.
RegisterServerEvent('ps-drugprocessing:processCocaBrick', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('coke_small_brick', Config.CokeProcessing.SmallBrick) then
		if Player.Functions.AddItem('coke_brick', Config.CokeProcessing.LargeBrick) then
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['coke_small_brick'], "remove", Config.CokeProcessing.SmallBrick)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['coke_brick'], "add", Config.CokeProcessing.LargeBrick)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke_brick"), "success")
			TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Coke)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Small Brick Into Large Brick'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('coke_small_brick', Config.CokeProcessing.SmallBrick)
		end
	end
end)

----------------------------------------------------------------------------

-- file-name : ps-drugprocessing | server | heroin.lua
-- line : 3
-- Replace pickedUpPoppy with the one below.
RegisterServerEvent('ps-drugprocessing:pickedUpPoppy', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("poppyresin", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["poppyresin"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.poppyresin"), "success")
		TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Heroin)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Poppy From Poppy Plant Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

-- file-name : ps-drugprocessing | server | heroin.lua
-- line : 14
-- Replace processPoppyResin with the one below.
RegisterServerEvent('ps-drugprocessing:processPoppyResin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('poppyresin', Config.HeroinProcessing.Poppy) then
		if Player.Functions.AddItem('heroin', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove", Config.HeroinProcessing.Poppy)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.heroin"), "success")
			TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Heroin)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Poppy Into Heroin'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('poppyresin', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_poppy_resin"), "error")
	end
end)

----------------------------------------------------------------------------

-- file-name : ps-drugprocessing | server | lsd.lua
-- line : 3
-- Replace Processlsd with the one below.
RegisterServerEvent('ps-drugprocessing:Processlsd', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem("lsa", 1) then
		if Player.Functions.RemoveItem("thionyl_chloride", 1) then
			if Player.Functions.AddItem("lsd", 1) then
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["lsd"], "add")
				TriggerClientEvent('QBCore:Notify', src, Lang:t("success.lsd"), "success")
				TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (LSD)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed LSA Into LSD'):format(GetPlayerName(src), Player.PlayerData.license))
			else
				Player.Functions.AddItem("lsa", 1)
				Player.Functions.AddItem("thionyl_chloride", 1)
			end
		else
			Player.Functions.AddItem("lsa", 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_thionyl_chloride"), "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_lsa"), "error")
	end
end)

-- file-name : ps-drugprocessing | server | lsd.lua
-- line : 26
-- Replace processThionylChloride with the one below.
RegisterServerEvent('ps-drugprocessing:processThionylChloride', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem("lsa", 1) then
		if Player.Functions.RemoveItem("chemicals", 1) then
			if Player.Functions.AddItem("thionyl_chloride", 1) then
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["thionyl_chloride"], "add")
				TriggerClientEvent('QBCore:Notify', src, Lang:t("success.thionyl_chloride"), "success")
				TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (LSD)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Chemicals Into Thionyl Chloride'):format(GetPlayerName(src), Player.PlayerData.license))
			else
				Player.Functions.AddItem("lsa", 1)
				Player.Functions.AddItem("chemicals", 1)
			end
		else
			Player.Functions.AddItem("lsa", 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_lsa"), "error")
	end
end)

----------------------------------------------------------------------------

-- file-name : ps-drugprocessing | server | meth.lua
-- line : 3
-- Replace pickedUpHydrochloricAcid with the one below.
RegisterServerEvent('ps-drugprocessing:pickedUpHydrochloricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("hydrochloric_acid", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["hydrochloric_acid"], "add")
		TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Meth)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Hydrochloric Acid From Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

-- file-name : ps-drugprocessing | server | meth.lua
-- line : 13
-- Replace pickedUpSodiumHydroxide with the one below.
RegisterServerEvent('ps-drugprocessing:pickedUpSodiumHydroxide', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("sodium_hydroxide", 1) then 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sodium_hydroxide"], "add")
		TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Meth)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Sodium Hydroxide From Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

-- file-name : ps-drugprocessing | server | meth.lua
-- line : 23
-- Replace pickedUpSulfuricAcid with the one below.
RegisterServerEvent('ps-drugprocessing:pickedUpSulfuricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("sulfuric_acid", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sulfuric_acid"], "add")
		TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Meth)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Sulfuric Acid From Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

-- file-name : ps-drugprocessing | server | meth.lua
-- line : 33
-- Replace processChemicals with the one below.
RegisterServerEvent('ps-drugprocessing:processChemicals', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem("sulfuric_acid", Config.MethProcessing.SulfAcid) then
		if Player.Functions.RemoveItem("hydrochloric_acid", Config.MethProcessing.HydAcid) then
			if Player.Functions.RemoveItem("sodium_hydroxide", Config.MethProcessing.SodHyd) then
				if Player.Functions.AddItem("liquidmix", 1) then
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sulfuric_acid"], "remove", Config.MethProcessing.SulfAcid)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["hydrochloric_acid"], "remove", Config.MethProcessing.HydAcid)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sodium_hydroxide"], "remove", Config.MethProcessing.SodHyd)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["liquidmix"], "add", 1)
					TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Meth)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Items Into Liquid Mix'):format(GetPlayerName(src), Player.PlayerData.license))
				else
					Player.Functions.AddItem("sulfuric_acid", Config.MethProcessing.SulfAcid)
					Player.Functions.AddItem("hydrochloric_acid", Config.MethProcessing.HydAcid)
					Player.Functions.AddItem("sodium_hydroxide", Config.MethProcessing.SodHyd)
				end
			else
				Player.Functions.AddItem("sulfuric_acid", Config.MethProcessing.SulfAcid)
				Player.Functions.AddItem("hydrochloric_acid", Config.MethProcessing.HydAcid)
				TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_sodium_hydroxide"), "error")
			end
		else
			Player.Functions.AddItem("sulfuric_acid", Config.MethProcessing.SulfAcid)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_hydrochloric_acid"), "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_sulfuric_acid"), "error")
	end

end)

-- file-name : ps-drugprocessing | server | meth.lua
-- line : 99
-- Replace processMeth with the one below.
RegisterServerEvent('ps-drugprocessing:processMeth', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem("methtray", 1) then
		if Player.Functions.AddItem("meth", Config.MethProcessing.Meth) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["methtray"], "remove")
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth"], "add", Config.MethProcessing.Meth)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.meth"), "success")
			TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Meth)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed And Received Meth'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem("methtray", 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicalvapor"), "error")
	end
end)

----------------------------------------------------------------------------

-- file-name : ps-drugprocessing | server | weed.lua
-- line : 3
-- Replace pickedUpCannabis with the one below.
RegisterServerEvent('ps-drugprocessing:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("cannabis", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cannabis"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.cannabis"), "success")
		TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Weed)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Cannabis From Weed Plant Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

-- file-name : ps-drugprocessing | server | weed.lua
-- line : 14
-- Replace processCannabis with the one below.
RegisterServerEvent('ps-drugprocessing:processCannabis', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('cannabis', 1) then
		if Player.Functions.AddItem('marijuana', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.marijuana"), "success")
			TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Weed)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Cannabis Into Marijuana'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('cannabis', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_cannabis"), "error")
	end
end)

-- file-name : ps-drugprocessing | server | weed.lua
-- line : 32
-- Replace rollJoint with the one below.
RegisterServerEvent('ps-drugprocessing:rollJoint', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('marijuana', 1) then
		if Player.Functions.RemoveItem('rolling_paper', 1) then
			if Player.Functions.AddItem('joint', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['rolling_paper'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint'], "add")
				TriggerClientEvent('QBCore:Notify', src, Lang:t("success.joint"), "success")
				TriggerEvent('qb-log:server:CreateLog', 'ChangeMe', 'Drug Processing (Weed)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Rolled Joint Using Marijuana'):format(GetPlayerName(src), Player.PlayerData.license))
			else
				Player.Functions.AddItem('marijuana', 1)
				Player.Functions.AddItem('rolling_paper', 1)
			end
		else
			Player.Functions.AddItem('marijuana', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_marijuhana"), "error")
	end
end)


 