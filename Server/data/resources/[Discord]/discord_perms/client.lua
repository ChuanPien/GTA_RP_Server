Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(615520072114634753)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo1')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('歡迎加入懶欣鎮!')

        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('logo2')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('discord.gg/ZKQE75XsCs')

        --It updates every one minute just in case.
		
		SetRichPresence('懶民活動中!')
		Citizen.Wait(60000)
	end
end)