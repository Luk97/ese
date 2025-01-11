extends Node

const SOURCE_ID = "source_id"
const ATLAS_COORDS = "atlas_coords"
const PICK_CHANCE = "pick_chance"
const EMPTY = "empty"

# MODIFY DECORATIONS HERE
# This configures the different decorations placed on the top layer of the tile.
# The likeness of a specific decoration increases with its pick chance. The name
# of a decoration can be descriptive, but is just used for better readability.
var grass_decorations: Dictionary = {
	EMPTY: {
		PICK_CHANCE: 20
	},
	"flowers": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(4, 2),
		PICK_CHANCE: 10
	},
	"pond": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(5, 2),
		PICK_CHANCE: 1
	}
}

var tall_grass_decorations: Dictionary = {
	EMPTY: {
		PICK_CHANCE: 1
	},
	"flowers": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(4, 2),
		PICK_CHANCE: 10
	},
	"pond": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(5, 2),
		PICK_CHANCE: 1
	}
}

var sand_decorations: Dictionary = {
	EMPTY: {
		PICK_CHANCE: 10
	},
	"crab": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(8, 2),
		PICK_CHANCE: 2
	},
	"shell": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(9, 2),
		PICK_CHANCE: 2
	}
}

var wet_sand_decorations: Dictionary = {
	EMPTY: {
		PICK_CHANCE: 10
	},
	"crab": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(8, 2),
		PICK_CHANCE: 2
	},
	"shell": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(9, 2),
		PICK_CHANCE: 2
	}
}

var forest_decorations: Dictionary = {
	"trees_1": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(4, 3),
		PICK_CHANCE: 4
	},
	"trees_2": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(5, 3),
		PICK_CHANCE: 6
	},
}

var deep_forest_decorations: Dictionary = {
	"trees_1": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(4, 3),
		PICK_CHANCE: 4
	},
	"trees_2": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(5, 3),
		PICK_CHANCE: 6
	},
}

var mountain_decorations: Dictionary = {
	"stones_1": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(7, 3),
		PICK_CHANCE: 4
	},
	"stones_2": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(8, 3),
		PICK_CHANCE: 6
	},
	"stones_3": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(9, 3),
		PICK_CHANCE: 6
	},
}

var tall_mountain_decorations: Dictionary = {
	"stones_1": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(7, 3),
		PICK_CHANCE: 4
	},
	"stones_2": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(8, 3),
		PICK_CHANCE: 6
	},
	"stones_3": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(9, 3),
		PICK_CHANCE: 6
	},
}

var water_decorations: Dictionary = {
	EMPTY: {
		PICK_CHANCE: 30
	},
	"water_lillies_1": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(6, 2),
		PICK_CHANCE: 1
	},
	"water_lillies_2": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(7, 2),
		PICK_CHANCE: 1
	},
	"fish": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(4, 4),
		PICK_CHANCE: 2
	}
}

var deep_water_decorations: Dictionary = {
	EMPTY: {
		PICK_CHANCE: 8
	},
	"fish": {
		SOURCE_ID: 0,
		ATLAS_COORDS: Vector2i(4, 4),
		PICK_CHANCE: 1
	}
}

#=================== PUBLIC FUNCTIONS ===================

func get_random_decoration(type: Types.TileType) -> Decoration:
	match type:
		Types.TileType.WATER:
			return _pick_random_decoration(water_decorations)
		Types.TileType.DEEP_WATER:
			return _pick_random_decoration(deep_water_decorations)
		Types.TileType.GRASS:
			return _pick_random_decoration(grass_decorations)
		Types.TileType.TALL_GRASS:
			return _pick_random_decoration(tall_grass_decorations)
		Types.TileType.SAND:
			return _pick_random_decoration(sand_decorations)
		Types.TileType.WET_SAND:
			return _pick_random_decoration(wet_sand_decorations)
		Types.TileType.FOREST:
			return _pick_random_decoration(forest_decorations)
		Types.TileType.DEEP_FOREST:
			return _pick_random_decoration(deep_forest_decorations)
		Types.TileType.MOUNTAIN:
			return _pick_random_decoration(mountain_decorations)
		Types.TileType.TALL_MOUNTAIN:
			return _pick_random_decoration(tall_mountain_decorations)
		_:
			printerr("Undefined tile type for decoration: ", str(type))
			return null 

#=================== PRIVATE FUNCTIONS ===================

func _pick_random_decoration(decorations: Dictionary) -> Decoration:
	var overall_chance = 0
	for key in decorations:
		overall_chance += decorations[key][PICK_CHANCE]
	var random_value = randi() % overall_chance + 1
	var offset = 0
	for key in decorations:
		if random_value <= decorations[key][PICK_CHANCE] + offset:
			if key == EMPTY:
				return null
			return Decoration.new(decorations[key][SOURCE_ID], decorations[key][ATLAS_COORDS]) 
		else:
			offset += decorations[key][PICK_CHANCE]
	return null
