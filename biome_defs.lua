
-- TODO
-- Use biomes in the decoration definition depending on their heat_point humidity_point
-- instead of spawning it with a rather low fill_ratio everywhere
local ratio_abundant =  0.001
local ratio_common =    0.0005
local ratio_normal =    0.0003
local ratio_uncommon =  0.0002
local ratio_rare =      0.0001
local ratio_very_rare = 0.00003

local coniferous_place_on = {
	xcompat.materials.dirt_with_grass,
	"default:dirt_with_coniferous_litter"
}

moretrees.beech_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	fill_ratio = ratio_normal,
}

moretrees.palm_biome = {
	place_on = xcompat.materials.sand,
	min_elevation = -1,
	max_elevation = 1,
	fill_ratio = ratio_abundant,
}

moretrees.date_palm_biome = {
	place_on = xcompat.materials.desert_sand,
	min_elevation = -1,
	max_elevation = 8,
	fill_ratio = ratio_common,
}

moretrees.date_palm_biome_2 = {
	place_on = xcompat.materials.desert_sand,
	min_elevation = 9,
	max_elevation = 30,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 1,
	fill_ratio = ratio_abundant,
}

moretrees.apple_tree_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 1,
	max_elevation = 10,
	biomes = {"deciduous_forest"},
	fill_ratio = ratio_rare,
}

moretrees.oak_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 10,
	fill_ratio = ratio_normal,
}

moretrees.sequoia_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 10,
	fill_ratio = ratio_rare,
}

moretrees.birch_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 10,
	max_elevation = 15,
	fill_ratio = ratio_common,
}

moretrees.willow_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = -5,
	max_elevation = 5,
	fill_ratio = ratio_uncommon,
}

moretrees.rubber_tree_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = -5,
	max_elevation = 8,
	fill_ratio = ratio_normal,
}

moretrees.jungletree_biome = {
	place_on = {
		xcompat.materials.dirt,
		xcompat.materials.dirt_with_grass,
		"woodsoils:dirt_with_leaves_1",
		"woodsoils:grass_with_leaves_1",
		"woodsoils:grass_with_leaves_2",
		"default:dirt_with_rainforest_litter",
	},
	min_elevation = 1,
	spawn_by = minetest.get_modpath("default") and {"default:jungletree"} or nil,
	num_spawn_by = minetest.get_modpath("default") and 1 or nil,
	biomes = {"rainforest", "rainforest_swamp"},
}

moretrees.spruce_biome = {
	place_on = coniferous_place_on,
	min_elevation = 20,
	fill_ratio = ratio_uncommon,
}

moretrees.cedar_biome = {
	place_on = coniferous_place_on,
	min_elevation = 0,  --Added to solve an issue where cedar trees would sometimes spawn deep underground
	fill_ratio = ratio_rare,
}


-- Poplar requires a lot of water.
moretrees.poplar_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 3,
	fill_ratio = ratio_abundant,
}

-- Spawn an occasional poplar elsewhere.
moretrees.poplar_biome_2 = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	fill_ratio = ratio_very_rare,
}

-- Subterranean lakes provide enough water for poplars to grow
moretrees.poplar_biome_3 = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = -50,
	max_elevation = 0,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 3,
	fill_ratio = ratio_abundant,
}

moretrees.poplar_small_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 1,
	fill_ratio = ratio_normal,
}

moretrees.poplar_small_biome_2 = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 5,
	fill_ratio = ratio_abundant,
}


moretrees.fir_biome = {
	place_on = coniferous_place_on,
	min_elevation = 25,
	fill_ratio = ratio_normal,
}

moretrees.fir_biome_snow = {
	place_on = {"snow:dirt_with_snow", "snow:snow"},
	below_nodes = {xcompat.materials.dirt, xcompat.materials.dirt_with_grass, "snow:dirt_with_snow"},
	fill_ratio = ratio_normal,
}
