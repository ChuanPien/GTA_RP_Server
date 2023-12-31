-- Discord Webhook Links (Replace these with your own Links) 
-- Need help setting it up? (https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks)
DiscordWebhookSystemInfos = 'https://discord.com/api/webhooks/844037127495090198/4yyoChjlNwQxw5v7g2U6jPiQuJjLD52pjO2ojyO_SSffKWpYpn9BwIzsL_LlIwDg_bhy'
DiscordWebhookChat = 'https://discord.com/api/webhooks/844036854340124713/SXocwhsE8aTjxloLVjyMKkZXT0ziZCaVVviyqVDQyFX1R-Y_cVAms6Bz4DEbjOhqHDHX'
DiscordWebhookKillinglogs = 'https://discord.com/api/webhooks/844037000205959178/bU73EhjLT33AqKabeQpB9fWB5TNrZIffynEBvJQAzNWsE1z7UqX986d_H35n-vKWExiX'

-- Bot/Client Avatar and UserName
SystemAvatar = 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png'

UserAvatar = 'https://i.imgur.com/KIcqSYs.png' -- Change this to a linn of your choice

SystemName = 'SYSTEM' -- Change this to a name of your choice!

-- How To Format and Setup Special Commands
--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]

-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command

-- These Are Your Special Commands!!
-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				    {'/me', '**[ME]:**'},
				    {'/fix', '**[FIX]:**'},
				    {'/dv', '**[DV]:**'},
				    {'/do', '**[DO]:**'},
				    {'/twt', '**[TWEET]:**'},
				    {'/news', '**[WEAZEL NEWS]:**'},
				    {'/ad', '**[ADVERTISEMENT]:**'},
				    {'/repair', '**[MECHANIC]:**'},
				    {'/dispatch', '**[DISPATCH]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/jail',					  
					   '/unjail',
					  }

-- Own WebHooks/Seperate Channels
-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/911', 'YOUR_WEBHOOK_HERE'},
					  {'/dispatch', 'YOUR_WEBHOOK_HERE'},
					  {'/me', 'YOUR_WEBHOOK_HERE'},
					  {'/fix', 'YOUR_WEBHOOK_HERE'},
					  {'/dv', 'YOUR_WEBHOOK_HERE'},
					  {'/twt', 'YOUR_WEBHOOK_HERE'},
					  {'/do', 'YOUR_WEBHOOK_HERE'},
					  {'/news', 'YOUR_WEBHOOK_HERE'},
					  {'/ad', 'YOUR_WEBHOOK_HERE'},
					  {'/repair', 'YOUR_WEBHOOK_HERE'},
					 }

-- Discord Text To Speech Friendly Commands
-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }

