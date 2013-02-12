
for i in ipairs(moretrees.treelist) do
	treename = moretrees.treelist[i][1]

	minetest.register_craft({
		output = "moretrees:"..treename.."_trunk_sideways 2",
		recipe = {
			{"moretrees:"..treename.."_trunk", "moretrees:"..treename.."_trunk"}
		}
	})

	minetest.register_craft({
		output = "moretrees:"..treename.."_trunk 2",
		recipe = {
			{"moretrees:"..treename.."_trunk_sideways"},
			{"moretrees:"..treename.."_trunk_sideways"}
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "moretrees:"..treename.."_planks 4",
		recipe = {
			"moretrees:"..treename.."_trunk"
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "moretrees:"..treename.."_planks 4",
		recipe = {
			"moretrees:"..treename.."_trunk_sideways"
		}
	})
end

-- extra crafting in case user has old jungle trees.

minetest.register_craft({
	output = "moretrees:jungletree_trunk_sideways 2",
	recipe = {
		{"default:jungletree", "default:jungletree"},
	}
})

minetest.register_craft({
	output = "moretrees:jungletree_planks 4",
	recipe = {
		{"default:jungletree"}
	}
})


