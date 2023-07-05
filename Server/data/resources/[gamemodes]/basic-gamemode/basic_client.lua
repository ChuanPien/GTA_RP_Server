AddEventHandler('onClientMapStart', function()
  exports.spawnmanager:setAutoSpawn(false)
  exports.spawnmanager:forceRespawn(false)
end)
