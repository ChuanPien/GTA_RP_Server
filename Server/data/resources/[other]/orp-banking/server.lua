ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('orp:bank:deposit')
AddEventHandler('orp:bank:deposit', function(amount)
    local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('orp:bank:notify', _source, "error", "錯誤數值")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('orp:bank:notify', _source, "inform", "$" .. amount)
		TriggerEvent('esx_joblogs:AddInLog', 'money', 'deposit', xPlayer.name, amount)
	end
end)

RegisterServerEvent('orp:bank:withdraw')
AddEventHandler('orp:bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local min = 0
	amount = tonumber(amount)
	min = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > min then
		TriggerClientEvent('orp:bank:notify', _source, "error", "錯誤數值")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('orp:bank:notify', _source, "inform", "$" .. amount)
		TriggerEvent('esx_joblogs:AddInLog', 'money', 'withdraw', xPlayer.name, amount)
	end
end)

RegisterServerEvent('orp:bank:balance')
AddEventHandler('orp:bank:balance', function()
	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('orp:bank:info', _source, balance)
end)

RegisterServerEvent('orp:bank:transfer')
AddEventHandler('orp:bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(to)
	local amount = amountt
	local balance = 0

	if(xTarget == nil or xTarget == -1) then
		TriggerClientEvent('orp:bank:notify', _source, "error", "錯誤ID或金額")
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = xTarget.getAccount('bank').money
		
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('orp:bank:notify', _source, "error", "不能轉帳給自己")
		else
			if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
				TriggerClientEvent('orp:bank:notify', _source, "error", "金額不足無法轉帳")
			else
				xPlayer.removeAccountMoney('bank', tonumber(amount))
				xTarget.addAccountMoney('bank', tonumber(amount))
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = '轉帳完成'})
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = '$' .. amount})
				TriggerClientEvent('mythic_notify:client:SendAlert', to, { type = 'inform', text = '收到轉帳'})
				TriggerClientEvent('mythic_notify:client:SendAlert', to, { type = 'inform', text = '$' .. amount})
				TriggerEvent('esx_joblogs:AddInLog', 'money', 'transfer', xPlayer.name, xTarget.name, amount)
				TriggerEvent('esx_joblogs:AddInLog', 'money', 'transfer2', xTarget.name, xPlayer.name, amount)
			end
		end
	end
end)