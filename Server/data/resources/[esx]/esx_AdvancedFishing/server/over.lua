ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('fishing:overcatch')
AddEventHandler('fishing:overcatch', function(bait)
	local _source = source
	local rnd = math.random(1,100)
	local chance = math.random(1,10)
	local big = math.random(4,6)
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Server TEST | bait = ' .. bait})

	if bait == "turtle" then
		if rnd >= 95 then
			xPlayer.removeInventoryItem('fishingrod', 1)
			TriggerClientEvent('fishing:break', _source)
			TriggerClientEvent('fishing:setbait', _source, "none")
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '釣竿損壞'})
		elseif rnd >= 80 and rnd <= 94 then
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
				xPlayer.addInventoryItem('fish4', big)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條白帶魚'})
				if chance > 9 then
					TriggerClientEvent('fishing:setbait', _source, "none")
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
				end
			end
		elseif rnd >= 30 and rnd <= 49 then
			if xPlayer.getInventoryItem('fish5').count >= 500 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '大口黑鱸已滿'})
			else
				xPlayer.addInventoryItem('fish5', 1)
				TriggerClientEvent('fishing:setbait', _source, "none")
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  '1條大口黑鱸'})
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
			end
		else
			if xPlayer.getInventoryItem('fish').count >= 1000 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '鯛魚已滿'})
			else
				xPlayer.addInventoryItem('fish', big)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條鯛魚'})
				if chance == 10 then
					TriggerClientEvent('fishing:setbait', _source, "none")
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
				end
			end
		end
	end

	if bait == "fishmeat" then
		if rnd >= 96 then
			xPlayer.removeInventoryItem('fishingrod', 1)
			TriggerClientEvent('fishing:break', _source)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '釣竿損壞'})
		elseif rnd >= 80 and rnd <= 95 then
			if xPlayer.getInventoryItem('fish6').count >= 200 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '龍膽石斑已滿'})
			else
				xPlayer.addInventoryItem('fish6', 1)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  '1條龍膽石斑'})
			end
		elseif rnd >= 55 and rnd <= 79 then
			if xPlayer.getInventoryItem('fish3').count >= 200 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '黃鰭鮪魚已滿'})
			else
				xPlayer.addInventoryItem('fish3', 1)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "1條黃鰭鮪魚"})
			end
		elseif rnd >= 20 and rnd <= 54 then
			if xPlayer.getInventoryItem('fish5').count >= 500 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '大口黑鱸已滿'})
			else
				xPlayer.addInventoryItem('fish5', 1)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  '1條大口黑鱸'})
			end
		else
			if xPlayer.getInventoryItem('fish4').count >= 500 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '白帶魚已滿'})
			else
				xPlayer.addInventoryItem('fish4', big)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條白帶魚'})
			end
		end
		TriggerClientEvent('fishing:setbait', _source, "none")
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
	end

	if bait == "fish" then
		if rnd >= 80 then
			if xPlayer.getInventoryItem('turtlebait').count >= 500 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '蝦子已滿'})
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '隻蝦'})
				xPlayer.addInventoryItem('turtlebait', big)
			end
		elseif rnd >= 56 and rnd <= 71 then
			if xPlayer.getInventoryItem('fish4').count >= 1000 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '白帶魚已滿'})
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條白帶魚'})
				xPlayer.addInventoryItem('fish4', big)
			end
		elseif rnd >= 20 and rnd <= 55 then
			if xPlayer.getInventoryItem('fish1').count >= 1000 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '沙丁魚已滿'})
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條沙丁魚'})
				xPlayer.addInventoryItem('fish1', big)
			end
		else
			if xPlayer.getInventoryItem('fish2').count >= 1000 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '鯖魚已滿'})
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條鯖魚'})
				xPlayer.addInventoryItem('fish2', big)
			end
		end
		if chance < 2 or chance > 9 then
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

	if bait == "shark" then
		if rnd >= 90 then
			xPlayer.removeInventoryItem('fishingrod', 1)
			TriggerClientEvent('fishing:break', _source)
			TriggerClientEvent('fishing:setbait', _source, "none")
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '釣竿損壞'})
		elseif rnd >= 80 and rnd <= 89 then
			if xPlayer.getInventoryItem('shark').count > 1 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '鯊魚已滿'})
			else
				xPlayer.addInventoryItem('shark', 1)
				TriggerClientEvent('fishing:spawnPed', _source)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '1條鯊魚'})
				TriggerEvent('esx_joblogs:AddInLog', "crime", "fish", xPlayer.name,"鯊魚")
			end
			TriggerClientEvent('fishing:setbait', _source, "none")
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
		elseif rnd >= 56 and rnd <= 79 then
			if xPlayer.getInventoryItem('fish6').count >= 200 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '龍膽石斑已滿'})
			else
				xPlayer.addInventoryItem('fish6', 1)
				TriggerClientEvent('fishing:setbait', _source, "none")
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "1隻龍膽石斑"})
			end
		elseif rnd >= 25 and rnd <= 55 then
			if xPlayer.getInventoryItem('fish3').count >= 200 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '黃鰭鮪魚已滿'})
			else
				xPlayer.addInventoryItem('fish3', 1)
				TriggerClientEvent('fishing:setbait', _source, "none")
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "1條黃鰭鮪魚"})
			end
		else
			if xPlayer.getInventoryItem('fish2').count >= 1000 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '鯖魚已滿'})
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text =  big .. '條鯖魚'})
				xPlayer.addInventoryItem('fish2', big)
				if chance > 8 then
					TriggerClientEvent('fishing:setbait', _source, "none")
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '餌料空'})
				end
			end
		end
	end
end)