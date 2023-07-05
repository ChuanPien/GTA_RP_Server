ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('fish:count', function (source, cb, type, amount)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local fish =  xPlayer.getInventoryItem('fish').count
    local turtle =  xPlayer.getInventoryItem('turtle').count
    local turtlebait =  xPlayer.getInventoryItem('turtlebait').count
    local shark =  xPlayer.getInventoryItem('shark').count

    if type == "fishmeat" then
        if fish >= amount then
            cb(true)
        else
            cb(false)
        end
    elseif type == "turtlemeat" then
        if turtle >= amount then
            cb(true)
        else
            cb(false)
        end
    elseif type == "shrimp" then
        if turtlebait >= amount then
            cb(true)
        else
            cb(false)
        end
    elseif type == "sharkfin" then
        if shark >= amount then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent("fish:Pack")
AddEventHandler("fish:Pack", function(type,amount)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local num = 0
    local time = amount

    if time >= 30 then
        time = 60 * 250
    else
        time = time * 250
    end

    TriggerClientEvent("fish:fu",_source)
    TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = "加工中...", length = time})
    Wait(time)
    TriggerClientEvent("fish:unfu",_source)

    if type == "fishmeat" then
        num = math.random(2,3)
        xPlayer.removeInventoryItem("fish",amount)
        xPlayer.addInventoryItem("fishmeat",num*amount)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = amount .. '條鯛魚'})
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = num*amount .. '鯛魚肉塊'})
	elseif type == "turtlemeat" then
        num = math.random(2,3)
        xPlayer.removeInventoryItem("turtle",amount)
        xPlayer.addInventoryItem("turtlemeat",num*amount)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = amount .. '隻海龜'})
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = num*amount .. '海龜肉'})
	elseif type == "shrimp" then
        xPlayer.removeInventoryItem("turtlebait",amount)
        xPlayer.addInventoryItem("shrimp",amount)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = amount .. '隻蝦'})
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = amount .. '隻蝦仁'})
	else
        num = math.random(1,3)
        xPlayer.removeInventoryItem("shark",amount)
        xPlayer.addInventoryItem("sharkfin",num*amount)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = amount .. '隻鯊魚'})
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = num*amount .. '魚翅'})
	end
end)

RegisterServerEvent("fish:Sell")
AddEventHandler("fish:Sell", function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local fish = xPlayer.getInventoryItem('fish').count
    local fish1 = xPlayer.getInventoryItem('fish1').count
    local fish2 = xPlayer.getInventoryItem('fish2').count
    local fish3 = xPlayer.getInventoryItem('fish3').count
    local fish4 = xPlayer.getInventoryItem('fish4').count
    local fish5 = xPlayer.getInventoryItem('fish5').count
    local fish6 = xPlayer.getInventoryItem('fish6').count
    local polvo = xPlayer.getInventoryItem('polvo').count
    local lobster = xPlayer.getInventoryItem('lobster').count
    local oyster = xPlayer.getInventoryItem('oyster2').count
    local turtlebait = xPlayer.getInventoryItem('turtlebait').count
    local fishs, fishs1, fishs2, fishs3, fishs4, fishs5, fishs6, polvos, lobsters, oysters, turtlebaits = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    local amount = fish + fish1 + fish2 + fish3 + fish4 + fish5 + fish6 + polvo + lobster + oyster + turtlebait

    if amount >= 1 then
        TriggerClientEvent("fish:fu",_source)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = "討價還價中...", length = 30000})
        Wait(30000)
        TriggerClientEvent("fish:unfu",_source)

        if fish >= 1 then
            fishs = fish*math.random(150,200)
            xPlayer.addMoney(fishs)
            xPlayer.removeInventoryItem("fish",fish)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = fish .. "條鯛魚 $" .. fishs, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, fish .. "條鯛魚 $" .. fishs)
        end

        if fish1 >= 1 then
            fishs1 = fish1*math.random(150,200)
            xPlayer.addMoney(fishs1)
            xPlayer.removeInventoryItem("fish1",fish1)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = fish1 .. "條沙丁魚 $" .. fishs1, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, fish1 .. "條沙丁魚 $" .. fishs1)
        end

        if fish2 >= 1 then
            fishs2 = fish2*math.random(150,200)
            xPlayer.addMoney(fishs2)
            xPlayer.removeInventoryItem("fish2",fish2)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = fish2 .. "條鯖魚 $" .. fishs2, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, fish2 .. "條鯖魚 $" .. fishs2)
        end

        if fish3 >= 1 then
            fishs3 = fish3*math.random(3500,6000)
            xPlayer.addMoney(fishs3)
            xPlayer.removeInventoryItem("fish3",fish3)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = fish3 .. "條黃鰭鮪魚 $" .. fishs3, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, fish3 .. "條黃鰭鮪魚 $" .. fishs3)
        end

        if fish4 >= 1 then
            fishs4 = fish4*math.random(250,300)
            xPlayer.addMoney(fishs4)
            xPlayer.removeInventoryItem("fish4",fish4)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = fish4 .. "條白帶魚 $" .. fishs4, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, fish4 .. "條白帶魚 $" .. fishs4)
        end

        if fish5 >= 1 then
            fishs5 = fish5*math.random(4500,7000)
            xPlayer.addMoney(fishs5)
            xPlayer.removeInventoryItem("fish5",fish5)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = fish5 .. "條大口黑鱸 $" .. fishs5, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, fish5 .. "條大口黑鱸 $" .. fishs5)
        end

        if fish6 >= 1 then
            fishs6 = fish6*math.random(5500,9000)
            xPlayer.addMoney(fishs6)
            xPlayer.removeInventoryItem("fish6",fish6)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = fish6 .. "條龍膽石斑 $" .. fishs6, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, fish6 .. "條龍膽石斑 $" .. fishs6)
        end

        if polvo >= 1 then
            polvos = polvo*math.random(1000,2000)
            xPlayer.addMoney(polvos)
            xPlayer.removeInventoryItem("polvo",polvo)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = polvo .. "隻章魚 $" .. polvos, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, polvo .. "隻章魚 $" .. polvos)
        end

        if lobster >= 1 then
            lobsters = lobster*math.random(2500,3500)
            xPlayer.addMoney(lobsters)
            xPlayer.removeInventoryItem("lobster",lobster)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = lobster .. "隻龍蝦 $" .. lobsters, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, lobster .. "隻龍蝦 $" .. lobsters)
        end

        if oyster >= 1 then
            oysters = oyster*math.random(350,500)
            xPlayer.addMoney(oysters)
            xPlayer.removeInventoryItem("oyster2",oyster)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = oyster .. "顆牡蠣肉 $" .. oysters, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, oyster .. "顆牡蠣肉 $" .. oysters)
        end

        if turtlebait >= 1 then
            turtlebaits = turtlebait*math.random(300,450)
            xPlayer.addMoney(turtlebaits)
            xPlayer.removeInventoryItem("turtlebait",turtlebait)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = turtlebait .. "隻蝦 $" .. turtlebaits, 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, turtlebait .. "隻蝦 $" .. turtlebaits)
        end
        allget = fishs + fishs1 + fishs2 + fishs3 + fishs4 + fishs5 + fishs6 + polvos + lobsters + oysters + turtlebaits
        TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, '漁獲-魚販', "[交易通知]","~b~總收入 ~g~$" .. allget, 'CHAR_BOATSITE')
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = "無任何漁獲"})
    end
end)

RegisterServerEvent("fish:Sell2")
AddEventHandler("fish:Sell2", function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local pearl = xPlayer.getInventoryItem('pearl').count

    if pearl >= 1 then
        TriggerClientEvent("fish:fu",_source)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = "討價還價中...", length = 10000})
        Wait(10000)
        TriggerClientEvent("fish:unfu",_source)

        if pearl >= 1 then
            local pearl = xPlayer.getInventoryItem('pearl').count
            local pearls = pearl*math.random(75000,100000)
            xPlayer.addMoney(pearls)
            xPlayer.removeInventoryItem("pearl",pearl)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = pearl .. "顆珍珠 $" .. pearls, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "sellfish", "sellfish", xPlayer.name, pearl .. "顆珍珠 $" .. pearls)
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = "無珍珠"})
    end
end)

RegisterServerEvent("fish:Sell3")
AddEventHandler("fish:Sell3", function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local shark = xPlayer.getInventoryItem('shark').count
    local turtle = xPlayer.getInventoryItem('turtle').count
    local amount = shark + turtle

    if amount >= 1 then
        TriggerClientEvent("fish:fu",_source)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = "討價還價中...", length = 30000})
        Wait(30000)
        TriggerClientEvent("fish:unfu",_source)

        if shark >= 1 then
            local shark = xPlayer.getInventoryItem('shark').count
            local sharks = shark*math.random(75000,100000)
            xPlayer.addAccountMoney('black_money',sharks)
            xPlayer.removeInventoryItem("shark",shark)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = shark .. "條鯊魚 $" .. sharks, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "crime", "sellmeat", xPlayer.name, shark .. "條鯊魚 $" .. sharks)
        end

        if turtle >= 1 then
            local turtle = xPlayer.getInventoryItem('turtle').count
            local turtles = turtle*math.random(45000,65000)
            xPlayer.addAccountMoney('black_money',turtles)
            xPlayer.removeInventoryItem("fish",turtle)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = turtle .. "隻海龜 $" .. turtles, length = 5000})
            TriggerEvent('esx_joblogs:AddInLog', "crime", "sellmeat", xPlayer.name, turtle .. "隻海龜 $" .. turtles)
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = "無任何保育類"})
    end
end)
