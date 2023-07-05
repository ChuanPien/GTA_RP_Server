ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('tax', 'admin', function()
	GetUsersForTax()
end, true)

function GetUsersForTax(d, h, m)
    MySQL.ready(function()
        MySQL.Async.fetchAll('SELECT * FROM users',{},function(AllUser)
            RunTax(AllUser)
        end)
    end)
end

function CarsTax(AllUser)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles',{},function(AllCars)
        local taxMultiplier = Config.CarTax
        for i=1 , #AllUser,1 do
            local carCount = 0
            for a=1 , #AllCars,1 do
                if AllUser[i].identifier == AllCars[a].owner then
                    carCount = carCount + 1
                end
            end
            if carCount > 0 then
                local tax = carCount * taxMultiplier
                local xPlayer = ESX.GetPlayerFromIdentifier(AllUser[i].identifier)
                if(xPlayer ~= nil) then
                    TriggerClientEvent('tax:sendTax', xPlayer.source, xPlayer.source, '牌照稅', ESX.Math.Round(tax))
                end
            end
        end
    end)
end

function HouseTax(AllUser)
    MySQL.Async.fetchAll('SELECT * FROM owned_properties',{},function(AllHouse)
        local taxMultiplier = Config.HouseTax
        for i=1 , #AllUser,1 do
            local houseCount = 0
            for a=1 , #AllHouse,1 do
                if AllUser[i].identifier == AllHouse[a].owner then
                    houseCount = houseCount + 1
                end
            end
            if houseCount > 0 then
                local tax = houseCount * taxMultiplier
                local xPlayer = ESX.GetPlayerFromIdentifier(AllUser[i].identifier)
                if(xPlayer ~= nil) then
                    TriggerClientEvent('tax:sendTax', xPlayer.source, xPlayer.source, '房屋稅', ESX.Math.Round(tax))
                end
            end
        end
    end)
end

function RunTax(AllUser)
    HouseTax(AllUser)
    CarsTax(AllUser)
    Wait(Config.TaxInterval)
    GetUsersForTax()
end

GetUsersForTax()