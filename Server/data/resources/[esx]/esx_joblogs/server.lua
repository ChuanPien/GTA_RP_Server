--Create by
--Alex Garcio(https://github.com/RedAlex)
--Jade Perron(https://github.com/CaptnElizabeth)

-- TriggerEvent('esx_joblogs:AddInLog', 'Other', 'geti', xPlayer.name, amount, ESX.GetItemLabel(item))

ESX                  = nil
local LogAdmin       = ""
local LogAmbulance   = ""
local LogMecano      = ""
local LogPolice      = ""
local LogSheriff     = ""
local LogTaxi        = ""
local LogVehicleShop = ""

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendToDiscord (canal, name, message, color)
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds
local DiscordWebHook = canal
local embeds = {
    {
        ["title"]= message,
        ["type"]= "rich",
        ["color"] = color,
        ["footer"]=  {
        ["text"]= "Job_logs",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function loadLogs()
  LogAdmin       = LoadResourceFile("esx_joblogs", "Logs/admin.log")       or ""
  LogAmbulance   = LoadResourceFile("esx_joblogs", "Logs/ambulance.log")   or ""
  LogVehicleShop = LoadResourceFile("esx_joblogs", "Logs/vehicleshop.log") or ""
  LogMecano      = LoadResourceFile("esx_joblogs", "Logs/mecano.log")      or ""
  LogPolice      = LoadResourceFile("esx_joblogs", "Logs/police.log")      or ""
  LogSheriff     = LoadResourceFile("esx_joblogs", "Logs/sheriff.log")     or ""
  LogTaxi        = LoadResourceFile("esx_joblogs", "Logs/taxi.log")        or ""
end


function SaveInLog(job, message)
    if job == "admin" then
        LogAdmin = LogAdmin .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/admin.log", LogAdmin, -1)
          if Config.EnableDiscordLink == true then
            sendToDiscord(Config.webhookadmin, _U('admin_bot_name'), message, Config.orange)
          end
    elseif job == "ambulance" then
        LogAmbulance = LogAmbulance .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/ambulance.log", LogAmbulance, -1)
          if Config.EnableDiscordLink == true then
            sendToDiscord(Config.webhookambulance, _U('ambulance_bot_name'), message, Config.red)
          end
    elseif job == "vehicleshop" then
        LogVehicleShop = LogVehicleShop .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/vehicleshop.log", LogVehicleShop, -1)
          if Config.EnableDiscordLink == true then
            sendToDiscord(Config.webhookvehicleshop, _U('vehicleshop_bot_name'), message, Config.green)
          end
    elseif job == "police" then
        LogPolice = LogPolice .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/police.log", LogPolice, -1)
		  if Config.EnableDiscordLink == true then
            sendToDiscord(Config.webhookpolice, _U('police_bot_name'), message, Config.blue)
          end
    elseif job == "Other" then
        LogSheriff = LogSheriff .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/sheriff.log", LogSheriff, -1)
          if Config.EnableDiscordLink == true then
            sendToDiscord(Config.webhooksheriff, ('Property Log'), message, Config.orange)
          end
    elseif job == "weapon" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
            sendToDiscord(Config.webhookweaponshop, ('Weapon Log'), message, Config.orange)
          end
    elseif job == "money" then
      LogTaxi = LogTaxi .. message .. "\n"
      SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
        if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookmoney, ('Money Log'), message, Config.orange)
        end
    elseif job == "item" then
      LogTaxi = LogTaxi .. message .. "\n"
      SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
        if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookitem, ('Item Log'), message, Config.orange)
        end   
    elseif job == "Shoot" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookshoot, ('Shoot Log'), message, Config.red)
        end
    elseif job == "lscustom" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhooklscustom, ('Lscustom Log'), message, Config.blue)
        end
    elseif job == "speedtest" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookspeedtest, ('Speedtest Log'), message, Config.red)
        end
    elseif job == "drugs" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookdrugs, ('Drugs Log'), message, Config.red)
        end
    elseif job == "login" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhooklogin, ('Login Log'), message, Config.blue)
        end
    elseif job == "radio" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookradio, ('Radio Log'), message, Config.blue)
        end
    elseif job == "shop" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookshop, ('Shop Log'), message, Config.blue)
        end
    elseif job == "hunting" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookhunting, ('Hunting Log'), message, Config.blue)
        end
    elseif job == "crime" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookcrime, ('Crime Log'), message, Config.red)
        end
    elseif job == "billing" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookbilling, ('Billing Log'), message, Config.red)
        end
    elseif job == "sellfish" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookfish, ('SellFish Log'), message, Config.blue)
        end
    elseif job == "work" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookwork, ('Work Log'), message, Config.blue)
        end
    elseif job == "car" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookcar, ('Car Log'), message, Config.blue)
        end
    elseif job == "house" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookhouse, ('House Log'), message, Config.blue)
        end
    elseif job == "rent" then
        LogTaxi = LogTaxi .. message .. "\n"
        SaveResourceFile("esx_joblogs", "Logs/taxi.log", LogTaxi, -1)
          if Config.EnableDiscordLink == true then
          sendToDiscord(Config.webhookrent, ('Rent Log'), message, Config.blue)
        end
    end
end

RegisterServerEvent('esx_joblogs:AddInLog')
AddEventHandler('esx_joblogs:AddInLog', function(job, localetxt, info1, info2, info3, info4, info5, info6, info7)
  local _job        = job
  local _localetxt  = localetxt
  local _info1      = info1
  local _info2      = ''
  local _info3      = ''
  local _info4      = ''
  local _info5      = ''
  local _info6      = ''
  local _info7      = ''
  if info2 ~= nil then
    _info2 = info2
  end
  if info3 ~= nil then
    _info3 = info3
  end
  if info4 ~= nil then
    _info4 = info4
  end
  if info5 ~= nil then
    _info5 = info5
  end
  if info6 ~= nil then
    _info6 = info6
  end
  if info7 ~= nil then
    _info7 = info7
  end
  local message     = ""..os.date("%c\n") .. _U(_localetxt, _info1, _info2, _info3, _info4, _info5, _info6, _info7)
  SaveInLog(_job, message)
end)


-- loadLogs()
-- SaveInLog("admin", "["..os.date("%c").."] ' ".. _U("reboot"))
-- SaveInLog("ambulance", "["..os.date("%c").."] ' ".. _U("reboot"))
-- SaveInLog("vehicleshop", "["..os.date("%c").."] ' ".. _U("reboot"))
-- SaveInLog("mechanic", "["..os.date("%c").."] ' ".. _U("reboot"))
-- SaveInLog("police", "["..os.date("%c").."] ' ".. _U("reboot"))
-- SaveInLog("sheriff", "["..os.date("%c").."] ' ".. _U("reboot"))
-- SaveInLog("taxi", "["..os.date("%c").."] ' ".. _U("reboot"))
