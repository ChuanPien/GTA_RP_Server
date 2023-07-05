ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('vb-banking:server:GetPlayerName', function(source, cb)
	local _char = ESX.GetPlayerFromId(source)
	local _charname = _char.getName()
	cb(_charname)
end)

RegisterServerEvent('vb-banking:server:depositvb')
AddEventHandler('vb-banking:server:depositvb', function(amount, inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	amount = tonumber(amount)
	Citizen.Wait(50)
	if amount == nil or amount <= 0 or amount > _char.getMoney() then
		TriggerClientEvent('mythic_notify:client:SendAlert', _src, { type = 'error', text = '錯誤金額'})
	else
		_char.removeMoney(amount)
		_char.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('mythic_notify:client:SendAlert', _src, { type = 'inform', text = '$' .. amount})
		TriggerEvent('esx_joblogs:AddInLog', 'money', 'deposit', _char.name, amount)
	end
end)

RegisterServerEvent('vb-banking:server:withdrawvb')
AddEventHandler('vb-banking:server:withdrawvb', function(amount, inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	local _base = 0
	amount = tonumber(amount)
	_base = _char.getAccount('bank').money
	Citizen.Wait(100)
	if amount == nil or amount <= 0 or amount > _base then
		TriggerClientEvent('mythic_notify:client:SendAlert', _src, { type = 'error', text = '錯誤金額'})
	else
		_char.removeAccountMoney('bank', amount)
		_char.addMoney(amount)
		TriggerClientEvent('mythic_notify:client:SendAlert', _src, { type = 'inform', text = '$' .. amount})
		TriggerEvent('esx_joblogs:AddInLog', 'money', 'deposit', _char.name, amount)
	end
end)

RegisterServerEvent('vb-banking:server:balance')
AddEventHandler('vb-banking:server:balance', function(inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	local balance = _char.getAccount('bank').money
	TriggerClientEvent('vb-banking:client:refreshbalance', _src, balance)
end)

RegisterServerEvent('vb-banking:server:transfervb')
AddEventHandler('vb-banking:server:transfervb', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(tonumber(to))
	local balance = 0
	if zPlayer ~= nil then
		balance = xPlayer.getAccount('bank').money
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, "error", "不能轉帳給自己")
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, "error", "金額不足無法轉帳")
			else
				xPlayer.removeAccountMoney('bank', tonumber(amountt))
				zPlayer.addAccountMoney('bank', tonumber(amountt))
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = '轉帳完成$' .. amountt})
				TriggerClientEvent('mythic_notify:client:SendAlert', to, { type = 'inform', text = '收到轉帳$' .. amountt})
				TriggerEvent('esx_joblogs:AddInLog', 'money', 'transfer', xPlayer.name, zPlayer.name, amountt)
				TriggerEvent('esx_joblogs:AddInLog', 'money', 'transfer2', zPlayer.name, xPlayer.name, amountt)
			end
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, "error", "錯誤ID或金額")
	end
end)
