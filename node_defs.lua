moretrees.avoidnodes = {}

table.insert(moretrees.avoidnodes, "default:jungletree")
table.insert(moretrees.avoidnodes, "moretrees:jungletree_trunk")
table.insert(moretrees.avoidnodes, "moretrees:jungletree_leaves_red")
table.insert(moretrees.avoidnodes, "moretrees:jungletree_leaves_green")
table.insert(moretrees.avoidnodes, "moretrees:jungletree_leaves_yellow")
table.insert(moretrees.avoidnodes, "moretrees:fir_trunk")
table.insert(moretrees.avoidnodes, "moretrees:fir_leaves")
table.insert(moretrees.avoidnodes, "moretrees:fir_leaves_bright")
	
trees = {
	{"beech",	"Beech Tree",	 4 },
	{"apple_tree",	"Apple Tree",	10 },
	{"oak",		"Oak Tree",	10,	"acorn",	"Acorn",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"sequoia",	"Giant Sequoia", 7 },
	{"birch",	"Birch Tree",	10 },
	{"palm",	"Palm Tree",	15,	"coconut",	"Coconut",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 1.0 },
	{"spruce",	"Spruce Tree",	10,	"spruce_cone",	"Spruce Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"pine",	"Pine Tree",	10,	"pine_cone",	"Pine Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"willow",	"Willow Tree",	15 },
	{"rubber_tree",	"Rubber Tree",	 7 },
	{"jungletree",	"Jungle Tree"},
	{"fir",		"Douglas Fir",	15,	"fir_cone",	"Fir Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
}

simple_trees = { "beech", "apple_tree", "oak", "sequoia", "palm", "pine", "willow", "rubber_tree"}

for i in ipairs(trees) do
	local treename = trees[i][1]
	local treedesc = trees[i][2]
	local leafdecayradius = trees[i][3]  -- future use, not yet implemented.
	local fruit = trees[i][4]
	local fruitdesc = trees[i][5]
	local selbox = trees[i][6]
	local vscale = trees[i][7]

	minetest.register_node("moretrees:"..treename.."_trunk", {
		description = treedesc.." Trunk",
		tiles = {
			"moretrees_"..treename.."_trunk_top.png",
			"moretrees_"..treename.."_trunk_top.png",
			"moretrees_"..treename.."_trunk.png"
		},
		is_ground_content = true,
		groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
		sounds = default.node_sound_wood_defaults(),
	})

	minetest.register_node("moretrees:"..treename.."_trunk_sideways", {
		description = "Sideways "..treedesc.." Trunk",
		tiles = {
			"moretrees_"..treename.."_trunk.png^[transformR90",
			"moretrees_"..treename.."_trunk.png^[transformR90",
			"moretrees_"..treename.."_trunk_top.png",
			"moretrees_"..treename.."_trunk_top.png",
			"moretrees_"..treename.."_trunk.png^[transformR90",
			"moretrees_"..treename.."_trunk.png^[transformR90"
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
			inventory_image = "moretrees_"..fruit..".png^[transformR180",
			wield_image = "moretrees_"..fruit..".png^[transformR180",
			visual_scale = vscale,
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

	-- player will get a sapling with 1/100 chance
	-- player will get leaves only if he/she gets no saplings,
	-- this is because max_items is 1

	if treename ~= "jungletree" then
		minetest.register_node("moretrees:"..treename.."_leaves", {
			description = treedesc.." Leaves",
			drawtype = "allfaces_optional",
			tiles = { "moretrees_"..treename.."_leaves.png" },
			paramtype = "light",
			groups = {tree=1, snappy=3, flammable=2 },
			sounds = default.node_sound_leaves_defaults(),

			drop = {
				max_items = 1,
				items = {
					{items = {"moretrees:"..treename.."_sapling"}, rarity = 100 },
					{items = {"moretrees:"..treename.."_leaves"} }
				}
			},
		})
	end

	table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_trunk")
	table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_leaves")
end

-- Extra leaves for jungle trees:

local jungleleaves = {"green","yellow","red"}
local jungleleavesnames = {"Green", "Yellow", "Red"}
for color = 1, 3 do
	local leave_name = "moretrees:jungletree_leaves_"..jungleleaves[color]
	minetest.register_node(leave_name, {
		description = "Jungle Tree Leaves ("..jungleleavesnames[color]..")",
		drawtype = "allfaces_optional",
		tiles = {"moretrees_jungletree_leaves_"..jungleleaves[color]..".png"},
		paramtype = "light",
		groups = {snappy=3, flammable=2},
		drop = {
			max_items = 1,
			items = {
				{items = {'moretrees:jungletree_sapling'}, rarity = 100 },
				{items = {"moretrees:jungletree_leaves_"..jungleleaves[color]} }
			}
		},
		sounds = default.node_sound_leaves_defaults(),
	})
end

-- Extra needles for firs

minetest.register_node("moretrees:fir_leaves_bright", {
	drawtype = "allfaces_optional",
	description = "Douglas Fir Leaves (Bright)",
	tile_images = { "moretrees_fir_leaves_bright.png" },
	paramtype = "light",

	groups = {snappy=3, flammable=2 },
	drop = {
		max_items = 1,
		items = {
			{items = {'moretrees:fir_sapling'}, rarity = 100 },
			{items = {'moretrees:fir_leaves'} }
		}
	},
	sounds = default.node_sound_leaves_defaults()
})



-- Backward compatbility with old mods/nodes:

minetest.register_alias("default:jungletree", "moretrees:jungletree_trunk")
minetest.register_alias("jungletree:leaves_green", "moretrees:jungletree_leaves_green")
minetest.register_alias("jungletree:leaves_red", "moretrees:jungletree_leaves_red")
minetest.register_alias("jungletree:leaves_yellow", "moretrees:jungletree_leaves_yellow")
minetest.register_alias("jungletree:sapling", "moretrees:jungletree_sapling")

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

