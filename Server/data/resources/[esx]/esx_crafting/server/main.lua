ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('rs_crafting:CraftingSuccess')
AddEventHandler('rs_crafting:CraftingSuccess', function(CraftItem)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = Crafting.Items[CraftItem]

    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = '製作成功'})
    if CraftItem == "iron_plates" then
        xPlayer.addInventoryItem('iron_plate', 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40鐵板'})
    elseif CraftItem == "copper_plates" then
        xPlayer.addInventoryItem("copper_plate", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40銅板'})
    elseif CraftItem == "steels" then
        xPlayer.addInventoryItem("steel", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40鋼錠'})
    elseif CraftItem == "steel_plates" then
        xPlayer.addInventoryItem("steel_plate", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40鋼板'})
    elseif CraftItem == "fishingrods" then
        xPlayer.addInventoryItem("fishingrod", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40釣魚竿'})
    elseif CraftItem == "lines" then
        xPlayer.addInventoryItem("line", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40線'})
    elseif CraftItem == "hooks" then
        xPlayer.addInventoryItem("hook", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40鉤子'})
    elseif CraftItem == "shovels" then
        xPlayer.addInventoryItem("shovel", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40鏟子'})
    elseif CraftItem == "boxs" then
        xPlayer.addInventoryItem("box", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40箱子'})
    elseif CraftItem == "oysterknifes" then
        xPlayer.addInventoryItem("oysterknife", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40生蠔刀'})
    elseif CraftItem == "rakes" then
        xPlayer.addInventoryItem("rake", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40耙子'})
    elseif CraftItem == "fertilizers" then
        xPlayer.addInventoryItem("fertilizer", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40肥料'})
    elseif CraftItem == "sticks" then
        xPlayer.addInventoryItem("stick", 40)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '40木棍'})
    else
        xPlayer.addInventoryItem(CraftItem, 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = '1'})
    end

    for itemname, v in pairs(item.needs) do
        xPlayer.removeInventoryItem(itemname, v.count)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = '消耗' .. v.count .. ESX.GetItemLabel(itemname)})
    end

    AddCraftingPoints(src)
end)

RegisterServerEvent('rs_crafting:CraftingFailed')
AddEventHandler('rs_crafting:CraftingFailed', function(CraftItem)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = Crafting.Items[CraftItem]

	TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = '製作失敗'})
	TriggerClientEvent('rs_crafting:sound', src)

    for itemname, v in pairs(item.needs) do
        xPlayer.removeInventoryItem(itemname, v.count)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = '消耗' .. v.count .. ESX.GetItemLabel(itemname)})
    end

	RemoveCraftingPoints(src)
end)


ESX.RegisterServerCallback('rs_crafting:GetSkillLevel', function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll('SELECT * FROM user_levels WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] ~= nil then
            cb(tonumber(result[1].crafting))
        else
            MySQL.Async.execute('INSERT INTO user_levels (identifier, crafting) VALUES (@identifier, @crafting)', {
                ['@identifier'] = identifier,
                ['@crafting'] = 1
            }, function(rowsChanged)
                return cb(1)
            end)
        end
    end)
end)

ESX.RegisterServerCallback('rs_crafting:HasTheItems', function(source, cb, CraftItem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = Crafting.Items[CraftItem]
    for itemname, v in pairs(item.needs) do
        if xPlayer.getInventoryItem(itemname).count < v.count then
            cb(false)
        end
    end
    cb(true)
end)

function AddCraftingPoints(source)
    local identifier =  GetPlayerIdentifiers(source)[1]
    MySQL.Sync.execute('UPDATE user_levels SET crafting = crafting + @crafting WHERE identifier = @identifier', {
        ['@crafting'] = 1,
        ['@identifier'] = identifier
    })
end


function RemoveCraftingPoints(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll('SELECT * FROM user_levels WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result1)
        local craftinglevel = tonumber(result1[1].crafting)
        if craftinglevel <= 100 and craftinglevel >= 1 then
            MySQL.Sync.execute('UPDATE user_levels SET crafting = crafting - @crafting WHERE identifier = @identifier', {
                ['@crafting'] = 1,
                ['@identifier'] = identifier
            })
        elseif craftinglevel >= 200 then
            MySQL.Sync.execute('UPDATE user_levels SET crafting = crafting - @crafting WHERE identifier = @identifier', {
                ['@crafting'] = 10,
                ['@identifier'] = identifier
            })
        elseif craftinglevel == 0 then
            MySQL.Sync.execute('UPDATE user_levels SET crafting = crafting - @crafting WHERE identifier = @identifier', {
                ['@crafting'] = 0,
                ['@identifier'] = identifier
            })
        else
            return
	    end
	end)
end


function GetCraftingLevel(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll('SELECT * FROM user_levels WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] ~= nil then
            return tonumber(result[1].crafting)
        else
            MySQL.Async.execute('INSERT INTO user_levels (identifier, crafting) VALUES (@identifier, @crafting)', {
                ['@identifier'] = identifier,
                ['@crafting'] = 1
            }, function(rowsChanged)
                return 1
            end)
        end
    end)
end