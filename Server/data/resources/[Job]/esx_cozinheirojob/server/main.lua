ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'cozinheiro', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'cozinheiro', _U('cozinheiro_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'cozinheiro', 'Cozinheiro', 'society_cozinheiro', 'society_cozinheiro',
    'society_cozinheiro', {
        type = 'private'
    })

RegisterServerEvent('esx_cozinheirojob:getStockItem')
AddEventHandler('esx_cozinheirojob:getStockItem', function(itemName, count)

    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)

        local item = inventory.getItem(itemName)

        if item.count >= count then
            inventory.removeItem(itemName, count)
            xPlayer.addInventoryItem(itemName, count)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
                type = 'error',
                text = '錯誤數量'
            })
        end
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
            type = 'inform',
            text = '' .. count .. item.label
        })

    end)

end)

RegisterServerEvent('esx_cozinheirojob:Billing') -- Not Working...
AddEventHandler('esx_cozinheirojob:Billing', function(money, player)

    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(player)
    local valor = money

    if xTarget.getMoney() >= valor then
        xTarget.removeMoney(valor)
        xPlayer.addMoney(valor)
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, "您的客戶沒有錢，價值: " .. valor)
        TriggerClientEvent('esx:showNotification', xTarget.source, "你沒有錢, 價值: " .. valor)
    end
end) -- Not Working

ESX.RegisterServerCallback('esx_cozinheirojob:getStockItems', function(source, cb)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)
        cb(inventory.items)
    end)

end)

RegisterServerEvent('esx_cozinheirojob:putStockItems')
AddEventHandler('esx_cozinheirojob:putStockItems', function(itemName, count)

    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)

        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
                type = 'error',
                text = '錯誤數量'
            })
        end
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
            type = 'inform',
            text = '' .. count .. item.label
        })

    end)

end)

RegisterServerEvent('esx_cozinheirojob:getFridgeStockItem')
AddEventHandler('esx_cozinheirojob:getFridgeStockItem', function(itemName, count)

    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)

        local item = inventory.getItem(itemName)

        if item.count >= count then
            inventory.removeItem(itemName, count)
            xPlayer.addInventoryItem(itemName, count)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
                type = 'error',
                text = '錯誤數量'
            })
        end

        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
            type = 'inform',
            text = count .. item.label
        })

    end)

end)

ESX.RegisterServerCallback('esx_cozinheirojob:getFridgeStockItems', function(source, cb)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)
        cb(inventory.items)
    end)

end)

RegisterServerEvent('esx_cozinheirojob:putFridgeStockItems')
AddEventHandler('esx_cozinheirojob:putFridgeStockItems', function(itemName, count)

    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)

        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
                type = 'error',
                text = '錯誤數量'
            })
        end
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
            type = 'inform',
            text = count .. item.label
        })

    end)

end)

RegisterServerEvent('esx_cozinheirojob:buyItem')
AddEventHandler('esx_cozinheirojob:buyItem', function(itemName, price, itemLabel)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local limit = xPlayer.getInventoryItem(itemName).limit
    local qtty = xPlayer.getInventoryItem(itemName).count
    local societyAccount = nil

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cozinheiro', function(account)
        societyAccount = account
    end)

    if societyAccount ~= nil and societyAccount.money >= price then
        if qtty < limit then
            societyAccount.removeMoney(price)
            xPlayer.addInventoryItem(itemName, 1)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
                type = 'success',
                text = '購買' .. itemLabel
            })
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
                type = 'error',
                text = '過重'
            })
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {
            type = 'error',
            text = '現金不足'
        })
    end
end)

RegisterServerEvent('esx_cozinheirojob:craftingCoktails')
AddEventHandler('esx_cozinheirojob:craftingCoktails', function(Value)

    local _source = source
    local escolha = Value
    if escolha == "ovoes" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local manteiga = xPlayer.getInventoryItem('manteiga').count
        local ovo = xPlayer.getInventoryItem('ovo').count

        if manteiga < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '黃油'
            })
        elseif ovo < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '雞蛋'
            })
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '煎蛋'
            })
            xPlayer.removeInventoryItem('ovo', 100)
            xPlayer.removeInventoryItem('manteiga', 100)
            xPlayer.addInventoryItem('ovoes', 100)
        end
    elseif escolha == "meat" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local manteiga = xPlayer.getInventoryItem('manteiga').count
        local packaged_meat = xPlayer.getInventoryItem('packaged_meat').count
        local oregaos = xPlayer.getInventoryItem('oregaos').count

        if manteiga < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '黃油'
            })
        elseif packaged_meat < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '包裝牛肉'
            })
        elseif oregaos < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '香料'
            })
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '烤牛肉'
            })
            xPlayer.removeInventoryItem('oregaos', 100)
            xPlayer.removeInventoryItem('meat', 100)
            xPlayer.removeInventoryItem('manteiga', 100)
            xPlayer.addInventoryItem('meatass', 100)
        end
    elseif escolha == "polvo" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local manteiga = xPlayer.getInventoryItem('manteiga').count
        local polvo = xPlayer.getInventoryItem('polvo').count
        local alho = xPlayer.getInventoryItem('alho').count
        local squash = xPlayer.getInventoryItem('squash').count

        if manteiga < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '黃油'
            })
        elseif polvo < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '章魚'
            })
        elseif alho < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '大蒜'
            })
        elseif squash < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '地瓜粉'
            })
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '章魚燒'
            })
            xPlayer.removeInventoryItem('alho', 100)
            xPlayer.removeInventoryItem('polvo', 100)
            xPlayer.removeInventoryItem('manteiga', 100)
            xPlayer.removeInventoryItem('squash', 100)
            xPlayer.addInventoryItem('polvogre', 100)
        end
    elseif escolha == "burger" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local bread = xPlayer.getInventoryItem('bread').count
        local packaged_pork = xPlayer.getInventoryItem('packaged_pork').count
        local alface = xPlayer.getInventoryItem('alface').count
        local tomate = xPlayer.getInventoryItem('tomate').count
        local queijo = xPlayer.getInventoryItem('queijo').count

        if bread < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '麵包'
            })
        elseif packaged_pork < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '包裝豬肉'
            })
        elseif alface < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '生菜'
            })
        elseif tomate < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '番茄'
            })
        elseif queijo < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '起司'
            })
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '漢堡'
            })
      
            xPlayer.removeInventoryItem('bread', 100)
            xPlayer.removeInventoryItem('carnep', 100)
            xPlayer.removeInventoryItem('alface', 100)
            xPlayer.removeInventoryItem('tomate', 100)
            xPlayer.removeInventoryItem('queijo', 100)
            xPlayer.addInventoryItem('burger', 100)
        end
    elseif escolha == "friedchicken" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local packaged_chicken = xPlayer.getInventoryItem('packaged_chicken').count
        local oregaos = xPlayer.getInventoryItem('oregaos').count
        local squash = xPlayer.getInventoryItem('squash').count
        local manteiga = xPlayer.getInventoryItem('manteiga').count

        if packaged_chicken < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '包裝雞肉'
            })
    
        elseif oregaos < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '香料'
            })
            
        elseif squash < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '地瓜粉'
            })

        elseif manteiga < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '黃油'
            })

        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '炸雞排'
            })
        
            xPlayer.removeInventoryItem('packaged_chicken', 100)
            xPlayer.removeInventoryItem('oregaos', 100)
            xPlayer.removeInventoryItem('squash', 100)
            xPlayer.removeInventoryItem('manteiga', 100)
            xPlayer.addInventoryItem('friedchicken', 100)
        end
    elseif escolha == "friedlobster" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local lobster = xPlayer.getInventoryItem('lobster').count
        local ovo = xPlayer.getInventoryItem('ovo').count
        local squash = xPlayer.getInventoryItem('squash').count
        local milk = xPlayer.getInventoryItem('milk').count

        if lobster < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '龍蝦'
            })
    
        elseif ovo < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '雞蛋'
            })

        elseif squash < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '地瓜粉'
            })
    
        elseif milk < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '牛奶'
            })

        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '蛋黃派炸龍蝦'
            })
        
            xPlayer.removeInventoryItem('lobster', 100)
            xPlayer.removeInventoryItem('ovo', 100)
            xPlayer.removeInventoryItem('squash', 100)
            xPlayer.removeInventoryItem('milk', 100)
            xPlayer.addInventoryItem('friedlobster', 100)
        end
    elseif escolha == "friedfish" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local fish = xPlayer.getInventoryItem('fish').count
        local onion = xPlayer.getInventoryItem('onion').count
        local ovo = xPlayer.getInventoryItem('ovo').count
        local milk = xPlayer.getInventoryItem('milk').count

        if fish < 500 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '生魚'
            })
    
        elseif onion < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '洋蔥'
            })

        elseif ovo < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '雞蛋'
            })
    
        elseif milk < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '牛奶'
            })

        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '青花魚漢堡排'
            })
        
            xPlayer.removeInventoryItem('fish', 500)
            xPlayer.removeInventoryItem('ovo', 100)
            xPlayer.removeInventoryItem('onion', 100)
            xPlayer.removeInventoryItem('milk', 100)
            xPlayer.addInventoryItem('friedfish', 100)
        end
    elseif escolha == "friedshrimp" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local turtlebait = xPlayer.getInventoryItem('turtlebait').count
        local onion = xPlayer.getInventoryItem('onion').count
        local manteiga = xPlayer.getInventoryItem('manteiga').count
        local alho = xPlayer.getInventoryItem('alho').count

        if turtlebait < 500 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '龍蝦'
            })
    
        elseif onion < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '洋蔥'
            })

        elseif manteiga < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '黃油'
            })
    
        elseif alho < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '大蒜'
            })

        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '奶油蒜香蝦'
            })
        
            xPlayer.removeInventoryItem('turtlebait', 500)
            xPlayer.removeInventoryItem('onion', 100)
            xPlayer.removeInventoryItem('manteiga', 100)
            xPlayer.removeInventoryItem('alho', 100)
            xPlayer.addInventoryItem('friedshrimp', 100)
        end
    elseif escolha == "friedoyster2" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local oyster2 = xPlayer.getInventoryItem('oyster2').count
        local alface = xPlayer.getInventoryItem('alface').count
        local squash = xPlayer.getInventoryItem('squash').count
        local ovo = xPlayer.getInventoryItem('ovo').count
        local onion = xPlayer.getInventoryItem('onion').count

        if oyster2 < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '牡蠣肉'
            })
    
        elseif alface < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '青菜'
            })

        elseif squash < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '地瓜粉'
            })
    
        elseif ovo < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '雞蛋'
            })
    
        elseif onion < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '洋蔥'
            })

        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '蚵仔煎'
            })
        
            xPlayer.removeInventoryItem('oyster2', 100)
            xPlayer.removeInventoryItem('alface', 100)
            xPlayer.removeInventoryItem('squash', 100)
            xPlayer.removeInventoryItem('ovo', 100)
            xPlayer.removeInventoryItem('onion', 100)
            xPlayer.addInventoryItem('friedoyster2', 100)
        end
    elseif escolha == "friedsausage" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local sharkfin = xPlayer.getInventoryItem('sharkfin').count
        local hen = xPlayer.getInventoryItem('hen').count
        local bamboo = xPlayer.getInventoryItem('bamboo').count
        local sausage = xPlayer.getInventoryItem('sausage').count

        if sharkfin < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '魚翅'
            })
    
        elseif hen < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '火腿'
            })

        elseif bamboo < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '筍絲'
            })
    
        elseif sausage < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '雞蛋'
            })

        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '龍捲魚翅香腸'
            })
        
            xPlayer.removeInventoryItem('sharkfin', 100)
            xPlayer.removeInventoryItem('hen', 100)
            xPlayer.removeInventoryItem('bamboo', 100)
            xPlayer.removeInventoryItem('sausage', 100)
            xPlayer.addInventoryItem('friedsausage', 100)
        end
    elseif escolha == "friedsausage" then
        local xPlayer = ESX.GetPlayerFromId(_source)

        local packaged_venison = xPlayer.getInventoryItem('packaged_venison').count
        local oregaos = xPlayer.getInventoryItem('oregaos').count
        local manteiga = xPlayer.getInventoryItem('manteiga').count
        local chestnut = xPlayer.getInventoryItem('chestnut').count

        if packaged_venison < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '包裝鹿肉'
            })
    
        elseif oregaos < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '香料'
            })

        elseif manteiga < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '筍絲'
            })
    
        elseif chestnut < 100 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = '栗子'
            })

        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'success',
                text = '炭火烤鹿肉'
            })
        
            xPlayer.removeInventoryItem('packaged_venison', 100)
            xPlayer.removeInventoryItem('oregaos', 100)
            xPlayer.removeInventoryItem('manteiga', 100)
            xPlayer.removeInventoryItem('chestnut', 100)
            xPlayer.addInventoryItem('friedvenison', 100)
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {
            type = 'error',
            text = '錯誤'
        })
    end
end)

RegisterServerEvent('esx_cozinheirojob:shop')
AddEventHandler('esx_cozinheirojob:shop', function(item, valor)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local comida = item
    local preco = valor * 100
    if xPlayer.getMoney() >= preco then
        xPlayer.removeMoney(preco)
        xPlayer.addInventoryItem(comida, 100)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {
            type = 'error',
            text = '$' .. preco
        })
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {
            type = 'success',
            text = ESX.GetItemLabel(comida)
        })
    end
end)

ESX.RegisterServerCallback('esx_cozinheirojob:getVaultWeapons', function(source, cb)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_cozinheiro', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)

    end)

end)

ESX.RegisterServerCallback('esx_cozinheirojob:addVaultWeapon', function(source, cb, weaponName)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon(weaponName)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_cozinheiro', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)

        cb()

    end)

end)

ESX.RegisterServerCallback('esx_cozinheirojob:removeVaultWeapon', function(source, cb, weaponName)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addWeapon(weaponName, 1000)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_cozinheiro', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)

        cb()

    end)

end)

ESX.RegisterServerCallback('esx_cozinheirojob:getPlayerInventory', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.inventory

    cb({
        items = items
    })

end)
