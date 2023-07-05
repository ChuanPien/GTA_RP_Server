ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('shrimp', function(source)

	local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)

	local cops = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end

	if cops >= 1 then
		TriggerClientEvent('fishing:setbait', _source, "turtle")

		xPlayer.removeInventoryItem('shrimp', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '蝦仁'})
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '警察不足'})
	end
end)

ESX.RegisterUsableItem('fishbait', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('fishing:setbait', _source, "fish")
	xPlayer.removeInventoryItem('fishbait', 1)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '蚯蚓'})
end)

ESX.RegisterUsableItem('fishmeat', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('fishing:setbait', _source, "fishmeat")
	xPlayer.removeInventoryItem('fishmeat', 1)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '鯛魚肉塊'})
end)

ESX.RegisterUsableItem('turtlemeat', function(source)
	local xPlayers = ESX.GetPlayers()
	local CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	if CopsConnected >= 1 then
		TriggerClientEvent('fishing:overpoint', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '警察不足'})
	end
end)

RegisterNetEvent('fishing:canoverfish')
AddEventHandler('fishing:canoverfish', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('turtlemeat', 1)
	TriggerClientEvent('fishing:setbait', _source, "shark")
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '海龜肉'})
end)

ESX.RegisterUsableItem('fishingrod', function(source)
	local _source = source

	TriggerClientEvent('fishing:fishstart', _source)
end)

ESX.RegisterServerCallback('fishing:getitem',function (source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getInventoryItem('fishingrod').count <= 0 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterNetEvent('fishing:catchfish')
AddEventHandler('fishing:catchfish', function(bait)
	local _source = source
	local rnd = math.random(1,100)
	local chance = math.random(1,10)
	local big = math.random(4,7)
	local small = math.random(1,4)
	local xPlayer = ESX.GetPlayerFromId(_source)

	if bait == "turtle" then
		if rnd >= 90 then
			xPlayer.removeInventoryItem('fishingrod', 1)
			TriggerClientEvent('fishing:break', _source)
			TriggerClientEvent('fishing:setbait', _source, "none")
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '釣竿損壞'})
		elseif rnd >= 84 and rnd <= 89 then
			if xPlayer.getInventoryItem('turtle').count > 2 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '海龜已滿'})
			else
				xPlayer.addInventoryItem('turtle', 1)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '1隻海龜'})
				TriggerEvent('esx_joblogs:AddInLog', "crime", "fish", xPlayer.name,"海龜")
			end
			TriggerClientEvent('fishing:setbait', _source, "none")
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
		elseif rnd >= 49 and rnd <= 79 then
			if xPlayer.getInventoryItem('fish4').count >= 500 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '白帶魚已滿'})
			else
				xPlayer.addInventoryItem('fish4', small)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  small .. '條白帶魚'})
				if chance > 6 then
					TriggerClientEvent('fishing:setbait', _source, "none")
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
				end
			end
		else
			if xPlayer.getInventoryItem('fish').count >= 1000 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '鯛魚已滿'})
			else
				xPlayer.addInventoryItem('fish', big)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條鯛魚'})
				if chance > 6 then
					TriggerClientEvent('fishing:setbait', _source, "none")
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
				end
			end
		end
	end

	if bait == "fishmeat" then
		if rnd >= 86 then
			if xPlayer.getInventoryItem('lobster').count >= 500 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '龍蝦已滿'})
			else
				xPlayer.addInventoryItem('lobster', 1)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  '1隻龍蝦'})
			end
		elseif rnd >= 41 and rnd <= 85 then
			if xPlayer.getInventoryItem('polvo').count >= 500 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '章魚已滿'})
			else
				xPlayer.addInventoryItem('polvo', 1)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "1隻章魚"})
			end
		elseif rnd <= 40 then
			if xPlayer.getInventoryItem('turtlebait').count >= 500 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '蝦子已滿'})
			else
				xPlayer.addInventoryItem('turtlebait', big)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '隻蝦'})
			end
		end
		TriggerClientEvent('fishing:setbait', _source, "none")
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
	end

	if bait == "fish" then
		if rnd >= 85 then
			if xPlayer.getInventoryItem('turtlebait').count >= 500 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '蝦子已滿'})
			else
				xPlayer.addInventoryItem('turtlebait', small)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  small .. '隻蝦'})
			end
		elseif rnd >= 60 and rnd <= 84 then
			if xPlayer.getInventoryItem('fish').count >= 1000 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '鯛魚已滿'})
			else
				xPlayer.addInventoryItem('fish', big)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條鯛魚'})
			end
		elseif rnd >= 36 and rnd <= 59 then
			if xPlayer.getInventoryItem('fish1').count >= 1000 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '沙丁魚已滿'})
			else
				xPlayer.addInventoryItem('fish1', big)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條沙丁魚'})
			end
		else
			if xPlayer.getInventoryItem('fish2').count >= 1000 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '鯖魚已滿'})
			else
				xPlayer.addInventoryItem('fish2', big)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條鯖魚'})
			end
		end
		if chance >= 8 then
			TriggerClientEvent('fishing:setbait', _source, "none")
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
		end
	end

	if bait == "none" then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '未掛餌料'})
		if rnd >= 60 then
			if xPlayer.getInventoryItem('fish').count >= 1000 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '鯛魚已滿'})
			else
				xPlayer.addInventoryItem('fish', 1)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  '1條鯛魚'})
			end
		else
			if xPlayer.getInventoryItem('turtlebait').count > 500 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '蝦子已滿'})
			else
				xPlayer.addInventoryItem('turtlebait', 1)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  '1隻蝦子'})
			end
		end
	end
end)

ESX.RegisterUsableItem('oyster', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local a = math.random(0,100)
	local chance = math.random(0,10)

	if xPlayer.getInventoryItem('oysterknife').count >= 1 then
		xPlayer.removeInventoryItem('oyster', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '牡蠣'})
		if a <= 2 then
			xPlayer.addInventoryItem('pearl', 1)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '珍珠'})
		elseif a >= 3 and a <= 80 then
			xPlayer.addInventoryItem('oyster2', 1)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '蛤蜊肉'})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '空殼'})
		end
		if chance <= 2 then
			xPlayer.removeInventoryItem('oyster', 1)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '工具損壞'})
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '無生蠔刀'})
	end
end)

RegisterServerEvent('fishing:setautobait')
AddEventHandler('fishing:setautobait', function(autobait)
    local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)
	local yes = false

	local cops = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end

	if xPlayer.getInventoryItem(autobait).count > 0 then
		if autobait == 'fishbait' then
			TriggerClientEvent('fishing:setbait', _source, "fish")
			yes = true
		elseif autobait == 'fishmeat' then
			TriggerClientEvent('fishing:setbait', _source, "fishmeat")
			yes = true
		elseif autobait == 'shrimp' then
			if cops >= 1 then
				TriggerClientEvent('fishing:setbait', _source, "turtle")
				yes = true
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '警察不足'})
			end
		elseif autobait == 'turtlemeat' then
			if cops >= 1 then
				TriggerClientEvent('fishing:overpoint', source)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '警察不足'})
			end
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '無餌料'})
	end

	if yes == true then
		xPlayer.removeInventoryItem(autobait, 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ESX.GetItemLabel(autobait)})
	end
end)

RegisterServerEvent('fishing:weed')
AddEventHandler('fishing:weed', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local count = math.random(3,6)

	if xPlayer.getInventoryItem("weed").count >= 6 then
		if xPlayer.getInventoryItem("box").count >= 1 then
			if xPlayer.canCarryItem("weed_pooch",1) then
				xPlayer.removeInventoryItem("weed",count)
				xPlayer.removeInventoryItem("box",1)
				xPlayer.addInventoryItem("weed_pooch",1)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = count .. '大麻'})
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '1紙箱'})
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '1包裝大麻'})
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '過重'})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '材料不足'})
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '材料不足'})
	end
end)

