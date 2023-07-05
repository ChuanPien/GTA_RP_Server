Crafting = {}

Crafting.Locations = {
    [1] = {x=606.67, y=-3092.75, z=6.0},
}

Crafting.Items = {
    ["iron_plate"] = {
        label = "鐵板",
        needs = {
            ["iron"] = {label = "某材料個數", count = 2},
        },
        threshold = 0,
    },
	["copper_plate"] = {
        label = "銅板",
        needs = {
            ["copper"] = {label = "某材料個數", count = 2},
        },
        threshold = 0,
    },
	["steel"] = {
        label = "鋼碇",
        needs = {
            ["iron"] = {label = "某材料個數", count = 1},
            ["copper"] = {label = "某材料個數", count = 1},
        },
        threshold = 0,
    },
	["steel_plate"] = {
        label = "鋼板",
        needs = {
            ["steel"] = {label = "某材料個數", count = 2},
        },
        threshold = 0,
    },
    ["fishingrod"] = {
        label = "釣魚竿",
        needs = {
            ["hook"] = {label = "某材料個數", count = 1},
            ["line"] = {label = "某材料個數", count = 2},
            ["stick"] = {label = "某材料個數", count = 2},
        },
        threshold = 0,
    },
	["line"] = {
        label = "線",
        needs = {
            ["wool"] = {label = "某材料個數", count = 2},
        },
        threshold = 0,
    },
	["hook"] = {
        label = "鉤子",
        needs = {
            ["iron"] = {label = "某材料個數", count = 2},
        },
        threshold = 0,
    },
	["armor"] = {
        label = "破爛防彈衣",
        needs = {
            ["fabric"] = {label = "某材料個數", count = 2},
        },
        threshold = 0,
    },
	["armor1"] = {
        label = "初階防彈衣",
        needs = {
            ["fabric"] = {label = "某材料個數", count = 2},
            ["copper_plate"] = {label = "某材料個數", count = 2},
        },
        threshold = 0,
    },
	["armor2"] = {
        label = "中階防彈衣",
        needs = {
            ["iron_plate"] = {label = "鐵板", count = 2},
            ["fabric"] = {label = "布料", count = 3},
        },
        threshold = 200,
    },
	["armor3"] = {
        label = "高階防彈衣",
        needs = {
            ["steel_plate"] = {label = "鋼板", count = 3},
            ["fabric"] = {label = "布料", count = 5},
        },
        threshold = 200,
    },
	["shovel"] = {
        label = "鏟子",
        needs = {
            ["iron_plate"] = {label = "某材料個數", count = 1},
            ["stick"] = {label = "某材料個數", count = 1},
        },
        threshold = 0,
    },
	["oysterknife"] = {
        label = "生蠔刀",
        needs = {
            ["iron_plate"] = {label = "某材料個數", count = 1},
            ["stick"] = {label = "某材料個數", count = 1},
        },
        threshold = 0,
    },
	["rake"] = {
        label = "耙子",
        needs = {
            ["iron_plate"] = {label = "某材料個數", count = 1},
            ["stick"] = {label = "某材料個數", count = 1},
        },
        threshold = 0,
    },
	["fertilizer"] = {
        label = "肥料",
        needs = {
            ["soil"] = {label = "某材料個數", count = 1},
            ["fishmeat"] = {label = "某材料個數", count = 1},
            ["fishbait"] = {label = "某材料個數", count = 3},
        },
        threshold = 0,
    },
	["fixkit"] = {
        label = "緊急修車包",
        needs = {
            ["iron"] = {label = "某材料個數", count = 5},
            ["cutted_wood"] = {label = "某材料個數", count = 5},
        },
        threshold = 100,
    },
	["stick"] = {
        label = "木棍",
        needs = {
            ["cutted_wood"] = {label = "某材料個數", count = 2},
        },
        threshold = 0,
    },
    ["box"] = {
        label = "箱子",
        needs = {
            ["cardboard"] = {label = "厚紙板", count = 3}
        },
        threshold = 200,
    },
	["parachute"] = {
        label = "降落傘",
        needs = {
            ["line"] = {label = "線", count = 5},
            ["fabric"] = {label = "布料", count = 10},
        },
        threshold = 100,
    },
	["receiver"] = {
        label = "接收器",
        needs = {
            ["iron_plate"] = {label = "材料", count = 1},
            ["copper_plate"] = {label = "材料", count = 1},
            ["steel_plate"] = {label = "材料", count = 1},
            ["diamond"] = {label = "材料", count = 1},
        },
        threshold = 150,
    },
    ------大量
    ["iron_plates"] = {
        label = "大量鐵板",
        needs = {
            ["iron"] = {label = "鐵錠", count = 65},
        },
        threshold = 200,
    },
	["copper_plates"] = {
        label = "大量銅板",
        needs = {
            ["copper"] = {label = "銅錠", count = 65},
        },
        threshold = 200,
    },
    ["steels"] = {
        label = "大量鋼錠",
        needs = {
            ["iron"] = {label = "鐵錠", count = 30},
            ["copper"] = {label = "銅錠", count = 30},
        },
        threshold = 200,
    },
	["steel_plates"] = {
        label = "大量鋼板",
        needs = {
            ["steel"] = {label = "鋼錠", count = 65},
        },
        threshold = 200,
    },
    ["fishingrods"] = {
        label = "大量釣魚竿",
        needs = {
            ["hook"] = {label = "鉤子", count = 40},
            ["line"] = {label = "線", count = 65},
            ["stick"] = {label = "木棍", count = 65},
        },
        threshold = 200,
    },
	["lines"] = {
        label = "大量線",
        needs = {
            ["wool"] = {label = "羊毛", count = 65},
        },
        threshold = 200,
    },
	["hooks"] = {
        label = "大量鉤子",
        needs = {
            ["iron"] = {label = "鐵錠", count = 65},
        },
        threshold = 200,
    },
	["shovels"] = {
        label = "大量鏟子",
        needs = {
            ["iron_plate"] = {label = "鐵板", count = 35},
            ["stick"] = {label = "木棍", count = 35},
        },
        threshold = 200,
    },
	["boxs"] = {
        label = "大量箱子",
        needs = {
            ["cardboard"] = {label = "厚紙板", count = 100}
        },
        threshold = 200,
    },
	["oysterknifes"] = {
        label = "大量生蠔刀",
        needs = {
            ["iron_plate"] = {label = "鐵板", count = 30},
            ["cutted_wood"] = {label = "木棍", count = 30},
        },
        threshold = 200,
    },
	["rakes"] = {
        label = "大量耙子",
        needs = {
            ["iron_plate"] = {label = "鐵板", count = 30},
            ["stick"] = {label = "木棍", count = 30},
        },
        threshold = 200,
    },
	["fertilizers"] = {
        label = "大量肥料",
        needs = {
            ["soil"] = {label = "泥土", count = 25},
            ["fishmeat"] = {label = "鯛魚肉塊", count = 30},
            ["fishbait"] = {label = "蚯蚓", count = 100},
        },
        threshold = 200,
    },
    ["sticks"] = {
        label = "大量木棍",
        needs = {
            ["cutted_wood"] = {label = "某材料個數", count = 65},
        },
        threshold = 200,
    },
}