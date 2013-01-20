-- More trees!  2013-01-20
--
-- This mod adds more types of trees to the game
--
-- Some of the node definitions and textures came from cisoun's conifers mod 
-- and bas080's jungle trees mod.
--
-- Brought together into one mod and made L-systems compatible by Vanessa
-- Ezekowitz.
--
-- Conifers and Jungle tree axioms/rules by Vanessa Ezekowitz, with the 
-- latter having been tweaked by RealBadAngel, most others written by
-- RealBadAngel.
--
-- License: WTFPL for all parts (code and textures)
--

-- snow biomes mod uses this code to make biomes:
--
--	local perlin1 = env:get_perlin(112,3, 0.5, 150)
--	local test = perlin1:get2d({x=pos.x, y=pos.z})
--	if smooth and (test > 0.73 or (test > 0.43 and math.random(0,29) > (0.73 - test) * 100 )) then
--		in_biome = true
--	elseif not smooth and test > 0.53 then
--		in_biome = true
--	end
--	
-- We'll just save this for possible later use ;-)
--
moretrees = {}

dofile(minetest.get_modpath("moretrees").."/crafts.lua")
dofile(minetest.get_modpath("moretrees").."/node_defs.lua")
dofile(minetest.get_modpath("moretrees").."/tree_models.lua")
dofile(minetest.get_modpath("moretrees").."/biome_defs.lua")

-- tree spawning setup

plantslib:register_generate_plant(moretrees.apple_tree_biome, moretrees.apple_tree_model)
plantslib:register_generate_plant(moretrees.oak_biome, moretrees.oak_model)
plantslib:register_generate_plant(moretrees.sequoia_biome, moretrees.sequoia_model)
plantslib:register_generate_plant(moretrees.palm_biome, moretrees.palm_model)
plantslib:register_generate_plant(moretrees.pine_biome, moretrees.pine_model)
plantslib:register_generate_plant(moretrees.rubber_tree_biome, moretrees.rubber_tree_model)
plantslib:register_generate_plant(moretrees.willow_biome, moretrees.willow_model)

plantslib:register_generate_plant(moretrees.birch_biome, "moretrees:grow_birch")
plantslib:register_generate_plant(moretrees.spruce_biome, "moretrees:grow_spruce")
plantslib:register_generate_plant(moretrees.jungletree_biome, "moretrees:grow_jungletree")
plantslib:register_generate_plant(moretrees.conifer_biome, "moretrees:grow_conifer")

-- These three lines replace default trees with beech
-- Enable them if you want but be warned - due to serious bugs in the speed
-- of the engine's map generator/loader, doing so will slow it WAY down.

--[[
minetest.register_alias("mapgen_tree", "air")
minetest.register_alias("mapgen_leaves", "air")
plantslib:register_generate_plant(moretrees.beech_biome, moretrees.beech_model)
]]--

-- sapling growth setup

local sapling_interval = 500
local sapling_chance = 10

for i in ipairs(simple_trees) do
	local tree_name = trees[i][1]
	local tree_model = tree_name.."_model"
	dbg(dump(moretrees[tree_model]))
	
	plantslib:grow_plants(
		sapling_interval,
		sapling_chance,
		"moretrees:"..tree_name.."_sapling",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		moretrees[tree_model],
		nil
	)
end

plantslib:grow_plants(sapling_interval,sapling_chance,"moretrees:birch_sapling",nil,nil,nil,nil,nil,nil,nil,nil,"moretrees:grow_birch",nil)
plantslib:grow_plants(sapling_interval,sapling_chance,"moretrees:spruce_sapling",nil,nil,nil,nil,nil,nil,nil,nil,"moretrees:grow_spruce",nil)
plantslib:grow_plants(sapling_interval,sapling_chance,"conifers:sapling",nil,nil,nil,nil,nil,nil,nil,nil,"moretrees:grow_conifer",nil)
plantslib:grow_plants(sapling_interval,sapling_chance,"jungletree:sapling",nil,nil,nil,nil,nil,nil,nil,nil,"moretrees:grow_jungletree",nil)

-- Code to spawn a birch tree

function moretrees:grow_birch(pos)
	if math.random(1,2) == 1 then
		minetest.env:spawn_tree(pos, moretrees.birch_model1)
	else
		minetest.env:spawn_tree(pos, moretrees.birch_model2)
	end
end

-- Code to spawn a spruce tree

function moretrees:grow_spruce(pos)
	if math.random(1,2) == 1 then
		minetest.env:spawn_tree(pos, moretrees.spruce_model1)
	else
		minetest.env:spawn_tree(pos, moretrees.spruce_model2)
	end
end

-- Code that spawns jungle trees and firs ("conifer")

moretrees.jt_axiom1 = "FFFA"
moretrees.jt_rules_a1 = "FFF[&&-FBf[&&&Ff]^^^Ff][&&+FBFf[&&&FFf]^^^Ff][&&---FBFf[&&&Ff]^^^Ff][&&+++FBFf[&&&Ff]^^^Ff]F/A"
moretrees.jt_rules_b1 = "[-Ff&f][+Ff&f]B"

moretrees.jt_axiom2 = "FFFFFA"
moretrees.jt_rules_a2 = "FFFFF[&&-FFFBF[&&&FFff]^^^FFf][&&+FFFBFF[&&&FFff]^^^FFf][&&---FFFBFF[&&&FFff]^^^FFf][&&+++FFFBFF[&&&FFff]^^^FFf]FF/A"
moretrees.jt_rules_b2 = "[-FFf&ff][+FFf&ff]B"

moretrees.ct_rules_a1 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
moretrees.ct_rules_b1 = "[-FBf][+FBf]"

moretrees.ct_rules_a2 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
moretrees.ct_rules_b2 = "[-fB][+fB]"

function moretrees:grow_jungletree(pos)
	local r1 = math.random(2)
	local r2 = math.random(3)
	if r1 == 1 then
		moretrees.jungletree_model.leaves2 = "jungletree:leaves_red"
	else 
		moretrees.jungletree_model.leaves2 = "jungletree:leaves_yellow"
	end
	moretrees.jungletree_model.leaves2_chance = math.random(25, 75)

	if r2 == 1 then
		moretrees.jungletree_model.trunk_type = "single"
		moretrees.jungletree_model.iterations = 2
		moretrees.jungletree_model.axiom = moretrees.jt_axiom1
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a1
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b1
	elseif r2 == 2 then
		moretrees.jungletree_model.trunk_type = "double"
		moretrees.jungletree_model.iterations = 4
		moretrees.jungletree_model.axiom = moretrees.jt_axiom2
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a2
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b2
	elseif r2 == 3 then
		moretrees.jungletree_model.trunk_type = "crossed"
		moretrees.jungletree_model.iterations = 4
		moretrees.jungletree_model.axiom = moretrees.jt_axiom2
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a2
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b2
	end

	minetest.env:remove_node(pos)
	local leaves = minetest.env:find_nodes_in_area({x = pos.x-1, y = pos.y, z = pos.z-1}, {x = pos.x+1, y = pos.y+10, z = pos.z+1}, "default:leaves")
	for leaf in ipairs(leaves) do
			minetest.env:remove_node(leaves[leaf])
	end
	minetest.env:spawn_tree(pos, moretrees.jungletree_model)
end

function moretrees:grow_conifer(pos)
	if math.random(2) == 1 then
		moretrees.conifer_model.leaves="conifers:leaves"
	else
		moretrees.conifer_model.leaves="conifers:leaves_special"
	end
	if math.random(2) == 1 then
		moretrees.conifer_model.rules_a = moretrees.ct_rules_a1
		moretrees.conifer_model.rules_b = moretrees.ct_rules_b1
	else
		moretrees.conifer_model.rules_a = moretrees.ct_rules_a2
		moretrees.conifer_model.rules_b = moretrees.ct_rules_b2
	end

	minetest.env:remove_node(pos)
	local leaves = minetest.env:find_nodes_in_area({x = pos.x, y = pos.y, z = pos.z}, {x = pos.x, y = pos.y+5, z = pos.z}, "default:leaves")
	for leaf in ipairs(leaves) do
			minetest.env:remove_node(leaves[leaf])
	end
	minetest.env:spawn_tree(pos,moretrees.conifer_model)
end



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

print("[Moretrees] Loaded (2013-01-18)")
