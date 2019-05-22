-- sapling growth
-- these tables only affect hand-placed saplings
-- mapgen-placed always use their biome def settings, which are much more
-- limited, in the interest of speed.

local dirt_surfaces = {
	"default:dirt",
	"default:dirt_with_grass",
	"default:dirt_with_dry_grass",
	"default:dirt_with_coniferous_litter",
	"default:dirt_with_rainforest_litter",
	"default:dirt_with_snow",
	"woodsoils:dirt_with_leaves_1",
	"woodsoils:dirt_with_leaves_2",
	"woodsoils:grass_with_leaves_1",
	"woodsoils:grass_with_leaves_2"
}

local cold_surfaces = {
	"default:dirt_with_snow"
}

local sand_surfaces = {
	"default:sand",
	"default:desert_sand",
	"cottages:loam",
	-- note, no silver sand here.
	-- too cold for a palm, too... well... sandy for anything else.
}

for i in ipairs(moretrees.treelist) do
	local treename = moretrees.treelist[i][1]
	local tree_model = treename.."_model"
	local tree_biome = treename.."_biome"
	local surfaces
	local grow_function = moretrees[tree_model]

	if treename == "spruce"
	  or treename == "fir"
	  or treename == "cedar"
	  or treename == "pine" then
		surfaces = cold_surfaces
	elseif string.find(treename, "palm") then
		surfaces = sand_surfaces
	else
		surfaces = dirt_surfaces
	end

	if treename == "spruce"
	  or treename == "fir"
	  or treename == "birch"
	  or treename == "jungletree" then
		grow_function = "moretrees.grow_"..treename
	end

	biome_lib:dbg(dump(moretrees[tree_biome].surface))

	biome_lib:grow_plants({
		grow_delay = moretrees.sapling_interval,
		grow_chance = moretrees.sapling_chance,
		grow_plant = "moretrees:"..treename.."_sapling",
		grow_nodes = surfaces,
		grow_function = grow_function,
	})

	if moretrees.spawn_saplings then
		biome_lib:grow_plants({
			grow_delay = 2,
			grow_chance = 1,
			grow_plant = "moretrees:"..treename.."_sapling_ongen",
			grow_nodes = moretrees[tree_biome].surface,
			grow_function = grow_function,
		})
	end
end
