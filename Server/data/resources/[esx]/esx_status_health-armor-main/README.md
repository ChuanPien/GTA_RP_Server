# esx_status_health-armor
FiveM Script - ESX Status - Health & Armor | Status will be saved in Databse and restore after Relog

**Discord Support:** https://discord.gg/5hHSBRHvJE

## Description
* Health and Armor will be saved in Databse.
* Script checks all `Config.Refresh` times your health & armor status and save it in database.
* If a Player joins your server, then the Player get the saved status from database.

## Config
```lua
Config = {}
----------------------------------------------------------------
Config.Locale = 'de'
Config.VersionChecker = true
Config.Debug = false
----------------------------------------------------------------
-- How often Armor Status should be saved in database
Config.EnableRefresh = true
Config.Refresh = 30 -- in seconds (default: 30 seconds)
```
## Requirements
* ESX 1.2 *(v1-final)*
* MySQL-Async or OxMySQL *(Changeble in fxmanifest.lua)*

Should work with ESX Legacy too but I didn't test it.

## License
**GNU General Public License v3.0**
