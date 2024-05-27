local stg = minetest.settings

--spawns tree on mapgen as saplings, legacy setting
moretrees.spawn_saplings		= stg:get_bool("moretrees.spawn_saplings", true)

--enable plantlike drawtype for leaves
moretrees.plantlike_leaves		= stg:get_bool("moretrees.plantlike_leaves", false)

-- Enable this if you want moretrees to redefine default apples so that they
-- fall when leaves decay/are dug.
moretrees.enable_redefine_apple		= stg:get_bool("moretrees.enable_redefine_apple", true)

-- Set this to true to enable leaf decay of all trees except the default ones.
moretrees.enable_leafdecay		= stg:get_bool("moretrees.enable_leafdecay", true)

-- various related settings to configure leaf decay.
moretrees.leafdecay_delay		= tonumber(stg:get("moretrees.leafdecay_delay")) or 2
moretrees.leafdecay_chance		= tonumber(stg:get("moretrees.leafdecay_chance")) or 5
moretrees.leafdecay_radius		= tonumber(stg:get("moretrees.leafdecay_radius")) or 5
moretrees.palm_leafdecay_radius		= tonumber(stg:get("moretrees.palm_leafdecay_radius")) or 10
moretrees.date_palm_leafdecay_radius	= tonumber(stg:get("moretrees.date_palm_leafdecay_radius")) or 14

-- Change these settings if you want default trees to be gradually cut down
-- above the elevation where firs normally generate.
moretrees.firs_remove_default_trees	= stg:get_bool("moretrees.firs_remove_default_trees", false)
moretrees.firs_remove_interval		= tonumber(stg:get("moretrees.firs_remove_interval")) or 2
moretrees.firs_remove_chance		= tonumber(stg:get("moretrees.firs_remove_chance")) or 150

-- Cocos palm settings
moretrees.coconuts_regrow		= stg:get_bool("moretrees.coconuts_regrow", true)
moretrees.coconuts_convert_existing_palms = stg:get_bool("moretrees.coconuts_convert_existing_palms", true)
moretrees.coconut_flower_interval	= tonumber(stg:get("moretrees.coconut_flower_interval")) or 59
moretrees.coconut_flower_chance		= tonumber(stg:get("moretrees.coconut_flower_chance")) or 67
moretrees.coconut_grow_interval		= tonumber(stg:get("moretrees.coconut_grow_interval")) or
    2 * moretrees.coconut_flower_interval * moretrees.coconut_flower_chance
moretrees.coconut_item_drop_ichance	= tonumber(stg:get("moretrees.coconut_item_drop_ichance")) or 10

-- Date palm settings
moretrees.dates_regrow_pollinated	= stg:get_bool("moretrees.dates_regrow_pollinated", true)
moretrees.dates_regrow_unpollinated_percent	= tonumber(stg:get("moretrees.dates_regrow_unpollinated_percent")) or 0
moretrees.dates_female_percent		= tonumber(stg:get("moretrees.dates_female_percent")) or 57
moretrees.dates_pollination_distance	= tonumber(stg:get("moretrees.dates_pollination_distance")) or 120
moretrees.dates_blossom_search_time_treshold = tonumber(stg:get("moretrees.dates_blossom_search_time_treshold")) or 1000
moretrees.dates_blossom_search_iload = tonumber(stg:get("moretrees.dates_blossom_search_iload")) or 10
moretrees.dates_flower_interval		= tonumber(stg:get("moretrees.dates_flower_interval")) or 59
moretrees.dates_flower_chance		= tonumber(stg:get("moretrees.dates_flower_chance")) or 181
moretrees.dates_grow_interval		= tonumber(stg:get("moretrees.dates_grow_interval")) or
    2 * moretrees.dates_flower_interval * moretrees.dates_flower_chance
moretrees.dates_item_drop_ichance	= tonumber(stg:get("moretrees.dates_item_drop_ichance")) or 10

-- Sapling settings
moretrees.sapling_interval		= 100
moretrees.sapling_chance		= 5

-- Enable this only if you have used an old moretrees version which was using biome_lib
-- and when you notice large areas with ongen saplings that don't grow
moretrees.grow_legacy_saplings	= stg:get_bool("moretrees.grow_legacy_saplings", false)

-- If this variable is set to true, drop leaves out as entities during leaf
-- decay, rather than just disappearing them.
moretrees.decay_leaves_as_items = stg:get_bool("moretrees.decay_leaves_as_items", false)

-- this is an internal setting for games that only have one type of planks
moretrees.enable_planks = xcompat.gameid ~= "voxelgarden"