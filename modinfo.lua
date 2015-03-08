-- This information tells other players more about the mod
name = "Mod Character Balancing"
description = "Configure everything! Balance your characters, new leveling systems, items for new players, customize your experience. Basically GregTech."
author = "DrSmugleaf"
version = "2.0.0"

priority = -100

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""


-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = true
all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {"mod character rebalancing"}

configuration_options =
{

	{
        name = "TEST_OF_TESTIES_OF_USELESS_PLACEHOLDER_PANCAKES",
        label = "Hover over me!",
		hover = "Hover over any config option for details!",
        options =
        {
            {description = "And me!", data = 1, hover = "You can hover over these for information too!"},
            {description = "hey", data = 0, hover = "Do you want to build a snoowmaan"},
        },
        default = 1,
    },
	
	{
		name = "MOD_BALANCING_ENABLED",
		label = "Balance Mod Characters",
		hover = "Balance modded characters",
		options =	{
						{description = "Enabled", data = 1},
						{description = "Disabled", data = 0},
					},

		default = 1,
	},
	
	{
		name = "LEVEL_SETTING",
		label = "Character leveling",
		hover = "Needs balance mod characters enabled. New leveling or not, and difficulty",
		options =	{
						{description = "Disabled", data = 0, hover = "Keeps all leveling systems as is"},
						{description = "Easy", data = 1, hover = "Keeps all leveling systems as is, and adds more"},
						{description = "Normal", data = 2, hover = "Adds more leveling systems, 50 max lvl base"},
						{description = "Hard", data = 3, hover = "Adds more leveling systems, 75 max lvl base"},
						{description = "Very Hard", data = 4, hover = "Adds more leveling systems, 100 max lvl base"},
					},

		default = 2,
	},
	
	{
		name = "HARDCORE_MODE",
		label = "Ultrahard Mode",
		hover = "Make everything terrible. Will override most config settings",
		options =	{
						{description = "No", data = 0, hover = "Don't turn on ultrahard mode, I preffer living"},
						{description = "Yes", data = 1, hover = "HOLD ONTO YOUR PANTS"},
					},

		default = 0,
	},
	
	{
		name = "NERF_SPEED",
		label = "Nerf speed",
		hover = "Nerf characters speed to be more default. NOTE: Will buff other stats",
		options =	{
						{description = "No", data = 0, hover = "Don't nerf speed"},
						{description = "Yes", data = 1, hover = "Nerf speed but buff other stats to compensate"},
					},

		default = 0,
	},
	
	{
		name = "ENABLE_STARTING_ITEMS",
		label = "Starting Items",
		hover = "Enable Starting Items for new players",
		options =	{
						{description = "Yes", data = 1, hover = "Enable spawning with resources"},
						{description = "No", data = 0, hover = "Disable spawning with resources"},
					},

		default = 1,
	},
	
	{
		name = "AMOUNT_OF_FLINT",
		label = "Amount of flint",
		hover = "Amount of flint new players spawn with",
		options =	{
						{description = "Disabled", data = 0, hover = "Disable spawning with flint"},
						{description = "1", data = 1},
						{description = "2", data = 2},
						{description = "3", data = 3},
						{description = "4", data = 4},
						{description = "5", data = 5},
						{description = "6", data = 6},
						{description = "7", data = 7},
						{description = "8", data = 8},
						{description = "9", data = 9},
						{description = "10", data = 10},
					},

		default = 5,
	},
	
	{
		name = "AMOUNT_OF_GRASS",
		label = "Amount of grass",
		hover = "Amount of grass new players spawn with",
		options =	{
						{description = "Disabled", data = 0, hover = "Disable spawning with grass"},
						{description = "1", data = 1},
						{description = "2", data = 2},
						{description = "3", data = 3},
						{description = "4", data = 4},
						{description = "5", data = 5},
						{description = "6", data = 6},
						{description = "7", data = 7},
						{description = "8", data = 8},
						{description = "9", data = 9},
						{description = "10", data = 10},
					},

		default = 5,
	},
	
	{
		name = "AMOUNT_OF_LOGS",
		label = "Amount of logs",
		hover = "Amount of logs new players spawn with",
		options =	{
						{description = "Disabled", data = 0, hover = "Disable spawning with logs"},
						{description = "1", data = 1},
						{description = "2", data = 2},
						{description = "3", data = 3},
						{description = "4", data = 4},
						{description = "5", data = 5},
						{description = "6", data = 6},
						{description = "7", data = 7},
						{description = "8", data = 8},
						{description = "9", data = 9},
						{description = "10", data = 10},
					},

		default = 5,
	},
	
	{
		name = "AMOUNT_OF_MEAT",
		label = "Amount of meat",
		hover = "Amount of meat new players spawn with",
		options =	{
						{description = "Disabled", data = 0, hover = "Disable spawning with meat"},
						{description = "1", data = 1},
						{description = "2", data = 2},
						{description = "3", data = 3},
						{description = "4", data = 4},
						{description = "5", data = 5},
						{description = "6", data = 6},
						{description = "7", data = 7},
						{description = "8", data = 8},
						{description = "9", data = 9},
						{description = "10", data = 10},
					},

		default = 5,
	},
	
	{
		name = "AMOUNT_OF_TWIGS",
		label = "Amount of twigs",
		hover = "Amount of twigs new players spawn with",
		options =	{
						{description = "Disabled", data = 0, hover = "Disable spawning with twigs"},
						{description = "1", data = 1},
						{description = "2", data = 2},
						{description = "3", data = 3},
						{description = "4", data = 4},
						{description = "5", data = 5},
						{description = "6", data = 6},
						{description = "7", data = 7},
						{description = "8", data = 8},
						{description = "9", data = 9},
						{description = "10", data = 10},
					},

		default = 5,
	},
	
	{
		name = "GIVE_THERMAL_STONE",
		label = "Give thermal stone",
		hover = "Whether or not to give new players a thermal stone",
		options =	{
						{description = "Yes", data = 1, hover = "Give new players a thermal stone"},
						{description = "No", data = 0, hover = "Don't give new players a thermal stone"},
					},

		default = 1,
	},
	
	{
		name = "CRASHBANDICOOT_BALANCED",
		label = "Crash Bandicoot",
		hover = "Balance Crash Bandicoot, the Experiment",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "DARKSAKURA_BALANCED",
		label = "Dark Sakura",
		hover = "Balance Dark Sakura Matou",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	--[[{
		name = "DEVON_BALANCED",
		label = "Devon",
		hover = "Balance Devon, the Hunter",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},]]
	
	{
		name = "DROK_BALANCED",
		label = "Drok",
		hover = "Balance Drok, the Caveman",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "ENDIA_BALANCED",
		label = "Endia",
		hover = "Balance Endia, the Paranoid Elf",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "FAROZ_BALANCED",
		label = "Faroz",
		hover = "Balance Faroz, the Little Scholar",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "FILIA_BALANCED",
		label = "Filia",
		hover = "Balance Filia, the forgetful schoolgirl",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	--[[{
		name = "FIONNA_BALANCED",
		label = "Fionna",
		hover = "Balance Fionna",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},]]
	
	{
		name = "FREESPIRIT_BALANCED",
		label = "FreeSpirit",
		hover = "Balance Umbreon, the FreeSpirit",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	--[[{
		name = "GABEN_BALANCED",
		label = "Gaben",
		hover = "Release HL3",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},]]

	--[[{
		name = "GIR_BALANCED",
		label = "Gir",
		hover = "Balance Purswader's Gir",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},]]

	{
		name = "HARUZ_BALANCED",
		label = "Haruz",
		hover = "Balance Haruz, the Cowardly Dog",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	--[[{
		name = "HELLAMERDURIAL_BALANCED",
		label = "Hella Merdurial",
		hover = "Balance Hella Merdurial",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},]]
	
	{
		name = "LUFFY_BALANCED",
		label = "Luffy",
		hover = "Balance Luffy",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "MADELEINE_BALANCED",
		label = "Madeleine",
		hover = "Balance Madeleine, the Rich Cat",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "MICHAELTHEFOX_BALANCED",
		label = "Michael the Fox",
		hover = "Balance Michael the Fox, the Scaredy Cat",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "MIKUHATSUNE_BALANCED",
		label = "Miku Hatsune",
		hover = "Balance Miku Hatsune",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "MITSURU_BALANCED",
		label = "Mitsuru",
		hover = "Balance Mitsuru, the Winter Wolfy",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	--[[{
		name = "NEPTUNIA_BALANCED",
		label = "Neptunia",
		hover = "Balance Hyperdimension Neptunia: Neptune",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},]]
	
	{
		name = "SERAS_BALANCED",
		label = "Seras",
		hover = "Balance Seras, the Fledgling Vampire",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "SOLLYZ_BALANCED",
		label = "Sollyz",
		hover = "Balance Sollyz, the Cat Slap",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "SHOVELKNIGHT_BALANCED",
		label = "Shovel Knight",
		hover = "Balance Shovel Knight, the Blue Burrower",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "TAMAMO_BALANCED",
		label = "Tamamo",
		hover = "Balance Tamamo, Queen of Kitsunes",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	--[[{
		name = "THANA_BALANCED",
		label = "Thana",
		hover = "Balance Thana, the Nightstalker",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},]]
	
	--[[{
		name = "THEMEDIC_BALANCED",
		label = "The Medic",
		hover = "Balance The Medic",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},]]
	
	{
		name = "WARK_BALANCED",
		label = "Wark, the Chocobo",
		hover = "Balance Wark, the Chocobo",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "WOLF_BALANCED",
		label = "Wolf",
		hover = "Balance Wolf, the Lone Wolf",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	
	{
		name = "WOODIE_BALANCED",
		label = "Woodie",
		hover = "Balance Woodie, the Lumberjack",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},
	--[[{
		name = "ZIM_BALANCED",
		label = "Zim",
		hover = "Balance Purswader's Zim",
		options =	{
						{description = "Balanced", data = 1},
						{description = "Ignored", data = 0},
					},

		default = 1,
	},]]

}