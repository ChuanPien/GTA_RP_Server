ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

---食物

ESX.RegisterUsableItem('burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('burger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 2000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '漢堡'})
end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 1000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '麵包'})
end)

ESX.RegisterUsableItem('ovoes', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('ovoes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 1250)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '煎蛋'})
end)

ESX.RegisterUsableItem('bolcacahuetes', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bolcacahuetes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '花生'})
end)

ESX.RegisterUsableItem('bolnoixcajou', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bolnoixcajou', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '鹹花生'})
end)

ESX.RegisterUsableItem('bolchips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bolchips', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '炸薯條'})
end)

ESX.RegisterUsableItem('bolpistache', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bolpistache', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '開心果'})
end)

ESX.RegisterUsableItem('polvogre', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('polvogre', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 1750)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '章魚燒'})
end)

ESX.RegisterUsableItem('saucisson', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('saucisson', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 1500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '香腸'})
end)

ESX.RegisterUsableItem('meatass', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meatass', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 2250)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '烤牛肉'})
end)

ESX.RegisterUsableItem('tomate', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('tomate', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '翻茄'})
end)

ESX.RegisterUsableItem('grapperaisin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('grapperaisin', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '葡萄'})
end)

ESX.RegisterUsableItem('friedchicken', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('friedchicken', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 3000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '炸雞排'})
end)

---水

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)
	xPlayer.addInventoryItem('bottle', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '礦泉水'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '寶特瓶'})
end)

ESX.RegisterUsableItem('energy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('energy', 1)
	xPlayer.addInventoryItem('tincan', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 2000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '能量飲料'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '鐵罐'})
end)

ESX.RegisterUsableItem('icetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('icetea', 1)
	xPlayer.addInventoryItem('tincan', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1500)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '冰茶'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '鐵罐'})
end)

ESX.RegisterUsableItem('limonade', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('limonade', 1)
	xPlayer.addInventoryItem('bottle', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1500)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '檸檬汽水'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '寶特瓶'})
end)

ESX.RegisterUsableItem('jusfruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('jusfruit', 1)
	xPlayer.addInventoryItem('bottle', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1500)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '水果茶'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '寶特瓶'})
end)

ESX.RegisterUsableItem('milk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('milk', 1)
	xPlayer.addInventoryItem('glassjar', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1500)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '牛奶'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '玻璃罐'})
end)

ESX.RegisterUsableItem('tea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('tea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '純喫茶'})
end)

-- 飲料機

ESX.RegisterUsableItem('cola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cola', 1)
	xPlayer.addInventoryItem('tincan', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '可口可樂'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '鐵罐'})
end)

ESX.RegisterUsableItem('drpepper', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('drpepper', 1)
	xPlayer.addInventoryItem('tincan', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '胡椒博士'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '鐵罐'})
end)

ESX.RegisterUsableItem('fanta', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fanta', 1)
	xPlayer.addInventoryItem('tincan', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '芬達'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '鐵罐'})
end)

ESX.RegisterUsableItem('heysong', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('heysong', 1)
	xPlayer.addInventoryItem('tincan', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '黑松沙士'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '鐵罐'})
end)

ESX.RegisterUsableItem('pepsi', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pepsi', 1)
	xPlayer.addInventoryItem('tincan', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '百事可樂'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '鐵罐'})
end)

ESX.RegisterUsableItem('sprite', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sprite', 1)
	xPlayer.addInventoryItem('tincan', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '雪碧'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '鐵罐'})
end)

---酒

ESX.RegisterUsableItem('jager', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('jager', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1500)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:onPot', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '野格'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'note', text = '感到有點醉'})
end)

ESX.RegisterUsableItem('martini', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('martini', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1500)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:onPot', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '馬丁尼'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'note', text = '感到有點醉'})
end)

ESX.RegisterUsableItem('rhum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('rhum', 1)
	
	TriggerClientEvent('esx_status:add', source, 'thirst', 1500)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:onPot', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '蘭姆'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'note', text = '感到有點醉'})
end)

ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1500)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:onPot', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '龍舌蘭'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'note', text = '感到有點醉'})
end)

ESX.RegisterUsableItem('whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1500)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:onPot', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '威士忌'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'note', text = '感到有點醉'})
end)

ESX.RegisterUsableItem('vodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vodka', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1500)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:onPot', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '伏特加'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'note', text = '感到有點醉'})
end)

-- 食物水

ESX.RegisterUsableItem('noodle1', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('noodle1', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1250)
	TriggerClientEvent('esx_status:add', source, 'hunger', 1500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '來一客'})
end)

ESX.RegisterUsableItem('noodle2', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('noodle2', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1250)
	TriggerClientEvent('esx_status:add', source, 'hunger', 1500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '滿漢大餐'})
end)

ESX.RegisterUsableItem('noodle3', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('noodle3', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1250)
	TriggerClientEvent('esx_status:add', source, 'hunger', 1500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '大乾麵'})
end)

ESX.RegisterUsableItem('noodle4', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('noodle4', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1250)
	TriggerClientEvent('esx_status:add', source, 'hunger', 1500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '排骨雞麵'})
end)

ESX.RegisterUsableItem('noodle5', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('noodle5', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 1250)
	TriggerClientEvent('esx_status:add', source, 'hunger', 1500)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '一度贊'})
end)

-- Bullet-Proof Vest

ESX.RegisterUsableItem('armor', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_basicneeds:armor', source)
	
	xPlayer.removeInventoryItem('armor', 1)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '破爛防彈衣'})

end)

ESX.RegisterUsableItem('armor1', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_basicneeds:armor1', source)

	xPlayer.removeInventoryItem('armor1', 1)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '初階防彈衣'})

end)

ESX.RegisterUsableItem('armor2', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_basicneeds:armor2', source)

	xPlayer.removeInventoryItem('armor2', 1)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '中階防彈衣'})

end)

ESX.RegisterUsableItem('armor3', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_basicneeds:armor3', source)

	xPlayer.removeInventoryItem('armor3', 1)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '高階防彈衣'})

end)

-- End of Bullet Proof Vest

ESX.RegisterCommand({"h"}, 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

ESX.RegisterCommand({"sh"}, 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:shPlayer')
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

--降落傘
ESX.RegisterUsableItem('parachute', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('esx_basicneeds:parachute', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '降落傘'})
	xPlayer.removeInventoryItem('parachute', 1)

end)

-- ESX.RegisterUsableItem('copper_plates', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
	
-- 	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '銅板堆'})
-- 	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '20銅板'})
-- 	xPlayer.removeInventoryItem('copper_plates', 1)
-- 	xPlayer.addInventoryItem('copper_plate', 20)

-- end)

-- ESX.RegisterUsableItem('iron_plates', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '鐵板堆'})
-- 	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '20鐵板'})
-- 	xPlayer.removeInventoryItem('iron_plates', 1)
-- 	xPlayer.addInventoryItem('iron_plate', 20)

-- end)

-- ESX.RegisterUsableItem('steel_plates', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '鋼板堆'})
-- 	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '20鋼板'})
-- 	xPlayer.removeInventoryItem('steel_plates', 1)
-- 	xPlayer.addInventoryItem('steel_plate', 20)

-- end)

-- ESX.RegisterUsableItem('steels', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '鋼錠堆'})
-- 	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '20鋼錠'})
-- 	xPlayer.removeInventoryItem('steels', 1)
-- 	xPlayer.addInventoryItem('steel', 20)

-- end)
