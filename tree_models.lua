moretrees.beech_model={
	axiom="FFFFFBFB",
	rules_a="[&&&GGF[++^Fd][--&Fd]//Fd[+^Fd][--&Fd]]////[&&&GGF[++^Fd][--&Fd]//Fd[+^Fd][--&Fd]]////[&&&GGF[++^Fd][--&Fd]//Fd[+^Fd][--&Fdd]]",
	rules_b="[&&&F[++^Fd][--&d]//d[+^d][--&d]]////[&&&F[++^Fd][--&d]//d[+^d][--&d]]////[&&&F[++^Fd][--&Fd]//d[+^d][--&d]]",
	rules_c="/",
	rules_d="F",
	trunk="moretrees:beech_trunk",
	leaves="moretrees:beech_leaves",
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
	enable_unique_ids = true,
}

moretrees.apple_tree_model={
	axiom="FFFFFAFFBF",
	rules_a="[&&&FFFFF&&FFFF][&&&++++FFFFF&&FFFF][&&&----FFFFF&&FFFF]",
	rules_b="[&&&++FFFFF&&FFFF][&&&--FFFFF&&FFFF][&&&------FFFFF&&FFFF]",
	trunk="moretrees:apple_tree_trunk",
	leaves="moretrees:apple_tree_leaves",
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
	fruit="default:apple",
	fruit_chance=15,
	enable_unique_ids = true,
}

moretrees.oak_model={
	axiom="FFFFFFA",
	rules_a="[&FFBFA]////[&BFFFA]////[&FBFFA]",
	rules_b="[&FFFA]////[&FFFA]////[&FFFA]",
	trunk="moretrees:oak_trunk",
	leaves="moretrees:oak_leaves",
	angle=30,
	iterations=5,
	random_level=2,
	trunk_type="crossed",
	thin_branches=false,
	fruit="moretrees:acorn",
	fruit_chance=3,
	enable_unique_ids = true,
}

moretrees.sequoia_model={
	axiom="FFFFFFFFFFddccA///cccFddcFA///ddFcFA/cFFddFcdBddd/A/ccdcddd/ccAddddcFBcccAccFdFcFBcccc/BFdFFcFFdcccc/B",
	rules_a="[&&&GGF[++^FFdd][--&Fddd]//Fdd[+^Fd][--&Fdd]]////[&&&GGF[++^FFdd][--&Fddd]//Fdd[+^Fd][--&Fdd]]////[&&&GGF[++^FFdd][--&Fddd]//Fdd[+^Fd][--&Fdd]]",
	rules_b="[&&&GGF[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]////[&&&GGF[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]////[&&&GGF[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]",
	rules_c="/",
	rules_d="F",
	trunk="moretrees:sequoia_trunk",
	leaves="moretrees:sequoia_leaves",
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="crossed",
	thin_branches=true,
	enable_unique_ids = true,
}

moretrees.birch_model1={
	axiom="FFFFFdddccA/FFFFFFcA/FFFFFFcB",
	rules_a="[&&&dddd^^ddddddd][&&&---dddd^^ddddddd][&&&+++dddd^^ddddddd][&&&++++++dddd^^ddddddd]",
	rules_b="[&&&ddd^^ddddd][&&&---ddd^^ddddd][&&&+++ddd^^ddddd][&&&++++++ddd^^ddddd]",
	rules_c="/",
	rules_d="F",
	trunk="moretrees:birch_trunk",
	leaves="moretrees:birch_leaves",
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
	enable_unique_ids = true,
}

moretrees.birch_model2={
	axiom="FFFdddccA/FFFFFccA/FFFFFccB",
	rules_a="[&&&dFFF^^FFFdd][&&&---dFFF^^FFFdd][&&&+++dFFF^^FFFdd][&&&++++++dFFF^^FFFdd]",
	rules_b="[&&&dFF^^FFFd][&&&---dFFF^^FFFd][&&&+++dFF^^FFFd][&&&++++++dFF^^FFFd]",
	rules_c="/",
	rules_d="F",
	trunk="moretrees:birch_trunk",
	leaves="moretrees:birch_leaves",
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
	enable_unique_ids = true,
}

moretrees.palm_model={
	axiom="FFcccccc&FFFFFddd[^&&&GR][^///&&&GR][^//////&&&GR][^***&&&GR]FA//A//A//A//A//A",
	rules_a="[&fb&bbb[++f--&ffff&ff][--f++&ffff&ff]&ffff&bbbb&b]",
	rules_b="f",
	rules_c="/",
	rules_d="F",
	trunk="moretrees:palm_trunk",
	leaves="moretrees:palm_leaves",
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
	fruit="moretrees:coconut",
	fruit_chance=0,
	enable_unique_ids = true,
}

moretrees.spruce_model1={
	axiom="FFFFFAFFFFFFBFFFFFFCFFFFFFDFFFFFF[&&&F^^FF][&&&++F^^FF][&&&++++F^^FF][&&&++++++F^^FF][&&&--F^^FF][&&&----F^^FF][FFFFf]",
	rules_a="[&&&FFFFFF^^FFF][&&&++FFFFFF^^FFF][&&&++++FFFFFF^^FFF][&&&++++++FFFFFF^^FFF][&&&--FFFFFF^^FFF][&&&----FFFFFF^^FFF]",
	rules_b="[&&&FFFFF^^FFF][&&&++FFFFF^^FFF][&&&++++FFFFF^^FFF][&&&++++++FFFFF^^FFF][&&&--FFFFF^^FFF][&&&----FFFFF^^FFF]",
	rules_c="[&&&FFFF^^FFF][&&&++FFFF^^FFF][&&&++++FFFF^^FFF][&&&++++++FFFF^^FFF][&&&--FFFF^^FFF][&&&----FFFF^^FFF]",
	rules_d="[&&&FFF^^FFF][&&&++FFF^^FFF][&&&++++FFF^^FFF][&&&++++++FFF^^FFF][&&&--FFF^^FFF][&&&----FFF^^FFF]",
	trunk="moretrees:spruce_trunk",
	leaves="moretrees:spruce_leaves",
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="crossed",
	thin_branches=true,
	fruit="moretrees:spruce_cone",
	fruit_chance=8,
	enable_unique_ids = true,
}

moretrees.spruce_model2={
	axiom="FFFFFFBFFFFFFCFFFFFFDFFFFFF[&&&F^^FF][&&&++F^^FF][&&&++++F^^FF][&&&++++++F^^FF][&&&--F^^FF][&&&----F^^FF][FFFFf]",
	rules_b="[&&&FFFFF^^FFF][&&&++FFFFF^^FFF][&&&++++FFFFF^^FFF][&&&++++++FFFFF^^FFF][&&&--FFFFF^^FFF][&&&----FFFFF^^FFF]",
	rules_c="[&&&FFFF^^FFF][&&&++FFFF^^FFF][&&&++++FFFF^^FFF][&&&++++++FFFF^^FFF][&&&--FFFF^^FFF][&&&----FFFF^^FFF]",
	rules_d="[&&&FFF^^FFF][&&&++FFF^^FFF][&&&++++FFF^^FFF][&&&++++++FFF^^FFF][&&&--FFF^^FFF][&&&----FFF^^FFF]",
	trunk="moretrees:spruce_trunk",
	leaves="moretrees:spruce_leaves",
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="crossed",
	thin_branches=true,
	fruit="moretrees:spruce_cone",
	fruit_chance=8,
	enable_unique_ids = true,
}

moretrees.pine_model={
	axiom="FFFFFcccdddB///cFdFB////cFdFB///cFdFB///cFdFA///cFdFA///cFdFB[FF]f",
	rules_a="[&&&TTTT[++^TFdd][--&TFd]//Tdd[+^Fd][--&Fdd]]",
	rules_b="[&&&TTT[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]",
	rules_c="/",
	rules_d="F",
	trunk="moretrees:pine_trunk",
	leaves="moretrees:pine_leaves",
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
	fruit="moretrees:pine_cone",
	fruit_chance=8,
	enable_unique_ids = true,
}

moretrees.willow_model={
	axiom="FFFFFFFFccA",
	rules_a="[&FF&FFFF&&F&FFFFFFFdddd][**&FF&FFFF&&F&FFFFFFFdddd][//&FF&FFFF&&F&FFFFFFFdddd][////&FF&FFFF&&F&FFFFFFFdddd][//////&FF&FFFF&&F&FFFFFFFdddd][////////&FF&FFFF&&F&FFFFFFFdddd]",
	rules_c="/",
	rules_d="F",
	trunk="moretrees:willow_trunk",
	leaves="moretrees:willow_leaves",
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="crossed",
	thin_branches=true,
	enable_unique_ids = true,
}

moretrees.acacia_model={
	axiom="FFFFFFccccA",
	rules_a = "[B]//[B]//[B]//[B]",
	rules_b = "&TTTT&TT^^G&&----GGGGGG++GGG++"	-- line up with the "canvas" edge
			.."fffffffGG++G++"					-- first layer, drawn in a zig-zag raster pattern
			.."Gffffffff--G--"
			.."ffffffffG++G++"
			.."fffffffff--G--"
			.."fffffffff++G++"
			.."fffffffff--G--"
			.."ffffffffG++G++"
			.."Gffffffff--G--"
			.."fffffffGG"
			.."^^G&&----GGGGGGG++GGGGGG++"		-- re-align to second layer canvas edge
			.."ffffGGG++G++"					-- second layer
			.."GGfffff--G--"
			.."ffffffG++G++"
			.."fffffff--G--"
			.."ffffffG++G++"
			.."GGfffff--G--"
			.."ffffGGG",
	rules_c = "/",
	trunk="moretrees:acacia_trunk",
	leaves="moretrees:acacia_leaves",
	angle=45,
	iterations=3,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
	enable_unique_ids = true,
}

moretrees.rubber_tree_model={
	axiom="FFFFA",
	rules_a="[&FFBFA]////[&BFFFA]////[&FBFFA]",
	rules_b="[&FFA]////[&FFA]////[&FFA]",
	trunk="moretrees:rubber_tree_trunk",
	leaves="moretrees:rubber_tree_leaves",
	angle=35,
	iterations=3,
	random_level=1,
	trunk_type="double",
	thin_branches=true,
	enable_unique_ids = true,
}

moretrees.jungletree_model={
	axiom=nil,
	rules_a=nil,
	rules_b=nil,
	trunk="default:jungletree",
	leaves="moretrees:jungletree_leaves_green",
	leaves2=nil,
	leaves2_chance=nil,
	angle=45,
	iterations=nil,
	random_level=2,
	trunk_type=nil,
	thin_branches=true,
	fruit_chance=15,
	fruit="vines:vine",
	enable_unique_ids = true,
}

moretrees.fir_model={
	axiom="FFFAF[&&-F][&&+F][&&---F][&&+++F]Fff",
	rules_a=nil,
	rules_b=nil,
	trunk="moretrees:fir_trunk",
	leaves=nil,
	angle=45,
	iterations=7,
	random_level=5,
	trunk_type="single",
	thin_branches=true,
	fruit="moretrees:fir_cone",
	fruit_chance=8,
	enable_unique_ids = true,
}
