resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

-- Example custom radios
supersede_radio "RADIO_01_CLASS_ROCK" { url = "https://22893.live.streamtheworld.com/YES933_PREM.aac", volume = 1 } --Yes 93.3 FM
supersede_radio "RADIO_02_POP" { url = "https://22253.live.streamtheworld.com/883JIAAAC.aac", volume = 1 } --883 Jia FM
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://n16.rcs.revma.com/ndk05tyy2tzuv?rj-ttl=5&rj-tok=AAABeawznfUAOtMUy1Bku6eD8Q", volume = 1 } -- i Radio中廣音樂網
supersede_radio "RADIO_04_PUNK" { url = "http://radiocast.brutusmedia.it:8000/stream.aac", volume = 1 } -- Radio Italia Cina
supersede_radio "RADIO_05_TALK_01" { url = "https://antares.dribbcast.com/proxy/cpop?mp=/s", volume = 1 } -- Big B Radio - CPOP
supersede_radio "RADIO_06_COUNTRY" { url = "https://ais-sa5.cdnstream1.com/b14981_128mp3", volume = 1 } -- Hits 94
supersede_radio "RADIO_07_DANCE_01" { url = "https://22533.live.streamtheworld.com/SLAM_MP3_SC", volume = 1 } -- SLAM!
supersede_radio "RADIO_08_MEXICAN" { url = "https://22193.live.streamtheworld.com/TLPSTR09.mp3", volume = 1 } -- 538 Non Stop
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "https://21253.live.streamtheworld.com/WEB02_MP3_SC", volume = 1 } -- 100% NL Non-stop

supersede_radio "RADIO_12_REGGAE" { url = "https://pureplay.cdnstream1.com/6038_128.mp3", volume = 1 } -- 100hitz The Mix - 80s 90s & Today's Hits
supersede_radio "RADIO_13_JAZZ" { url = "https://patmos.cdnstream.com/proxy/aamppcre?mp=/stream", volume = 1 } -- ADR.FM - Electronic Dance Experience (EDE)
supersede_radio "RADIO_14_DANCE_02" { url = "https://uk6.internet-radio.com/proxy/realdanceradio?mp=/live", volume = 1 } -- Real Dance Radio
supersede_radio "RADIO_15_MOTOWN" { url = "http://node-19.zeno.fm/cygwwun7a5zuv?rj-ttl=5&rj-tok=AAABeax3G-QAHno3luBbexFhnA", volume = 1 } -- Dance FM
supersede_radio "RADIO_20_THELAB" { url = "https://ice9.securenetsystems.net/KGAY", volume = 1 } -- K-GAY 106.5
supersede_radio "RADIO_16_SILVERLAKE" { url = "https://stream.live.vc.bbcmedia.co.uk/bbc_1xtra", volume = 1 } -- BBC Radio 1Xtra
supersede_radio "RADIO_17_FUNK" { url = "http://208.92.55.36/WYRBFMAAC_SC", volume = 1 } -- Power 106
supersede_radio "RADIO_18_90S_ROCK" { url = "https://live.powerhitz.com/hot108", volume = 1 } -- Hot 108 Jamz

supersede_radio "RADIO_21_DLC_XM17" { url = "https://igor.torontocast.com:1025/;", volume = 1 } -- asia DREAM radio - Japan Hits
supersede_radio "RADIO_22_DLC_BATTLE_MIX1_RADIO" { url = "https://igor.torontocast.com:1025/;", volume = 1 } -- asia DREAM radio - Japan Hits

-- supersede_radio "RADIO_19_USER" { url = "", volume = 1 }
-- supersede_radio "RADIO_20_THELAB" { url = "", volume = 1 }
-- supersede_radio "RADIO_11_TALK_02" { url = "", volume = 1 }
-- supersede_radio "RADIO_34_DLC_HEI4_KULT" { url = "", volume = 1 }
-- supersede_radio "RADIO_35_DLC_HEI4_MLR" { url = "", volume = 1 }


files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}
