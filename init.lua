-- More trees!
--
-- This mod adds more types of trees to the game
-- at present, they consist of jungle trees and conifers
--
-- Much of the code here came from cisoun's conifers mod and bas080's 
-- jungle trees mod.
--
-- Brought together into one mod and made L-systems compatible by Vanessa
-- Ezekowitz.  Thrown together on 2013-01-09 :-)
--
-- Jungle tree axioms/rules tweaked by RealBadAngel
--
-- License: WTFPL for all parts (code and textures)
--

local DEBUG = false

-- Jungletree init stuff:

local JT_SPAWN_INTERVAL = 100
local JT_SPAWN_CHANCE = 10

local JT_GROW_INTERVAL = 1000
local JT_GROW_CHANCE = 100

local JT_RADIUS = 8
local JT_WATER_RADIUS = 25
local JT_WATER_COUNT = 10

local jungletree_seed_diff = plantlife_seed_diff

-- Conifers init stuff:

local CONIFERS_SPAWN_SAPLING_CHANCE = 500
local CONIFERS_SPAWN_SAPLING_INTERVAL = 3600

local CONIFERS_GROW_SAPLING_CHANCE = 100
local CONIFERS_GROW_SAPLING_INTERVAL = 3600

--local CONIFERS_TRUNK_MINHEIGHT = 7
--local CONIFERS_TRUNK_MAXHEIGHT = 25

--local CONIFERS_LEAVES_MINHEIGHT = 2
--local CONIFERS_LEAVES_MAXHEIGHT = 6
--local CONIFERS_LEAVES_MAXRADIUS = 5
--local CONIFERS_LEAVES_NARROWRADIUS = 3 -- For narrow typed conifers.

local CONIFERS_DISTANCE = 9 -- how far apart should conifer saplings spawn?
local CONIFERS_ALTITUDE = 25

local CONIFERS_REMOVE_TREES = false -- Remove trees above CONIFERS_ALTITUDE?
local CONIFERS_RTREES_INTERVAL = 360
local CONIFERS_RTREES_CHANCE = 10

local conifers_seed_diff = plantlife_seed_diff+30

-- Spawning functions

spawn_on_surfaces(
	JT_SPAWN_INTERVAL,				-- ABM interval parameter
	"jungletree:sapling",			-- We want to spawn a sapling
	JT_RADIUS,						-- Keep this much room around saplings
	JT_SPAWN_CHANCE,				-- ABM chance parameter
	"default:dirt_with_grass",		-- must grow on grass only
	{"jungletree:sapling","default:jungletree"}, -- avoid spawning near these
	jungletree_seed_diff,			-- duh? :-)
	5,								-- minimum light needed 
	nil,							-- maximim (default, 14)
	nil,							-- ABM neighbors parameter...
	nil, 							-- don't care what else is around
	nil,							-- we don't care about facedir
	nil,							-- or water depth
	-5,								-- must be 5m below sea level or higher
	15,								-- but no higher than 15m
	{"default:water_source"},		-- Jungle trees must be near water
	JT_WATER_RADIUS,				-- within this radius of it (default 25)
	JT_WATER_COUNT					-- with this many water nodes in the area
)

spawn_on_surfaces(
	CONIFERS_SPAWN_SAPLING_INTERVAL,
	"conifers:sapling",
	CONIFERS_DISTANCE,
	CONIFERS_SPAWN_SAPLING_CHANCE,
	"default:dirt_with_grass",
	{"conifers:sapling", "conifers:trunk"},
	conifers_seed_diff,										
	nil,
	nil,					
	{"default:dirt_with_grass"},
	3,
	nil,
	nil,
	CONIFERS_ALTITUDE,
	nil					
)	

-- growing functions

grow_plants(
	JT_GROW_INTERVAL,
	JT_GROW_CHANCE,
	"jungletree:sapling",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"grow_jungletree",
	jungletree_seed_diff
)

grow_plants(
	CONIFERS_GROW_SAPLING_INTERVAL,
	CONIFERS_GROW_SAPLING_CHANCE,
	"conifers:sapling",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"grow_conifer",
	conifers_seed_diff
)

-- Code that actually spawns the trees!

function grow_jungletree(pos, noise)
	minetest.env:remove_node(pos)
	if math.random(1, 2) > 1.5 then
		minetest.env:spawn_tree(pos,jungle_tree1)
	else
		minetest.env:spawn_tree(pos,jungle_tree2)
	end
end

function grow_conifer(pos, noise)
	minetest.env:remove_node(pos)
	if math.random(1, 2) > 1.5 then
		minetest.env:spawn_tree(pos,conifer_tree1)
	else
		minetest.env:spawn_tree(pos,conifer_tree2)
	end
end

-- Other stuff

-- Should we remove all the trees above the conifers altitude?
if CONIFERS_REMOVE_TREES == true then
	minetest.register_abm({
		nodenames = {
			"default:tree", 
			"default:leaves"
		},
		interval = CONIFERS_RTREES_INTERVAL,
		chance = CONIFERS_RTREES_CHANCE,
		
		action = function(pos, node, _, _)
			if minetest.env:get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air"
				and pos.y >= CONIFERS_ALTITUDE
			then
				minetest.env:add_node(pos , {name = "air"})
			end
		end
	})
end

-- L-System Tree definitions

jungle_tree1={
	axiom="FFFFFA",
	rules_a="FFFFF[&&-FFFBF[&&&FFf]^^^FFf][&&+FFFBFF[&&&FFf]^^^FFf][&&---FFFBFF[&&&FFf]^^^FFf][&&+++FFFBFF[&&&FFf]^^^FFf]FF/A",
	rules_b="[-FFf&F][+FFf&F]B",
	trunk="default:jungletree",
	leaves="jungletree:leaves_green",
	leaves2="jungletree:leaves_yellow",
	leaves2_chance=50,
	angle=45,
	iterations=4,
	random_level=2,
	trunk_type="crossed",
	thin_branches=true;
	fruit_chance=15,
	fruit="vines:vine"
}

jungle_tree2={
	axiom="FFFFFA",
	rules_a="FFFFF[&&-FFFBF[&&&FFf]^^^FFf][&&+FFFBFF[&&&FFf]^^^FFf][&&---FFFBFF[&&&FFf]^^^FFf][&&+++FFFBFF[&&&FFf]^^^FFf]FF/A",
	rules_b="[-FFf&F][+FFf&F]B",
	trunk="default:jungletree",
	leaves="jungletree:leaves_green",
	leaves2="jungletree:leaves_red",
	leaves2_chance=50,
	angle=45,
	iterations=4,
	random_level=2,
	trunk_type="crossed",
	thin_branches=true;
	fruit_chance=15,
	fruit="vines:vine"
}


conifer_tree1={
	axiom="FFFAF[&&-F][&&+F][&&---F][&&+++F]FF",
	rules_a="FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A",
	rules_b="[-FB][+FB]",
	trunk="conifers:trunk",
	leaves="conifers:leaves",
	angle=45,
	iterations=7,
	random_level=4,
	thin_trunks=true
}

conifer_tree2={
	axiom="FFFAF[&&-F][&&+F][&&---F][&&+++F]FF",
	rules_a="FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A",
	rules_b="[-FB][+FB]",
	trunk="conifers:trunk",
	leaves="conifers:leaves_special",
	angle=45,
	iterations=7,
	random_level=4,
	thin_trunks=true
}

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
					items = {leave_name},
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

