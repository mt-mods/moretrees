-- Date palms.
--
-- Date palms grow in hot and dry desert, but they require water. This makes them
-- a bit harder to find. If found in the middle of the desert, their presence
-- indicates a water source below the surface.
--
-- As an additional feature (which can be disabled), dates automatically regrow after
-- harvesting (provided a male tree is sufficiently nearby).
-- If regrowing is enabled, then ripe dates will not hang forever. Most will disappear
-- (e.g. eaten by birds, ...), and a small fraction will drop as items.

-- © 2016, Rogier <rogier777@gmail.com>

local S = minetest.get_translator("moretrees")

-- Some constants

local dates_drop_ichance = 4
local stems_drop_ichance = 4
local flowers_wither_ichance = 3

-- implementation

local dates_regrow_prob
if moretrees.dates_regrow_unpollinated_percent <= 0 then
	dates_regrow_prob = 0
elseif moretrees.dates_regrow_unpollinated_percent >= 100 then
	dates_regrow_prob = 1
else
	dates_regrow_prob = 1 - math.pow(moretrees.dates_regrow_unpollinated_percent/100, 1/flowers_wither_ichance)
end

-- Make the date palm fruit trunk a real trunk (it is generated as a fruit)
local trunk = minetest.registered_nodes["moretrees:date_palm_trunk"]
local ftrunk = {}
local fftrunk = {}
local mftrunk = {}
for k,v in pairs(trunk) do
	ftrunk[k] = v
end
ftrunk.tiles = {}
for k,v in pairs(trunk.tiles) do
	ftrunk.tiles[k] = v
end
ftrunk.drop = "moretrees:date_palm_trunk"
ftrunk.after_destruct = function(pos, oldnode)
	local dates = minetest.find_nodes_in_area(
		{x=pos.x-2, y=pos.y, z=pos.z-2},
		{x=pos.x+2, y=pos.y, z=pos.z+2},
		{"group:moretrees_dates"}
	)
	for _,datespos in pairs(dates) do
		-- minetest.dig_node(datespos) does not cause nearby dates to be dropped :-( ...
		local items = minetest.get_node_drops(minetest.get_node(datespos).name)
		minetest.swap_node(datespos, biome_lib.air)
		for _, itemname in pairs(items) do
			minetest.add_item(datespos, itemname)
		end
	end
end
for k,v in pairs(ftrunk) do
	mftrunk[k] = v
	fftrunk[k] = v
end
fftrunk.tiles = {}
mftrunk.tiles = {}
for k,v in pairs(trunk.tiles) do
	fftrunk.tiles[k] = v
	mftrunk.tiles[k] = v
end
-- Make the different types of trunk distinguishable (but not too easily)
ftrunk.tiles[1] = "moretrees_date_palm_trunk_top.png^[transformR180"
ftrunk.description = ftrunk.description.." (gen)"
fftrunk.tiles[1] = "moretrees_date_palm_trunk_top.png^[transformR90"
mftrunk.tiles[1] = "moretrees_date_palm_trunk_top.png^[transformR-90"
minetest.register_node("moretrees:date_palm_fruit_trunk", ftrunk)
minetest.register_node("moretrees:date_palm_ffruit_trunk", fftrunk)
minetest.register_node("moretrees:date_palm_mfruit_trunk", mftrunk)

-- Register dates

local dates_starttimer = function(pos, elapsed)
	local timer = minetest.get_node_timer(pos)
	local base_interval = moretrees.dates_grow_interval * 2 / 3
	timer:set(base_interval + math.random(base_interval), elapsed or 0)
end

local dates_drop = {
	items = {
		{items = { "moretrees:date" }},
		{items = { "moretrees:date" }},
		{items = { "moretrees:date" }},
		{items = { "moretrees:date" }},
		{items = { "moretrees:date" }, rarity = 2 },
		{items = { "moretrees:date" }, rarity = 2 },
		{items = { "moretrees:date" }, rarity = 2 },
		{items = { "moretrees:date" }, rarity = 2 },
		{items = { "moretrees:date" }, rarity = 5 },
		{items = { "moretrees:date" }, rarity = 5 },
		{items = { "moretrees:date" }, rarity = 5 },
		{items = { "moretrees:date" }, rarity = 5 },
		{items = { "moretrees:date" }, rarity = 20 },
		{items = { "moretrees:date" }, rarity = 20 },
		{items = { "moretrees:date" }, rarity = 20 },
		{items = { "moretrees:date" }, rarity = 20 },
	}
}

for _,suffix in ipairs({"f0", "f1", "f2", "f3", "f4", "m0", "fn", "n"}) do
	local name
	if suffix == "f0" or suffix == "m0" then
		name = S("Date Flowers")
	elseif suffix == "n" or suffix == "fn" then
		name = S("Date Stem")
	else
		name = S("Dates")
	end
	local dropfn = suffix == "f4" and dates_drop or ""
	local datedef = {
		description = name,
		tiles = {"moretrees_dates_"..suffix..".png"},
		visual_scale = 2,
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		groups = { fleshy=3, dig_immediate=3, flammable=2, moretrees_dates=1 },
		inventory_image = "moretrees_dates_"..suffix..".png^[transformR0",
		wield_image = "moretrees_dates_"..suffix..".png^[transformR90",
		sounds = default.node_sound_defaults(),
		drop = dropfn,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.3, -0.3, 0.3, 3.5, 0.3}
		},
		on_timer = dates_growfn,
		on_construct = (moretrees.dates_regrow_pollinated or moretrees.dates_regrow_unpollinated_percent > 0)
				and dates_starttimer,

	}
	minetest.register_node("moretrees:dates_"..suffix, datedef)
end
