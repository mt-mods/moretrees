-- leaf decay

minetest.register_abm({
	nodenames = moretrees.leaves_list,
	interval = moretrees.leafdecay_delay,
	chance = moretrees.leafdecay_chance,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if not minetest.env:find_node_near(pos, moretrees.leafdecay_radius, moretrees.trunks_list) then
			minetest.env:remove_node(pos)
			minetest.env:dig_node(pos)
		end
	end
})

minetest.register_abm({
	nodenames = "moretrees:palm_leaves",
	interval = moretrees.leafdecay_delay,
	chance = moretrees.leafdecay_chance,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if not minetest.env:find_node_near(pos, moretrees.palm_leafdecay_radius, moretrees.trunks_list) then
			minetest.env:remove_node(pos)
			minetest.env:dig_node(pos)
		end
	end
})


if moretrees.enable_replace_default_trees then
	minetest.register_alias("mapgen_tree", "air")
	minetest.register_alias("mapgen_leaves", "air")
	plantslib:register_generate_plant(moretrees.beech_biome, moretrees.beech_model)
elseif moretrees.enable_default_leafdecay then
	minetest.register_abm({
		nodenames = "default:leaves",
		interval = moretrees.default_leafdecay_delay,
		chance = moretrees.default_leafdecay_chance,
		action = function(pos, node, active_object_count, active_object_count_wider)
			if not minetest.env:find_node_near(pos, moretrees.default_leafdecay_radius, {"default:tree"}) then
				minetest.env:remove_node(pos)
				minetest.env:dig_node(pos)
			end
		end
	})	
end
