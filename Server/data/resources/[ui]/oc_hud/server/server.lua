
ESX               = nil



TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getBlackMoneyFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('black_money')
	return account.money

end

local function getBankFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('bank')
	return account.money

end


RegisterServerEvent('oc_hud:getMoneys')
AddEventHandler('oc_hud:getMoneys', function()

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil then
		local wallet 		= getMoneyFromUser(_source)
		local bank 			= getBankFromUser(_source)
		local black_money 	= getBlackMoneyFromUser(_source)

	    TriggerClientEvent("oc_hud:setValues", _source, wallet, bank, black_money)
	end

end)




