moretrees.avoidnodes = {}
	
moretrees.treelist = {
	{"beech",	"Beech Tree"},
	{"apple_tree",	"Apple Tree"},
	{"oak",		"Oak Tree",		"acorn",	"Acorn",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"sequoia",	"Giant Sequoia"},
	{"birch",	"Birch Tree"},
	{"palm",	"Palm Tree",		"coconut",	"Coconut",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 1.0 },
	{"spruce",	"Spruce Tree",		"spruce_cone",	"Spruce Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"pine",	"Pine Tree",		"pine_cone",	"Pine Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"willow",	"Willow Tree"},
	{"rubber_tree",	"Rubber Tree"},
	{"jungletree",	"Jungle Tree"},
	{"fir",		"Douglas Fir",		"fir_cone",	"Fir Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
}

local dirs1 = { 21, 20, 23, 22, 21 }
local dirs2 = { 12, 9, 18, 7, 12 }
local dirs3 = { 14, 11, 16, 5, 14 }

moretrees_new_leaves_drawtype = "allfaces_optional"
moretrees_new_leaves_visual_scale = 1.0
moretrees_new_leaves_extension = ".png"

if moretrees.plantlike_leaves then
	moretrees_new_leaves_drawtype = "plantlike"
	moretrees_new_leaves_visual_scale = 1.189
	moretrees_new_leaves_extension = "_plantlike.png"
end

new_default_leaves = moretrees:clone_node("default:leaves")
	if moretrees.enable_default_leafdecay then
		new_default_leaves.groups = {snappy=3, flammable=2, leaves=1}
	end
	new_default_leaves.drawtype = moretrees_new_leaves_drawtype
	new_default_leaves.visual_scale = moretrees_new_leaves_visual_scale
	new_default_leaves.tiles = {"default_leaves"..moretrees_new_leaves_extension}
	minetest.register_node(":default:leaves", new_default_leaves)

new_default_jungle_leaves = clone_node("default:jungleleaves")
	if moretrees.enable_default_jungle_leafdecay then
	new_default_jungle_leaves.groups = {snappy=3, flammable=2, leaves=1}
	end
	new_default_jungle_leaves = moretrees:clone_node("default:jungleleaves")
	new_default_jungle_leaves.drawtype = moretrees_new_leaves_drawtype
	new_default_jungle_leaves.visual_scale = moretrees_new_leaves_visual_scale
	new_default_jungle_leaves.tiles = {"default_jungleleaves"..moretrees_new_leaves_extension}
	minetest.register_node(":default:jungleleaves", new_default_jungle_leaves)

for i in ipairs(moretrees.treelist) do
	local treename = moretrees.treelist[i][1]
	local treedesc = moretrees.treelist[i][2]
	local fruit = moretrees.treelist[i][3]
	local fruitdesc = moretrees.treelist[i][4]
	local selbox = moretrees.treelist[i][5]
	local vscale = moretrees.treelist[i][6]

	if treename ~= "jungletree" then -- the default game provides jungle tree trunk/planks nodes.

		minetest.register_node("moretrees:"..treename.."_trunk", {
			description = treedesc.." Trunk",
			tiles = {
				"moretrees_"..treename.."_trunk_top.png",
				"moretrees_"..treename.."_trunk_top.png",
				"moretrees_"..treename.."_trunk.png"
			},
			paramtype2 = "facedir",
			is_ground_content = true,
			groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
			sounds = default.node_sound_wood_defaults(),
			on_place = function(itemstack, placer, pointed_thing)
				local keys=placer:get_player_control()
				local pos = pointed_thing.under
				if not moretrees:node_is_owned(pos, placer) then
					minetest.rotate_and_place(itemstack, placer, pointed_thing,
						moretrees.expect_infinite_stacks, { invert_wall = keys.sneak })
				end
				return itemstack
			end
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
	
		minetest.register_node("moretrees:"..treename.."_sapling_ongen", {
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
			groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1,not_in_creative_inventory=1},
			sounds = default.node_sound_defaults(),
			drop = "moretrees:"..treename.."_sapling"
		})

		-- player will get a sapling with 1/100 chance
		-- player will get leaves only if he/she gets no saplings,
		-- this is because max_items is 1


		local droprarity = 100

		if treename ~= "palm" then
			droprarity = 20
		end

		minetest.register_node("moretrees:"..treename.."_leaves", {
			description = treedesc.." Leaves",
			drawtype = moretrees_new_leaves_drawtype,
			visual_scale = moretrees_new_leaves_visual_scale,
			tiles = { "moretrees_"..treename.."_leaves"..moretrees_new_leaves_extension },
			paramtype = "light",
			groups = {snappy=3, flammable=2, leaves=1, moretrees_leaves=1},
			sounds = default.node_sound_leaves_defaults(),

			drop = {
				max_items = 1,
				items = {
					{items = {"moretrees:"..treename.."_sapling"}, rarity = droprarity },
					{items = {"moretrees:"..treename.."_leaves"} }
				}
			},
		})

		if minetest.get_modpath("moreblocks") and moretrees.enable_stairsplus then

			register_stair(
				"moretrees",
				treename.."_trunk",
				"moretrees:"..treename.."_trunk",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory=1, tree_stair=1 },
				{	"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk.png"
				},
				treedesc.." Trunk",
				treename.."_trunk",
				0
			)

			register_slab(
				"moretrees",
				treename.."_trunk",
				"moretrees:"..treename.."_trunk",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory=1, tree_slab=1 },
				{	"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk.png"
				},
				treedesc.." Trunk",
				treename.."_trunk",
				0
			)

			register_panel(
				"moretrees",
				treename.."_trunk",
				"moretrees:"..treename.."_trunk",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory=1, tree_panel=1 },
				{	"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk.png"
				},
				treedesc.." Trunk",
				treename.."_trunk",
				0
			)

			register_micro(
				"moretrees",
				treename.."_trunk",
				"moretrees:"..treename.."_trunk",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory=1, tree_micro=1 },
				{	"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk.png"
				},
				treedesc.." Trunk",
				treename.."_trunk",
				0
			)

			register_stair(
				"moretrees",
				treename.."_planks",
				"moretrees:"..treename.."_planks",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1, wood_stair=1 },
				{ "moretrees_"..treename.."_wood.png" },
				treedesc.." Planks",
				treename.."_planks",
				0
			)

			register_slab(
				"moretrees",
				treename.."_planks",
				"moretrees:"..treename.."_planks",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1, wood_slab=1 },
				{ "moretrees_"..treename.."_wood.png" },
				treedesc.." Planks",
				treename.."_planks",
				0
			)

			register_panel(
				"moretrees",
				treename.."_planks",
				"moretrees:"..treename.."_planks",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1, wood_panel=1 },
				{ "moretrees_"..treename.."_wood.png" },
				treedesc.." Planks",
				treename.."_planks",
				0
			)

			register_micro(
				"moretrees",
				treename.."_planks",
				"moretrees:"..treename.."_planks",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1, wood_micro=1 },
				{ "moretrees_"..treename.."_wood.png" },
				treedesc.." Planks",
				treename.."_planks",
				0
			)


			table.insert(circular_saw.known_stairs, "moretrees:"..treename.."_trunk")
			table.insert(circular_saw.known_stairs, "moretrees:"..treename.."_planks")
		end
	end

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
			groups = {fleshy=3,dig_immediate=3,flammable=2, attached_node=1},
			sounds = default.node_sound_defaults(),
		})
	end

	minetest.register_abm({
		nodenames = { "moretrees:"..treename.."_trunk_sideways" },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local fdir = node.param2 or 0
				nfdir = dirs2[fdir+1]
			minetest.add_node(pos, {name = "moretrees:"..treename.."_trunk", param2 = nfdir})
		end,
	})

	table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_trunk")

	if moretrees.spawn_saplings then
			table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_sapling")
			table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_sapling_ongen")
	end
end

-- Extra nodes for jungle trees:

minetest.register_node("moretrees:jungletree_sapling", {
        description = "Jungle Sapling",
        drawtype = "plantlike",
        visual_scale = 1.0,
        tiles = {"default_junglesapling.png"},
        inventory_image = "default_junglesapling.png",
        wield_image = "default_junglesapling.png",
        paramtype = "light",
        walkable = false,
        selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
        },
        groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
        sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("moretrees:jungletree_sapling_ongen", {
        description = "Jungle Sapling",
        drawtype = "plantlike",
        visual_scale = 1.0,
        tiles = {"default_junglesapling.png"},
        inventory_image = "default_junglesapling.png",
        wield_image = "default_junglesapling.png",
        paramtype = "light",
        walkable = false,
        selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
        },
        groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1,not_in_creative_inventory=1},
        sounds = default.node_sound_leaves_defaults(),
	drop = "moretrees:jungletree_sapling"
})

local jungleleaves = {"green","yellow","red"}
local jungleleavesnames = {"Green", "Yellow", "Red"}
for color = 1, 3 do
	local leave_name = "moretrees:jungletree_leaves_"..jungleleaves[color]
	minetest.register_node(leave_name, {
		description = "Jungle Tree Leaves ("..jungleleavesnames[color]..")",
		drawtype = moretrees_new_leaves_drawtype,
		visual_scale = moretrees_new_leaves_visual_scale,
		tiles = {"moretrees_jungletree_leaves_"..jungleleaves[color]..moretrees_new_leaves_extension},
		paramtype = "light",
		groups = {snappy=3, flammable=2, leaves=1, moretrees_leaves=1},
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
	drawtype = moretrees_new_leaves_drawtype,
	visual_scale = moretrees_new_leaves_visual_scale,
	description = "Douglas Fir Leaves (Bright)",
	tile_images = { "moretrees_fir_leaves_bright"..moretrees_new_leaves_extension },
	paramtype = "light",

	groups = {snappy=3, flammable=2, leaves=1, moretrees_leaves=1 },
	drop = {
		max_items = 1,
		items = {
			{items = {'moretrees:fir_sapling'}, rarity = 100 },
			{items = {'moretrees:fir_leaves'} }
		}
	},
	sounds = default.node_sound_leaves_defaults()
})

if moretrees.enable_redefine_apple then
	minetest.register_node(":default:apple", {
		description = "Apple",
		drawtype = "plantlike",
		visual_scale = 1.0,
		tiles = {"default_apple.png"},
		inventory_image = "default_apple.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
		},
		groups = {fleshy=3,dig_immediate=3,flammable=2,attached_node=1},
		on_use = minetest.item_eat(1),
		sounds = default.node_sound_defaults(),
	})
end

table.insert(moretrees.avoidnodes, "default:jungletree")
table.insert(moretrees.avoidnodes, "moretrees:jungletree_trunk")
table.insert(moretrees.avoidnodes, "moretrees:fir_trunk")
table.insert(moretrees.avoidnodes, "default:tree")

if moretrees.spawn_saplings then
		table.insert(moretrees.avoidnodes, "snow:sapling_pine")
		table.insert(moretrees.avoidnodes, "default:junglesapling")
		table.insert(moretrees.avoidnodes, "moretrees:jungle_tree_sapling")
		table.insert(moretrees.avoidnodes, "moretrees:jungle_tree_sapling_ongen")
end

-- "empty" (tapped) rubber tree nodes

minetest.register_node("moretrees:rubber_tree_trunk_empty", {
	description = "Rubber Tree Trunk (Empty)",
	tiles = {
		"moretrees_rubber_tree_trunk_top.png",
		"moretrees_rubber_tree_trunk_top.png",
		"moretrees_rubber_tree_trunk_empty.png"
	},
	is_ground_content = true,
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = function(itemstack, placer, pointed_thing)
		local keys=placer:get_player_control()
		local pos = pointed_thing.under
		if not moretrees:node_is_owned(pos, placer) then
			minetest.rotate_and_place(itemstack, placer, pointed_thing,
				moretrees.expect_infinite_stacks, { invert_wall = keys.sneak })
		end
		return itemstack
	end
})

minetest.register_abm({
	nodenames = { "moretrees:rubber_tree_trunk_empty_sideways" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2 or 0
			nfdir = dirs2[fdir+1]
		minetest.add_node(pos, {name = "moretrees:rubber_tree_trunk_empty", param2 = nfdir})
	end,
})

-- For compatibility with old nodes and recently-changed nodes.

minetest.register_alias("technic:rubber_tree_full",      "moretrees:rubber_tree_trunk")
minetest.register_alias("farming_plus:rubber_tree_full", "moretrees:rubber_tree_trunk")

minetest.register_alias("technic:rubber_leaves",      "moretrees:rubber_tree_leaves")
minetest.register_alias("farming_plus:rubber_leaves", "moretrees:rubber_tree_leaves")

minetest.register_alias("farming_plus:rubber_sapling", "moretrees:rubber_tree_sapling")
minetest.register_alias("technic:rubber_tree_sapling", "moretrees:rubber_tree_sapling")

minetest.register_alias("default:junglesapling","moretrees:jungletree_sapling")
minetest.register_alias("moretrees:jungletree_trunk_sideways", "moreblocks:horizontal_jungle_tree")

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

