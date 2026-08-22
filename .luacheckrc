unused_args = false
allow_defined_top = true

exclude_files = {".luacheckrc"}


globals = {
	"moretrees"
}

read_globals = {
	-- Luanti
	"minetest", "core",
	"vector", "VoxelManip",
	"VoxelArea", "PseudoRandom",
	"ItemStack", "dump",
	string = {fields = {"split"}},
  table = {fields = {"copy", "getn"}},

	-- Dependencies
	"default", "ethereal",
	"stairsplus", "stairs",
	"doors", "xcompat",
}
