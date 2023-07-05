ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	amount = ESX.Math.Round(amount)

	if amount > 0 and xTarget then
		TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
			if account then
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'society',
					['@target'] = sharedAccountName,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
					TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'error', text = '帳單$' ..amount})
				end)
			else
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = xTarget.identifier,
					['@sender'] = xPlayer.identifier,
					['@target_type'] = 'player',
					['@target'] = xPlayer.identifier,
					['@label'] = label,
					['@amount'] = amount
				}, function(rowsChanged)
					TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'error', text = '帳單$' ..amount})
				end)
			end
		end)
	end
end)

ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT amount, id, label FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('esx_billing:getTargetBills', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT amount, id, label FROM billing WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			cb(result)
		end)
	else
		cb({})
	end
end)

ESX.RegisterServerCallback('esx_billing:payBill', function(source, cb, billId)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT sender, target_type, target,label, amount FROM billing WHERE id = @id', {
		['@id'] = billId
	}, function(result)
		if result[1] then
			local label = result[1].label
			local amount = result[1].amount
			local xTarget = ESX.GetPlayerFromIdentifier(result[1].sender)

			if result[1].target_type == 'player' then
				if xTarget then
					if xPlayer.getMoney() >= amount then
						MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
							['@id'] = billId
						}, function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeMoney(amount)
								xTarget.addMoney(amount)
								
								TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '帳單$' ..amount})
								TriggerEvent('esx_joblogs:AddInLog', "billing", "pb", xPlayer.name,label,amount)
							end

							cb()
						end)
					elseif xPlayer.getAccount('bank').money >= amount then
						MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
							['@id'] = billId
						}, function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeAccountMoney('bank', amount)
								xTarget.addAccountMoney('bank', amount)

								TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '帳單$' ..amount})
								TriggerEvent('esx_joblogs:AddInLog', "billing", "pb", xPlayer.name,label,amount)
							end

							cb()
						end)
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'error', text = '現金不足'})
						cb()
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '市民睡了'})
					cb()
				end
			else
				TriggerEvent('esx_addonaccount:getSharedAccount', result[1].target, function(account)
					if xPlayer.getMoney() >= amount then
						MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
							['@id'] = billId
						}, function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeMoney(amount)
								account.addMoney(amount)
								TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '$' ..amount})
								TriggerEvent('esx_joblogs:AddInLog', "billing", "pb", xPlayer.name,label,amount)
							end

							cb()
						end)
					elseif xPlayer.getAccount('bank').money >= amount then
						MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
							['@id'] = billId
						}, function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeAccountMoney('bank', amount)
								account.addMoney(amount)

								TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '$' ..amount})
								TriggerEvent('esx_joblogs:AddInLog', "billing", "pb", xPlayer.name,label,amount)
							end

							cb()
						end)
					else

						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '金錢不足'})
						cb()
					end
				end)
			end
		end
	end)
end)

TriggerEvent('cron:runAt', 20, 0, PayBills)

ESX.RegisterCommand('p', 'admin', function()
	PayBills()
end, true)

function PayBills(d, h, m)
	local xPlayer = ESX.GetPlayerFromId(source)

	CreateThread(function()
		Wait(0)
		MySQL.Async.fetchAll('SELECT * FROM billing', {}, function (result)
			for i=1, #result, 1 do
				local xPlayer = ESX.GetPlayerFromIdentifier(result[i].identifier)
				
				-- message player if connected
				if xPlayer then
					local Bank = xPlayer.getAccount('bank').money
					local cost = result[i].amount

					if Bank > 0 then
						xPlayer.removeAccountMoney('bank', cost)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, '懶欣國際商銀', '自動繳費通知', '您的~r~未付帳單~s~已自動從您~b~銀行帳戶~s~中~r~扣款，並收取~r~20%手續費', 'CHAR_BANK_MAZE', 9)

						TriggerEvent('esx_addonaccount:getSharedAccount', result[i].target, function(account)
							account.addMoney(result[i].amount)
						end)
						MySQL.Sync.execute('DELETE FROM billing WHERE id = @id',
						{
							['@id'] = result[i].id
						})
						TriggerEvent('esx_joblogs:AddInLog', "billing", "pb2", xPlayer.name,cost)
						Wait(500)
					else
						xPlayer.removeMoney(cost)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, '懶欣國際商銀', '自動繳費通知', '您的~r~未付帳單~s~已自動從您~b~錢包~s~中~r~扣款，並收取~r~20%手續費', 'CHAR_BANK_MAZE', 9)

						TriggerEvent('esx_addonaccount:getSharedAccount', result[i].target, function(account)
							account.addMoney(result[i].amount)
						end)
						MySQL.Sync.execute('DELETE FROM billing WHERE id = @id',
						{
							['@id'] = result[i].id
						})
						TriggerEvent('esx_joblogs:AddInLog', "billing", "pb2", xPlayer.name,cost)
						Wait(500)
					end
				else
					MySQL.Async.fetchScalar('SELECT accounts FROM users WHERE identifier = @identifier',
					{
						['@identifier'] = result[i].identifier
					}, function(jsonAccounts)
						local accounts = json.decode(jsonAccounts)
						local cost = result[i].amount

						if accounts.bank > 0 then
							accounts.bank = accounts.bank - cost
							MySQL.Sync.execute('UPDATE users SET accounts = @accounts WHERE identifier = @identifier',
							{
								['@accounts']   = json.encode(accounts),
								['@identifier'] = result[i].identifier
							})
							TriggerEvent('esx_addonaccount:getSharedAccount', result[i].target, function(account)
								account.addMoney(result[i].amount)
							end)
							MySQL.Sync.execute('DELETE FROM billing WHERE `id` = @id',
							{
								['@id'] = result[i].id
							})
							TriggerEvent('esx_joblogs:AddInLog', "billing", "pb2", result[i].identifier,cost)
							Wait(500)
						else
							accounts.money = accounts.money - cost
							MySQL.Sync.execute('UPDATE users SET accounts = @accounts WHERE identifier = @identifier',
							{
								['@accounts']   = json.encode(accounts),
								['@identifier'] = result[i].identifier
							})
							TriggerEvent('esx_addonaccount:getSharedAccount', result[i].target, function(account)
								account.addMoney(result[i].amount)
							end)
							MySQL.Sync.execute('DELETE FROM billing WHERE `id` = @id',
							{
								['@id'] = result[i].id
							})
							TriggerEvent('esx_joblogs:AddInLog', "billing", "pb2", result[i].identifier,cost)
							Wait(500)
						end
					end)
				end
			end
		end)
	end)
end
