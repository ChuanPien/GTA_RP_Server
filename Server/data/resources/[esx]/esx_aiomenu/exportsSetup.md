You need to add the following lines to BOTTOM your files.
You need to add the following lines to BOTTOM your files.
You need to add the following lines to BOTTOM your files.
You need to add the following lines to BOTTOM your files.
You need to add the following lines to BOTTOM your files.
You need to add the following lines to BOTTOM your files.


============================================
==     esx_mechanicjob/__resource.lua     ==  
==				     ADD                  == 
============================================

exports {
  'OpenMobileMechanicActionsMenu'
}

============================================
==       esx_taxijob/__resource.lua       ==  
==				     ADD                  == 
============================================

exports {
  'OpenMobileTaxiActionsMenu'
}

============================================
==     esx_policejob/__resource.lua       ==  
==				     ADD                  == 
============================================

exports {
  'OpenPoliceActionsMenu'
}

============================================
==     esx_ambulancejob/__resource.lua    ==  
==				     ADD                  == 
============================================

exports {
  'OpenMobileAmbulanceActionsMenu'
}

============================================
==       esx_animations/__resource.lua    ==  
==				     ADD                  == 
============================================

exports {
  'OpenAnimationsMenu'
}

============================================
==       esx_voice/__resource.lua         ==  
==				     ADD                  == 
============================================

exports {
  'setVoice'
}

============================================
==      esx_voice/client/main.lua         ==  
==				     ADD                  == 
============================================

function setVoice()
    voice.current = (voice.current + 1) % 3

    if voice.current == 0 then
        NetworkSetTalkerProximity(voice.default)
        voice.level = _U('normal')
    elseif voice.current == 1 then
        NetworkSetTalkerProximity(voice.shout)
        voice.level = _U('shout')
    elseif voice.current == 2 then
        NetworkSetTalkerProximity(voice.whisper)
        voice.level = _U('whisper')
    end
end

============================================
==        esx_billing/__resource.lua      ==
==				   ADD                    == 
============================================

exports {
  'ShowBillsMenu'
}