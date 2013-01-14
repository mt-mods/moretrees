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

-- snow biomes mod uses this code to make biomes:
--
--		local perlin1 = env:get_perlin(112,3, 0.5, 150)
--		local test = perlin1:get2d({x=pos.x, y=pos.z})
--		if smooth and (test > 0.73 or (test > 0.43 and math.random(0,29) > (0.73 - test) * 100 )) then
--			in_biome = true
--		elseif not smooth and test > 0.53 then
--			in_biome = true
--		end
--
-- We'll just save this for later use ;-)
--

local DEBUG = false

-- Jungletree init stuff:

local JT_SPAWN_INTERVAL = 1000
local JT_SPAWN_CHANCE = 100

local JT_GROW_INTERVAL = 100
local JT_GROW_CHANCE = 10

local JT_RADIUS = 15
local JT_WATER_RADIUS = 15
local JT_WATER_COUNT = 10

local jungletree_seed_diff = plantlife_seed_diff

-- Conifers init stuff:

local CONIFERS_SPAWN_SAPLING_INTERVAL = 1000
local CONIFERS_SPAWN_SAPLING_CHANCE = 100

local CONIFERS_GROW_SAPLING_INTERVAL = 100
local CONIFERS_GROW_SAPLING_CHANCE = 10

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
	{"default:dirt_with_grass"},	-- must have grass..
	8, 								-- in all 8 of the surrounding nodes
	nil,							-- we don't care about facedir
	nil,							-- or water depth
	-5,								-- must be 5m below sea level or higher
	10,								-- but no higher than 15m
	{"default:water_source"},		-- Jungle trees must be near water
	JT_WATER_RADIUS,				-- within this radius of it (default 25)
	JT_WATER_COUNT,					-- with this many water nodes in the area
	1,								-- air size area of 1 (+/- 1 node in X and Z directions)
	9								-- there must be 9 air nodes in the area
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
	8,
	nil,
	nil,
	CONIFERS_ALTITUDE,
	nil,
	nil,
	nil,
	nil,
	1,
	9
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

-- L-System Tree definitions

jungle_tree={
	axiom=nil,
	rules_a=nil,
	rules_b=nil,
	trunk="default:jungletree",
	leaves="jungletree:leaves_green",
	leaves2=nil,
	leaves2_chance=nil,
	angle=45,
	iterations=nil,
	random_level=2,
	trunk_type=nil,
	thin_branches=true;
	fruit_chance=15,
	fruit="vines:vine"
}

jt_axiom1 = "FFFA"
jt_rules_a1 = "FFF[&&-FBf[&&&Ff]^^^Ff][&&+FBFf[&&&FFf]^^^Ff][&&---FBFf[&&&Ff]^^^Ff][&&+++FBFf[&&&Ff]^^^Ff]F/A"
jt_rules_b1 = "[-Ff&f][+Ff&f]B"

jt_axiom2 = "FFFFFA"
jt_rules_a2 = "FFFFF[&&-FFFBF[&&&FFff]^^^FFf][&&+FFFBFF[&&&FFff]^^^FFf][&&---FFFBFF[&&&FFff]^^^FFf][&&+++FFFBFF[&&&FFff]^^^FFf]FF/A"
jt_rules_b2 = "[-FFf&ff][+FFf&ff]B"

conifer_tree={
	axiom="FFFAF[&&-F][&&+F][&&---F][&&+++F]Fff",
	rules_a=nil,
	rules_b=nil,
	trunk="conifers:trunk",
	leaves=nil,
	angle=45,
	iterations=7,
	random_level=5,
	thin_trunks=true
}

ct_rules_a1 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
ct_rules_b1 = "[-FBf][+FBf]"

ct_rules_a2 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
ct_rules_b2 = "[-fB][+fB]"

-- Code that actually spawns the trees!

function grow_jungletree(pos, noise)
	local r1 = math.random(2)
	local r2 = math.random(3)
	if r1 == 1 then
		jungle_tree["leaves2"] = "jungletree:leaves_red"
	else 
		jungle_tree["leaves2"] = "jungletree:leaves_yellow"
	end
	jungle_tree["leaves2_chance"] = math.random(25, 75)

	if r2 == 1 then
		jungle_tree["trunk_type"] = "single"
		jungle_tree["iterations"] = 2
		jungle_tree["axiom"] = jt_axiom1
		jungle_tree["rules_a"] = jt_rules_a1
		jungle_tree["rules_b"] = jt_rules_b1
	elseif r2 == 2 then
		jungle_tree["trunk_type"] = "double"
		jungle_tree["iterations"] = 4
		jungle_tree["axiom"] = jt_axiom2
		jungle_tree["rules_a"] = jt_rules_a2
		jungle_tree["rules_b"] = jt_rules_b2
	elseif r2 == 3 then
		jungle_tree["trunk_type"] = "crossed"
		jungle_tree["iterations"] = 4
		jungle_tree["axiom"] = jt_axiom2
		jungle_tree["rules_a"] = jt_rules_a2
		jungle_tree["rules_b"] = jt_rules_b2
	end

	minetest.env:remove_node(pos)
	local leaves = minetest.env:find_nodes_in_area({x = pos.x-1, y = pos.y, z = pos.z-1}, {x = pos.x+1, y = pos.y+10, z = pos.z+1}, "default:leaves")
	for leaf in ipairs(leaves) do
			minetest.env:remove_node(leaves[leaf])
	end
	minetest.env:spawn_tree(pos,jungle_tree)
end

function grow_conifer(pos, noise)
	if math.random(2) == 1 then
		conifer_tree["leaves"]="conifers:leaves"
	else
		conifer_tree["leaves"]="conifers:leaves_special"
	end
	if math.random(2) == 1 then
		conifer_tree["rules_a"] = ct_rules_a1
		conifer_tree["rules_b"] = ct_rules_b1
	else
		conifer_tree["rules_a"] = ct_rules_a2
		conifer_tree["rules_b"] = ct_rules_b2
	end

	minetest.env:remove_node(pos)
	local leaves = minetest.env:find_nodes_in_area({x = pos.x, y = pos.y, z = pos.z}, {x = pos.x, y = pos.y+5, z = pos.z}, "default:leaves")
	for leaf in ipairs(leaves) do
			minetest.env:remove_node(leaves[leaf])
	end
	minetest.env:spawn_tree(pos,conifer_tree)
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

