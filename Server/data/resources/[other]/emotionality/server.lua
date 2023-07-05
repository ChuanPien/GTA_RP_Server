local function TableToString(tab)
	local str = ""
	for i = 1, #tab do
		str = str .. " " .. tab[i]
	end
	return str
end

-- --------------------------------------------
-- Commands
-- --------------------------------------------

RegisterCommand('smile', function(source, args)
	local text = " 😀 " 
	TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('sad', function(source, args)
    local text = " 🙁 " 
	TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('tear', function(source, args)
	local text = " 😥 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('cry', function(source, args)
	local text = " 😭 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('blush', function(source, args)
	local text = " 😊 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('shy', function(source, args)
	local text = " 😳 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('surprised', function(source, args)
	local text = " 😲 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('sick', function(source, args)
	local text = " 🤢 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('pissedoff', function(source, args)
	local text = " 😠 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('anger', function(source, args)
	local text = " 😡 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('laught', function(source, args)
	local text = " 😂 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('laught2', function(source, args)
	local text = " 🤣 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('surprised', function(source, args)
	local text = " 😲 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('dizzy', function(source, args)
	local text = " 😵 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('angel', function(source, args)
	local text = " 😇 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('demon', function(source, args)
	local text = " 😈 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('thumbeup', function(source, args)
	local text = " 👍 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('thumbdown', function(source, args)
	local text = " 👎 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('vomit', function(source, args)
	local text = " 🤮 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('tongue', function(source, args)
	local text = " 😜 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)

RegisterCommand('fear', function(source, args)
	local text = " 😱 "
    TriggerClientEvent('esx_emotionality:shareDisplay', -1, text, source)
end)