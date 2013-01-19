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

for i in ipairs(leaves) do
	local name = leaves[i]
	minetest.register_node("moretrees:"..leaves[i][1].."_leaves", {
		description = leaves[i][2],
		drawtype = "allfaces_optional",
		visual_scale = 1.3,
		tiles = { "moretrees_"..leaves[i][1].."_leaves.png" },
		paramtype = "light",
		groups = {tree=1, snappy=3, flammable=2},
		sounds = default.node_sound_leaves_defaults(),
	})
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

moretrees.avoidnodes = {}

table.insert(moretrees.avoidnodes, "default:jungletree")
table.insert(moretrees.avoidnodes, "jungletree:sapling")
table.insert(moretrees.avoidnodes, "conifers:trunk")
table.insert(moretrees.avoidnodes, "conifers:sapling")

for i in ipairs(trees) do
	local treename = trees[i][1]
	local treedesc = trees[i][2]
	local fruit = trees[i][3]
	local fruitdesc = trees[i][4]
	local selbox = trees[i][5]

	table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_trunk")
	table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_sapling")

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
	visual_scale = 1.0,
	tiles = {"moretrees_"..treename.."_sapling.png"},
	inventory_image = "moretrees_"..treename.."_sapling.png",
	wield_image = "moretrees_"..treename.."_sapling.png",
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
			visual_scale = 0.8,
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

--- For backward compatibility, jungle trees and firs ("conifers") are defined
--- separately.

-- Nodes for jungle trees

minetest.register_node(":jungletree:sapling", {
	description = "Jungle Tree Sapling",	
	drawtype = "plantlike",	
	visual_scale = 1.0,	
	tiles = {"jungletree_sapling.png"},	
	inventory_image = "jungletree_sapling.png",	
	wield_image = "default_sapling.png",	
	paramtype = "light",	
	walkable = false,	
	groups = {snappy=2,dig_immediate=3,flammable=2},
})

local leaves = {"green","yellow","red"}
for color = 1, 3 do
	local leave_name = ":jungletree:leaves_"..leaves[color]
	minetest.register_node(leave_name, {
		description = "Jungle Tree Leaves",
		drawtype = "allfaces_optional",
		tiles = {"jungletree_leaves_"..leaves[color]..".png"},
		paramtype = "light",
		groups = {snappy=3, leafdecay=3, flammable=2},
		drop = {
			max_items = 1,
			items = {
				{
					-- player will get sapling with 1/20 chance
					items = {'jungletree:sapling'},
					rarity = 20,
				},
				{
					-- player will get leaves only if he get no saplings,
					-- this is because max_items is 1
					items = {"jungletree:leaves_"..leaves[color]},
				}
			}
		},
		sounds = default.node_sound_leaves_defaults(),
	})
end

-- Nodes for conifers

minetest.register_node(":conifers:trunk", {
	description = "Conifer trunk",
	tile_images = { 
		"conifers_trunktop.png", 
		"conifers_trunktop.png", 
		"conifers_trunk.png", 
		"conifers_trunk.png", 
		"conifers_trunk.png", 
		"conifers_trunk.png" 
	},
	paramtype = "facedir_simple",
	is_ground_content = true,
	groups = {
		tree = 1,
		snappy = 2,
		choppy = 2,
		oddly_breakable_by_hand = 1,
		flammable = 2
	},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node(":conifers:trunk_reversed", {
	description = "Conifer reversed trunk",
	tile_images = { 
		"conifers_trunk_reversed.png", 
		"conifers_trunk_reversed.png",
		"conifers_trunktop.png", 
		"conifers_trunktop.png", 
		"conifers_trunk_reversed.png", 
		"conifers_trunk_reversed.png" 
	},
	--inventory_image = minetest.inventorycube(
		--"conifers_trunk.png",
		--"conifers_trunktop.png",
		--"conifers_trunk.png"
	--),
	paramtype = "facedir_simple",
	material = minetest.digprop_woodlike(1.0),
	legacy_facedir_simple = true,
	is_ground_content = true,
	groups = {
		tree = 1,
		snappy = 2,
		choppy = 2,
		oddly_breakable_by_hand = 1,
		flammable = 2
	},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node(":conifers:leaves", {
	description = "Conifer leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tile_images = { "conifers_leaves.png" },
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
				items = {'conifers:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'conifers:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node(":conifers:leaves_special", {
	description = "Bright conifer leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tile_images = { "conifers_leaves_special.png" },
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
				items = {'conifers:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'conifers:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node(":conifers:sapling", {
	description = "Conifer sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tile_images = {"conifers_sapling.png"},
	inventory_image = "conifers_sapling.png",
	wield_image = "conifers_sapling.png",
	paramtype = "light",
	walkable = false,
	groups = {
		snappy = 2,
		dig_immediate = 3,
		flammable = 2
	},
	sounds = default.node_sound_defaults(),
})

