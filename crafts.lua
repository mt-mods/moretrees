
for i in ipairs(simple_trees) do
	minetest.register_craft({
		output = "moretrees:"..simple_trees[i].."_trunk_sideways 2",
		recipe = {
			{"moretrees:"..simple_trees[i].."_trunk", "moretrees:"..simple_trees[i].."_trunk"}
		}
	})

	minetest.register_craft({
		output = "moretrees:"..simple_trees[i].."_trunk 2",
		recipe = {
			{"moretrees:"..simple_trees[i].."_trunk_sideways"},
			{"moretrees:"..simple_trees[i].."_trunk_sideways"}
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "moretrees:"..simple_trees[i].."_planks 4",
		recipe = {
			"moretrees:"..simple_trees[i].."_trunk"
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "moretrees:"..simple_trees[i].."_planks 4",
		recipe = {
			"moretrees:"..simple_trees[i].."_trunk_sideways"
		}
	})
end

----

minetest.register_craft({
	output = "moretrees:jungletree_trunk_sideways 2",
	recipe = {
		{"default:jungletree", "default:jungletree"},
	}
})

minetest.register_craft({
	output = "default:jungletree 2",
	recipe = {
		{"moretrees:jungletree_trunk_sideways"},
		{"moretrees:jungletree_trunk_sideways"}
	}
})

minetest.register_craft({
	output = "moretrees:jungletree_planks 4",
	recipe = {
		{"default:jungletree"}
	}
})

minetest.register_craft({
	output = "moretrees:jungletree_planks 4",
	recipe = {
		{"moretrees:jungletree_trunk_sideways"}
	}
})

----

minetest.register_craft({
	output = "conifers:trunk_reversed 2",
	recipe = {
		{"conifers:trunk", "conifers:trunk"},
	}
})

minetest.register_craft({
	output = "conifers:trunk 2",
	recipe = {
		{"conifers:trunk_reversed"},
		{"conifers:trunk_reversed"}
	}
})

minetest.register_craft({
	output = "default:wood 4",
	recipe = {
		{"conifers:trunk"}
	}
})

minetest.register_craft({
	output = "default:wood 4",
	recipe = {
		{"conifers:trunk_reversed"}
	}
})

