ESX                = nil
local num

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("meat:wash")
AddEventHandler("meat:wash", function()
    local _source = source

    Washmeat(_source)
end)

function Washmeat(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pork_block = xPlayer.getInventoryItem("pork_block").count
    local meat_block = xPlayer.getInventoryItem("meat_block").count
    local chicken_block = xPlayer.getInventoryItem("chicken_block").count
    local venison_block = xPlayer.getInventoryItem("venison_block").count
    local count = chicken_block + pork_block + meat_block + venison_block

    if count >= 1  then

        TriggerClientEvent("meat:fu",source)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '清洗/切割中...', length = 8000})
        Wait(8000)

        if chicken_block >= 1 then
            num = math.random(3,6)
            xPlayer.removeInventoryItem("chicken_block",1)
            xPlayer.addInventoryItem("chicken",num)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '雞肉'})
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = num .. '雞肉塊'})
        end

        if pork_block >= 1 then
            num = math.random(3,6)
            xPlayer.removeInventoryItem("pork_block",1)
            xPlayer.addInventoryItem("pork",num)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '豬肉'})
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = num .. '豬肉片'})
        end

        if meat_block >= 1 then
            num = math.random(3,6)
            xPlayer.removeInventoryItem("meat_block",1)
            xPlayer.addInventoryItem("meat",num)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '牛肉'})
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = num .. '牛肉片'})
        end

        if venison_block >= 1 then
            num = math.random(3,6)
            xPlayer.removeInventoryItem("venison_block",1)
            xPlayer.addInventoryItem("venison",num)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '鹿肉'})
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = num .. '鹿肉片'})
        end
        Washmeat(source)
    else
        TriggerClientEvent("meat:unfu",source)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '無任何肉品'})
    end
end

RegisterNetEvent("meat:pack")
AddEventHandler("meat:pack", function()
    local _source = source

    Packmeat(_source)
end)

function Packmeat(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local chicken = xPlayer.getInventoryItem("chicken").count
    local pork = xPlayer.getInventoryItem("pork").count
    local meat = xPlayer.getInventoryItem("meat").count
    local venison = xPlayer.getInventoryItem("venison").count

    if chicken >= 3 or pork >= 3 or meat >= 3 or venison >= 3 then
        if xPlayer.canCarryItem('packaged_chicken',1) or xPlayer.canCarryItem('packaged_chicken',1) or xPlayer.canCarryItem('packaged_chicken',1) or xPlayer.canCarryItem('packaged_chicken',1) then
            TriggerClientEvent("meat:fu",source)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '包裝中...', length = 8000})
            Wait(8000)

            if chicken >= 3 then
                num = math.random(3,5)
                xPlayer.removeInventoryItem("chicken",num)
                xPlayer.addInventoryItem("packaged_chicken",1)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = num .. '雞肉塊'})
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '包裝雞肉'})
            end

            if pork >= 3 then
                num = math.random(3,5)
                xPlayer.removeInventoryItem("pork",num)
                xPlayer.addInventoryItem("packaged_pork",1)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = num .. '豬肉片'})
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '包裝豬肉'})
            end

            if meat >= 3 then
                num = math.random(3,5)
                xPlayer.removeInventoryItem("meat",num)
                xPlayer.addInventoryItem("packaged_meat",1)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = num .. '牛肉片'})
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '包裝牛肉'})
            end

            if venison >= 3 then
                num = math.random(3,5)
                xPlayer.removeInventoryItem("venison",num)
                xPlayer.addInventoryItem("packaged_venison",1)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = num .. '鹿肉片'})
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '包裝鹿肉'})
            end

            Packmeat(source)
        else
            TriggerClientEvent("meat:unfu",source)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '過重'})
        end
    else
        TriggerClientEvent("meat:unfu",source)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '肉品不足'})
    end
end

RegisterNetEvent("meat:sell")
AddEventHandler("meat:sell", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local chicken = xPlayer.getInventoryItem('packaged_chicken').count
    local meat = xPlayer.getInventoryItem('packaged_meat').count
    local venison = xPlayer.getInventoryItem('packaged_venison').count
    local pork = xPlayer.getInventoryItem('packaged_pork').count

    if chicken >= 1 or meat >= 1 or venison >= 1 or pork >= 1 then
        TriggerClientEvent("job:fu",_source)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = "討價還價中...", length = 30000})
        Wait(30000)
        TriggerClientEvent("job:unfu",_source)

        if chicken >= 1 then
            local chickens = chicken*math.random(750,1250)
            xPlayer.addMoney(chickens)
            xPlayer.removeInventoryItem("packaged_chicken",chicken)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = chicken .. "包裝雞肉 $" .. chickens, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "hunting", "sellmeat", xPlayer.name, chicken .. "包裝雞肉 $" .. chickens)
        end

        if meat >= 1 then
            local meat = xPlayer.getInventoryItem('packaged_meat').count
            local meats = meat*math.random(1250,1800)
            xPlayer.addMoney(meats)
            xPlayer.removeInventoryItem("packaged_meat",meat)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = meat .. "包裝牛肉 $" .. meats, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "hunting", "sellmeat", xPlayer.name, meat .. "包裝牛肉 $" .. meats)
        end

        if pork >= 1 then
            local pork = xPlayer.getInventoryItem('packaged_pork').count
            local porks = pork*math.random(1250,1800)
            xPlayer.addMoney(porks)
            xPlayer.removeInventoryItem("packaged_pork",pork)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = pork .. "包裝豬肉 $" .. porks, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "hunting", "sellmeat", xPlayer.name, pork .. "包裝豬肉 $" .. porks)
        end

        if venison >= 1 then
            local venison = xPlayer.getInventoryItem('packaged_venison').count
            local venisons = venison*math.random(1500,2000)
            xPlayer.addMoney(venisons)
            xPlayer.removeInventoryItem("packaged_venison",venison)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = venison .. "包裝鹿肉 $" .. venisons, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "hunting", "sellmeat", xPlayer.name, venison .. "包裝雞肉 $" .. venisons)
        end
    else
        TriggerClientEvent("meat:unfu",_source)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無任何肉品'})
    end
end)
