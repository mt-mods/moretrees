--
-- Conifers crafting definitions
--
minetest.register_craft({
	output = 'node "conifers:trunk_reversed" 2',
	recipe = {
		{'node "conifers:trunk"', 'node "conifers:trunk"'},
	}
})

minetest.register_craft({
	output = 'node "conifers:trunk" 2',
	recipe = {
		{'node "conifers:trunk_reversed"'},
		{'node "conifers:trunk_reversed"'}
	}
})

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {
		{'conifers:trunk'}
	}
})

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {
		{'conifers:trunk_reversed'}
	}
})

