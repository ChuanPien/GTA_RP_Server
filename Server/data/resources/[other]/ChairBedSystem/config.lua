Config = {}

Config.Healing = 0 -- // If this is 0, then its disabled.. Default: 3.. That means, if a person lies in a bed, then he will get 1 health every 3 seconds.

Config.objects = {
	ButtonToSitOnChair = 58, -- // Default: G -- // https://docs.fivem.net/game-references/controls/
	ButtonToLayOnBed = 38, -- // Default: E -- // https://docs.fivem.net/game-references/controls/
	ButtonToStandUp = 23, -- // Default: F -- // https://docs.fivem.net/game-references/controls/
	SitAnimation = {anim='PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'},
	BedBackAnimation = {dict='anim@gangops@morgue@table@', anim='ko_front'},
	BedStomachAnimation = {anim='WORLD_HUMAN_SUNBATHE'},
	BedSitAnimation = {anim='WORLD_HUMAN_PICNIC'},
	locations = {
		{object="gabz_pillbox_diagnostics_bed_01", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="gabz_pillbox_diagnostics_bed_02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="gabz_pillbox_diagnostics_bed_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="v_med_bed1", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="v_med_bed2", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="v_19_bubbles", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="v_19_stp3fistank", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="v_19_stp3fistank2", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="v_serv_ct_chair02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, bed=false},
		{object="prop_off_chair_04", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_chair_04a", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_ld_toilet_01", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_off_chair_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_off_chair_05", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_club_officechair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_ilev_leath_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_corp_offchair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_med_emptybed", verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-0.2, direction=90.0, bed=true},
		{object="Prop_Off_Chair_01", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object="prop_cs_office_chair", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object="gabz_mrpd_cell_bench", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object="gabz_mrpd_cell_bed", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=true}
	}
}

-- // YOU WILL FIND ALL BUTTONS HERE FOR CODE BELOW;P
-- [[ https://docs.fivem.net/game-references/controls/ ]]

Config.Text = {
	SitOnChair = '[~y~G~s~]坐下',
	SitOnBed = '[~y~E~s~]]坐在床上',
	LieOnBed = '[~y~E~s~]]躺在',
	SwitchBetween = '⬅~r~或➡更換姿勢',
	Standup = '[~y~F~s~]離開',
}