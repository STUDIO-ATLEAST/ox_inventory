return {
	-- Hand crafting from the inventory's Crafting tab. No points or zones, so the server treats the
	-- player's own position as the bench (works anywhere). Ingredients must be in the pockets.
	{
		name = 'personal',
		label = 'Crafting',
		items = {
			{ name = 'bandage', ingredients = { fabric = 2 }, duration = 3000, count = 2 },
			{ name = 'gauze', ingredients = { fabric = 3 }, duration = 3500, count = 2 },
			{ name = 'tourniquet', ingredients = { fabric = 1, rubber = 1 }, duration = 4000, count = 1 },
			{ name = 'splint', ingredients = { wood_planks = 2, duct_tape = 1 }, duration = 5000, count = 1 },
			{ name = 'lockpick', ingredients = { scrap_metal = 2, metal_parts = 1 }, duration = 5000, count = 2 },
			{ name = 'advancedlockpick', ingredients = { lockpick = 1, metal_parts = 2, plastic = 1 }, duration = 7000, count = 1 },
			{ name = 'radio', ingredients = { electronic_parts = 2, plastic = 2, copper_coil = 1 }, duration = 8000, count = 1 },
		},
	},
	{
        name = 'debug_crafting',
		items = {
			{
				name = 'lockpick',
				ingredients = {
					scrapmetal = 5,
					WEAPON_HAMMER = 0.05
				},
				duration = 5000,
				count = 2,
			},
		},
		points = {
			vec3(-1147.083008, -2002.662109, 13.180260),
			vec3(-345.374969, -130.687088, 39.009613)
		},
		zones = {
			{
				coords = vec3(-1146.2, -2002.05, 13.2),
				size = vec3(3.8, 1.05, 0.15),
				distance = 1.5,
				rotation = 315.0,
			},
			{
				coords = vec3(-346.1, -130.45, 39.0),
				size = vec3(3.8, 1.05, 0.15),
				distance = 1.5,
				rotation = 70.0,
			},
		},
		blip = { id = 566, colour = 31, scale = 0.8 },
	},
}
