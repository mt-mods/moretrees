leaves = {
	{"beech",		"Beech Leaves"},
	{"apple_tree", 		"Apple Tree Leaves"},
	{"oak",			"Oak Leaves"},
	{"sequoia",		"Sequoia Needles"},
	{"birch",		"Birch Leaves"},
	{"palm",		"Palm Leaves"},
	{"spruce",		"Spruce Needles"},
	{"pine",		"Pine Needles"},
	{"willow",		"Willow Leaves"},
	{"rubber_tree",		"Rubber Tree Leaves"},
}

moretrees.avoidnodes = {}

table.insert(moretrees.avoidnodes, "default:jungletree")
table.insert(moretrees.avoidnodes, "moretrees:jungletree_trunk")
table.insert(moretrees.avoidnodes, "moretrees:jungletree_leaves_red")
table.insert(moretrees.avoidnodes, "moretrees:jungletree_leaves_green")
table.insert(moretrees.avoidnodes, "moretrees:jungletree_leaves_yellow")
table.insert(moretrees.avoidnodes, "moretrees:fir_trunk")
table.insert(moretrees.avoidnodes, "moretrees:fir_leaves")
table.insert(moretrees.avoidnodes, "moretrees:fir_leaves_bright")

for i in ipairs(leaves) do
	local name = leaves[i]
	minetest.register_node("moretrees:"..leaves[i][1].."_leaves", {
		description = leaves[i][2],
		drawtype = "allfaces_optional",
		tiles = { "moretrees_"..leaves[i][1].."_leaves.png" },
		paramtype = "light",
		groups = {tree=1, snappy=3, flammable=2},
		sounds = default.node_sound_leaves_defaults(),
	})
	table.insert(moretrees.avoidnodes, "moretrees:"..leaves[i][1].."_leaves")
	end
	
trees = {
	{"beech",	"Beech",	nil,		nil,		nil				},
	{"apple_tree",	"Apple Tree",	nil,		nil,		nil				},
	{"oak",		"Oak",		"acorn",	"Acorn",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}	},
	{"sequoia",	"Sequoia",	nil,		nil,		nil				},
	{"birch",	"Birch",	nil,		nil,		nil				},
	{"palm",	"Palm",		"coconut",	"Coconut",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}	},
	{"spruce",	"Spruce",	"spruce_cone",	"Spruce Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}	},
	{"pine",	"Pine",		"pine_cone",	"Pine Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}	},
	{"willow",	"Willow",	nil,		nil,		nil				},
	{"rubber_tree",	"Rubber Tree",	nil,		nil,		nil				},
}

simple_trees = { "beech", "apple_tree", "oak", "sequoia", "palm", "pine", "willow", "rubber_tree"}

for i in ipairs(trees) do
	local treename = trees[i][1]
	local treedesc = trees[i][2]
	local fruit = trees[i][3]
	local fruitdesc = trees[i][4]
	local selbox = trees[i][5]

	table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_trunk")

	minetest.register_node("moretrees:"..treename.."_trunk", {
		description = treedesc.." Trunk",
		tiles = {
			"moretrees_"..treename.."_top.png",
			"moretrees_"..treename.."_top.png",
			"moretrees_"..treename..".png"
		},
		is_ground_content = true,
		groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
		sounds = default.node_sound_wood_defaults(),
	})

	minetest.register_node("moretrees:"..treename.."_trunk_sideways", {
		description = treedesc.." Trunk (sideways)",
		tiles = {
			"moretrees_"..treename..".png^[transformR90",
			"moretrees_"..treename..".png^[transformR90",
			"moretrees_"..treename.."_top.png",
			"moretrees_"..treename.."_top.png",
			"moretrees_"..treename..".png^[transformR90",
			"moretrees_"..treename..".png^[transformR90"
		},
		is_ground_content = true,
		groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
		sounds = default.node_sound_wood_defaults(),
	})

	minetest.register_node("moretrees:"..treename.."_planks", {
		description = treedesc.." Planks",
		tiles = {"moretrees_"..treename.."_wood.png"},
		is_ground_content = true,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
		sounds = default.node_sound_wood_defaults(),
	})

	minetest.register_node("moretrees:"..treename.."_sapling", {
	description = treedesc.." Sapling",
	drawtype = "plantlike",
	tiles = {"moretrees_"..treename.."_sapling.png"},
	inventory_image = "moretrees_"..treename.."_sapling.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
	sounds = default.node_sound_defaults(),
	})
	
	if (fruit ~= nil) then
		minetest.register_node("moretrees:"..fruit, {
			description = fruitdesc,
			drawtype = "plantlike",
			tiles = { "moretrees_"..fruit..".png" },
			inventory_image = "moretrees_"..fruit..".png",
			paramtype = "light",
			sunlight_propagates = true,
			walkable = false,
			selection_box = {
				type = "fixed",
					fixed = selbox
				},
			groups = {fleshy=3,dig_immediate=3,flammable=2},
			sounds = default.node_sound_defaults(),
		})
	end

end

-- Nodes for jungle trees

minetest.register_node("moretrees:jungletree_sapling", {
	description = "Jungle Tree Sapling",	
	drawtype = "plantlike",	
	tiles = {"moretrees_jungletree_sapling.png"},	
	inventory_image = "moretrees_jungletree_sapling.png",
	paramtype = "light",	
	walkable = false,	
	groups = {snappy=2,dig_immediate=3,flammable=2},
})

minetest.register_node("moretrees:jungletree_trunk", {
	description = "Jungle Tree trunk (sideways)",	
	tiles = {
		"default_jungletree_top.png",
		"default_jungletree_top.png",
		"default_jungletree.png",
		"default_jungletree.png",
		"default_jungletree.png",
		"default_jungletree.png"
	},
	groups = {wood=1,snappy=2,dig_immediate=3,flammable=2},
})

minetest.register_node("moretrees:jungletree_planks", {
	description = "Jungle Tree Planks",
	tiles = {
		"moretrees_jungletree_wood.png",
	},
	groups = {wood=1,snappy=2,dig_immediate=3,flammable=2},
})

minetest.register_node("moretrees:jungletree_trunk_sideways", {
	description = "Jungle Tree trunk (sideways)",	
	tiles = {
		"default_jungletree.png^[transformR90",
		"default_jungletree.png^[transformR90",
		"default_jungletree_top.png",
		"default_jungletree_top.png",
		"default_jungletree.png^[transformR90",
		"default_jungletree.png^[transformR90"
	},
	groups = {wood=1,snappy=2,dig_immediate=3,flammable=2},
})

local leaves = {"green","yellow","red"}
for color = 1, 3 do
	local leave_name = "moretrees:jungletree_leaves_"..leaves[color]
	minetest.register_node(leave_name, {
		description = "Jungle Tree Leaves",
		drawtype = "allfaces_optional",
		tiles = {"moretrees_jungletree_leaves_"..leaves[color]..".png"},
		paramtype = "light",
		groups = {snappy=3, leafdecay=3, flammable=2},
		drop = {
			max_items = 1,
			items = {
				{
					-- player will get sapling with 1/20 chance
					items = {'moretrees:jungletree_sapling'},
					rarity = 20,
				},
				{
					-- player will get leaves only if he get no saplings,
					-- this is because max_items is 1
					items = {"moretrees:jungletree_leaves_"..leaves[color]},
				}
			}
		},
		sounds = default.node_sound_leaves_defaults(),
	})
end

-- Nodes for firs

minetest.register_node("moretrees:fir_trunk", {
	description = "Fir trunk",
	tile_images = { 
		"moretrees_fir_trunktop.png", 
		"moretrees_fir_trunktop.png", 
		"moretrees_fir_trunk.png", 
		"moretrees_fir_trunk.png", 
		"moretrees_fir_trunk.png", 
		"moretrees_fir_trunk.png" 
	},
	is_ground_content = true,
	groups = {
		tree = 1,
		snappy = 2,
		choppy = 2,
		oddly_breakable_by_hand = 1,
		flammable = 2,
		wood = 1
	},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("moretrees:fir_trunk_sideways", {
	description = "Fir Trunk (sideways)",
	tile_images = { 
		"moretrees_fir_trunk.png^[transformR90", 
		"moretrees_fir_trunk.png^[transformR90",
		"moretrees_fir_trunktop.png", 
		"moretrees_fir_trunktop.png", 
		"moretrees_fir_trunk.png^[transformR90", 
		"moretrees_fir_trunk.png^[transformR90" 
	},
	paramtype2 = "facedir",
	material = minetest.digprop_woodlike(1.0),

	groups = {
		tree = 1,
		snappy = 2,
		choppy = 2,
		oddly_breakable_by_hand = 1,
		flammable = 2,
		wood = 1
	},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("moretrees:fir_leaves", {
	drawtype = "allfaces_optional",
	description = "Fir Leaves",
	tile_images = { "moretrees_fir_leaves.png" },
	paramtype = "light",
	groups = {
		snappy = 3,
		leafdecay = 3,
		flammable = 2
	},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'moretrees:fir_sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'moretrees:fir_leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("moretrees:fir_leaves_bright", {
	drawtype = "allfaces_optional",
	description = "Fir Leaves (Bright)",
	tile_images = { "moretrees_fir_leaves_bright.png" },
	paramtype = "light",

	groups = {
		snappy = 3,
		leafdecay = 3,
		flammable = 2
	},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'moretrees:fir_sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'moretrees:fir_leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("moretrees:fir_sapling", {
	description = "Fir sapling",
	drawtype = "plantlike",
	tile_images = {"moretrees_fir_sapling.png"},
	inventory_image = "moretrees_fir_sapling.png",
	paramtype = "light",
	walkable = false,
	groups = {
		snappy = 2,
		dig_immediate = 3,
		flammable = 2
	},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("moretrees:fir_cone", {
	description = "Fir cone",
	drawtype = "plantlike",
	tiles = {"moretrees_fir_cone.png"},
	inventory_image = "moretrees_fir_cone.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
			fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
		},
})

-- Backward compatbility with old mods/nodes:

minetest.register_alias("default:jungletree", "moretrees:jungletree_trunk")
minetest.register_alias("jungletree:leaves_green", "moretrees:jungletree_leaves_green")
minetest.register_alias("jungletree:leaves_red", "moretrees:jungletree_leaves_red")
minetest.register_alias("jungletree:leaves_yellow", "moretrees:jungletree_leaves_yellow")

minetest.register_alias("moretrees:conifer_trunk", "moretrees:fir_trunk")
minetest.register_alias("moretrees:conifer_trunk_sideways", "moretrees:fir_trunk_sideways")
minetest.register_alias("moretrees:conifer_leaves", "moretrees:fir_leaves")
minetest.register_alias("moretrees:conifer_leaves_bright", "moretrees:fir_leaves_bright")
minetest.register_alias("moretrees:conifer_sapling", "moretrees:fir_sapling")

minetest.register_alias("conifers:trunk", "moretrees:fir_trunk")
minetest.register_alias("conifers:trunk_reversed", "moretrees:fir_trunk_sideways")
minetest.register_alias("conifers:leaves", "moretrees:fir_leaves")
minetest.register_alias("conifers:leaves_special", "moretrees:fir_leaves_bright")
minetest.register_alias("conifers:sapling", "moretrees:fir_sapling")

