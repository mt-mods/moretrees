-- Configuration variables

-- Enable replacement of default trees with birch if you want but be warned -
-- due to bugs in the speed of the engine's map generator/loader, doing so\
-- will slow it WAY down.

moretrees.enable_replace_default_trees = false

-- Enable the first one if you want this mod's leafdecay code to affect the 
-- old default trees.  You'll want to manually disable the default leafdecay
-- code in minetest_game if you enable this.

moretrees.enable_default_leafdecay = false

-- various settings to configure leaf decay in general.

moretrees.leafdecay_delay = 2
moretrees.leafdecay_chance = 150
moretrees.leafdecay_radius = 5

moretrees.palm_leafdecay_radius = 8

moretrees.default_leafdecay_delay = 2
moretrees.default_leafdecay_chance = 50
moretrees.default_leafdecay_radius = 4

-- Change these settings if you want default trees to be gradually cut down
-- above the elevation where firs normally generate.

moretrees.firs_remove_default_trees = false
moretrees.firs_remove_interval = 2
moretrees.firs_remove_chance = 150

