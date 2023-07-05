-- ESX.ShowFloatingHelpNotification('用心用力用腦做', vector3(471.78,-1309.05,30.05))

--[[
server端呼叫

TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '123'})   ', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })

client端呼叫

exports['mythic_notify']:DoHudText('inform', '123') , { ['background-color'] = '#ffffff', ['color'] = '#000000' })

inform / error / success / note

]]
RegisterNetEvent('mythic_notify:client:SendAlert')
AddEventHandler('mythic_notify:client:SendAlert', function(data)
	DoCustomHudText(data.type, data.text, data.length, data.style)
end)

RegisterNetEvent('mythic_notify:client:PersistentHudText')
AddEventHandler('mythic_notify:client:PersistentHudText', function(data)
	PersistentHudText(data.action, data.id, data.type, data.text, data.style)
end)

function DoShortHudText(type, text, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = 1000,
		style = style
	})
end

function DoHudText(type, text, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = 2500,
		style = style
	})
end

function DoLongHudText(type, text, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = 5000,
		style = style
	})
end

function DoCustomHudText(type, text, length, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = length,
		style = style
	})
end

function PersistentHudText(action, id, type, text, style)
	if action:upper() == 'START' then
		SendNUIMessage({
			persist = action,
			id = id,
			type = type,
			text = text,
			style = style
		})
	elseif action:upper() == 'END' then
		SendNUIMessage({
			persist = action,
			id = id
		})
	end
end