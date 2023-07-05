ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayersGetWool = {}
local PlayersGetWood = {}

RegisterNetEvent("job:givestone")
AddEventHandler("job:givestone", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)

    if xPlayer.canCarryItem('stone', 1) then
        xPlayer.addInventoryItem('stone', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = '1骯髒原礦'})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '過重'})
    end
end)

RegisterNetEvent("job:washstone")
AddEventHandler("job:washstone", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local stones = xPlayer.getInventoryItem('stone').count

    if stones >= 1 then
        xPlayer.removeInventoryItem('stone', stones)
        if xPlayer.canCarryItem('stone', stones) then
            TriggerClientEvent("job:fu",_source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '洗淨中...',length = stones*8000})
            Wait(stones*8000)
            TriggerClientEvent("job:unfu",_source)
            xPlayer.addInventoryItem('washed_stone', stones)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = stones .. '骯髒原礦'})
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = stones .. '乾淨原礦'})
        else
            xPlayer.addInventoryItem('stone', stones)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '過重'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無骯髒原礦'})
    end
end)

RegisterNetEvent("job:finestone")
AddEventHandler("job:finestone", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local stones = xPlayer.getInventoryItem('washed_stone').count
    local chance = math.random(1,50)

    if stones >= 1 then
        xPlayer.removeInventoryItem('washed_stone', stones)
        TriggerClientEvent("job:fu",_source)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '精煉中...',length = stones*8000})
        Wait(stones*8000)
        TriggerClientEvent("job:unfu",_source)
        xPlayer.addInventoryItem('copper',stones*8)
        xPlayer.addInventoryItem('iron', stones*6)
        xPlayer.addInventoryItem('gold', stones*4)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = stones .. '乾淨原礦'})
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = stones*8 .. '銅錠'})
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = stones*6 .. '鐵錠'})
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = stones*4 .. '金錠'})

        if chance <= 3 then
            xPlayer.addInventoryItem('diamond', 1)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = '1鑽石'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無乾淨原礦'})
    end
end)

RegisterNetEvent("job:sellstone")
AddEventHandler("job:sellstone", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)

    local copper = xPlayer.getInventoryItem('copper').count
    local iron = xPlayer.getInventoryItem('iron').count
    local gold = xPlayer.getInventoryItem('gold').count
    local diamond = xPlayer.getInventoryItem('diamond').count

    if copper >= 1 or iron >= 1 or gold >= 1 or diamond >= 1 then
        TriggerClientEvent("job:fu",_source)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = "討價還價中...", length = 20000})
        Wait(20000)
        TriggerClientEvent("job:unfu",_source)

        if copper >= 1 then
            local copper = xPlayer.getInventoryItem('copper').count
            local coppers = copper*Config.copper
            xPlayer.addMoney(coppers)
            xPlayer.removeInventoryItem("copper",copper)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = copper .. "個銅錠 $" .. coppers, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "work", "exwork", xPlayer.name,copper .. "個銅錠 $" .. coppers)
        end
        if iron >= 1 then
            local iron = xPlayer.getInventoryItem('iron').count
            local irons = iron*Config.iron
            xPlayer.addMoney(irons)
            xPlayer.removeInventoryItem("iron",iron)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = iron .. "個鐵錠 $" .. irons, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "work", "exwork", xPlayer.name,iron .. "個鐵錠 $" .. irons)
        end
        if gold >= 1 then
            local gold = xPlayer.getInventoryItem('gold').count
            local golds = gold*Config.gold
            xPlayer.addMoney(golds)
            xPlayer.removeInventoryItem("gold",gold)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = gold .. "個金錠 $" .. golds, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "work", "exwork", xPlayer.name,gold .. "個金錠 $" .. golds)
        end
        if diamond >= 1 then
            local diamond = xPlayer.getInventoryItem('diamond').count
            local diamonds = diamond*Config.diamond
            xPlayer.addMoney(diamonds)
            xPlayer.removeInventoryItem("diamond",diamond)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = diamond .. "個鑽石 $" .. diamonds, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "work", "exwork", xPlayer.name,diamond .. "個鑽石 $" .. diamonds)
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無金屬錠'})
    end
end)

RegisterNetEvent("job:wood")
AddEventHandler("job:wood", function()
    local _source = source

    PlayersGetWood[_source] = true
    GetWood(_source)
end)

function GetWood(source)
    if PlayersGetWood[source] == true then
        local xPlayer  = ESX.GetPlayerFromId(source)

        if xPlayer.canCarryItem("wood",1) then
            TriggerClientEvent("job:fu",source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '採集中...',length = 5000})
            Wait(5000)
            xPlayer.addInventoryItem("wood",1)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = '1原木'})
            GetWood(source)
        else
            TriggerClientEvent("job:unfu",source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '過重'})
        end
    end
end

RegisterNetEvent("job:cuttedwood")
AddEventHandler("job:cuttedwood", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local wood = xPlayer.getInventoryItem('wood').count

    if wood >= 1 then
        xPlayer.removeInventoryItem('wood', wood)
        if xPlayer.canCarryItem("cutted_wood",wood) then
            TriggerClientEvent("job:fu",_source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '切割中...',length = wood*5000})
            Wait(wood*5000)
            TriggerClientEvent("job:unfu",_source)
            xPlayer.addInventoryItem('cutted_wood', wood*2)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = wood .. '原木'})
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = wood*2 .. '木材'})
        else
            TriggerClientEvent("job:unfu",_source)
            xPlayer.addInventoryItem('wood', wood)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '過重'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無原木'})
    end
end)

RegisterNetEvent("job:plankwood")
AddEventHandler("job:plankwood", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local cutted_wood = xPlayer.getInventoryItem('cutted_wood').count

    if cutted_wood >= 2 then
        if cutted_wood%2 ~= 0 then
            cutted_wood = cutted_wood -1
        end
        local count = math.floor(cutted_wood/2)
        xPlayer.removeInventoryItem('cutted_wood', cutted_wood)
        if xPlayer.canCarryItem('packaged_plank',count) then
            TriggerClientEvent("job:fu",_source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '包裝中...',length = count*8000})
            Wait(count*8000)
            TriggerClientEvent("job:unfu",_source)
            xPlayer.addInventoryItem('packaged_plank', count)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = cutted_wood .. '木材'})
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = count .. '包裝木板'})
        else
            TriggerClientEvent("job:unfu",_source)
            xPlayer.addInventoryItem('cutted_wood', cutted_wood)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '過重'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無木材'})
    end
end)

RegisterNetEvent("job:sellwood")
AddEventHandler("job:sellwood", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local packaged_plank = xPlayer.getInventoryItem('packaged_plank').count

    if packaged_plank >= 1 then
        TriggerClientEvent("job:fu",_source)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = "討價還價中...", length = 20000})
        Wait(20000)
        TriggerClientEvent("job:unfu",_source)
        if packaged_plank >= 1 then
            local packaged_plank = xPlayer.getInventoryItem('packaged_plank').count
            local packaged_planks = packaged_plank*Config.woodpay
            xPlayer.addMoney(packaged_planks)
            xPlayer.removeInventoryItem("packaged_plank",packaged_plank)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = packaged_plank .. "個包裝木板 $" .. packaged_planks, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "work", "exwork", xPlayer.name, packaged_plank .. "個包裝木板 $" .. packaged_planks)
        else
            TriggerClientEvent("job:unfu",_source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無包裝木板'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無包裝木板'})
    end
end)

RegisterNetEvent("job:wool")
AddEventHandler("job:wool", function()
    local _source = source

    PlayersGetWool[_source] = true
    GetWool(_source)
end)

function GetWool(source)
    if PlayersGetWool[source] == true then
        local xPlayer  = ESX.GetPlayerFromId(source)

        if xPlayer.canCarryItem("wool",1) then
            TriggerClientEvent("job:fu",source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '採集中...', length = 3000})
            Wait(3000)
            xPlayer.addInventoryItem("wool",1)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = '1羊毛'})
            GetWool(source)
        else
            TriggerClientEvent("job:unfu",source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '過重'})
        end
    end
end

RegisterNetEvent("job:Fabricwool")
AddEventHandler("job:Fabricwool", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local wool = xPlayer.getInventoryItem('wool').count

    if wool >= 1 then
        xPlayer.removeInventoryItem('wool', wool)
        if xPlayer.canCarryItem("fabric",wool) then
            TriggerClientEvent("job:fu",_source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '製作中...',length = wool*3500})
            Wait(wool*3500)
            TriggerClientEvent("job:unfu",_source)
            xPlayer.addInventoryItem('fabric', wool*2)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = wool .. '羊毛'})
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = wool*2 .. '布料'})
        else
            TriggerClientEvent("job:unfu",_source)
            xPlayer.addInventoryItem('wool', wool)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '過重'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無羊毛'})
    end
end)

RegisterNetEvent("job:Clothewool")
AddEventHandler("job:Clothewool", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local fabric = xPlayer.getInventoryItem('fabric').count

    if fabric >= 2 then
        if fabric%2 ~= 0 then
            fabric = fabric -1
        end
        local count = math.floor(fabric/2)
        xPlayer.removeInventoryItem('fabric', fabric)
        if xPlayer.canCarryItem('clothe',count) then
            TriggerClientEvent("job:fu",_source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '製作中...',length = count*4000})
            Wait(count*4000)
            TriggerClientEvent("job:unfu",_source)
            xPlayer.addInventoryItem('clothe', count)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = fabric .. '布料'})
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = count .. '衣服'})
        else
            TriggerClientEvent("job:unfu",_source)
            xPlayer.addInventoryItem('fabric', fabric)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '過重'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無布料'})
    end
end)

RegisterNetEvent("job:sellwool")
AddEventHandler("job:sellwool", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local clothe = xPlayer.getInventoryItem('clothe').count

    if clothe >= 1 then
        TriggerClientEvent("job:fu",_source)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = "討價還價中...", length = 20000})
        Wait(20000)
        TriggerClientEvent("job:unfu",_source)
        if clothe >= 1 then
            local clothe = xPlayer.getInventoryItem('clothe').count
            local clothes = clothe*Config.woolpay
            xPlayer.addMoney(clothes)
            xPlayer.removeInventoryItem("clothe",clothe)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = clothe .. "件衣服 $" .. clothes, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "work", "exwork", xPlayer.name, clothe .. "件衣服 $" .. clothes)
        else
            TriggerClientEvent("job:unfu",_source)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無衣服'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '無衣服'})
    end
end)
