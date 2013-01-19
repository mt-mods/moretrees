--[[

-- Example biome definition:

mytree_biome = {
	surface = "default:dirt_with_grass",	-- must grow on these nodes only
	avoid_nodes = {"default:tree"},		-- avoid spawning near these
	avoid_radius = 12,			-- Keep this much room around the above avoid items
	seed_diff = 12345,			-- perlin seed-diff for "generally able to grow plants here" control
	neighbors = "default:dirt_with_grass",	-- this node must be adjacent to the node being spawned on
	ncount = 8,				-- and there must be this many of them
	depth = 1,				-- spawning surface must be no deeper than this
	min_elevation = -5,			-- minimum elevation to spawn on
	max_elevation = 10,			-- maximum elevation
	near_nodes = {"default:water_source"},	-- trees will only spawn near these nodes
	near_nodes_size = 10,			-- within this radius of at least one of them
	near_nodes_count = 20,			-- there must ne this many of those nodes in the area
	temp_min = 0.5,				-- minimum allowable temperature (highest temperature map perlin value)
	temp_max = 0.1,				-- maximum allowable temperature (lowest perlin value)
}
]]--

moretrees.jungletree_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 12,
	seed_diff = 329,
	min_elevation = -5,
	max_elevation = 10,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 10,
--	temp_min = 0.05,
}

moretrees.conifer_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 359,
	min_elevation = 25,
	temp_min = 0.9,
	temp_max = 0.3,
}

moretrees.palm_biome = {
	surface = "default:sand",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 5,
	seed_diff = 330,
	min_elevation = -1,
	max_elevation = 1,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 10,
	temp_min = 0.15,
	temp_max = -0.15,
}

moretrees.apple_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 15,
	seed_diff = 331,
	min_elevation = 1,
	max_elevation = 10,
	temp_min = 0.1,
	temp_max = -0.15,
}

moretrees.oak_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 15,
	seed_diff = 332,
	min_elevation = 0,
	max_elevation = 10,
	temp_min = 0.4,
	temp_max = 0.2,
}

moretrees.sequoia_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 333,
	min_elevation = 0,
	max_elevation = 10,
	temp_min = 1,
	temp_max = -0.4,
}

moretrees.birch_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 5,
	seed_diff = 334,
	min_elevation = 10,
	max_elevation = 15,
	temp_min = 0.9,
	temp_max = 0.3,
}

moretrees.spruce_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 335,
	min_elevation = 20,
	temp_min = 0.9,
	temp_max = 0.7,
}

moretrees.pine_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 336,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 5,
}

moretrees.willow_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 20,
	seed_diff = 337,
	min_elevation = -5,
	max_elevation = 5,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 5,
}

moretrees.rubber_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 20,
	seed_diff = 338,
	min_elevation = -5,
	max_elevation = 5,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 10,
	temp_min = -0.15,
}

