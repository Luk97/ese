class_name DecorationManager
extends Node

const SOURCE_ID = "source_id"
const ATLAS_COORDS = "atlas_coords"
const PICK_CHANCE = "pick_chance"
const EMPTY = "empty"

@onready var top_layer: TileMapLayer = %TopLayer

var grass_decorations: Dictionary = {
	EMPTY: {
		PICK_CHANCE: 20
	},
	"flowers": {
		SOURCE_ID: 3,
		ATLAS_COORDS: Vector2i(0, 0),
		PICK_CHANCE: 10
	},
	"pond": {
		SOURCE_ID: 3,
		ATLAS_COORDS: Vector2i(1, 0),
		PICK_CHANCE: 1
	}
}
var forest_decorations: Dictionary = {
	"trees_1": {
		SOURCE_ID: 2,
		ATLAS_COORDS: Vector2i(0, 0),
		PICK_CHANCE: 4
	},
	"trees_2": {
		SOURCE_ID: 2,
		ATLAS_COORDS: Vector2i(1, 0),
		PICK_CHANCE: 6
	},
	"trees_3": {
		SOURCE_ID: 1,
		ATLAS_COORDS: Vector2i(0, 0),
		PICK_CHANCE: 10
	}
}

func get_random_decoration(tile: Tile) -> Decoration:
	var decoration: Decoration = null
	if tile is GrassTile:
		decoration = _get_random_decoration(grass_decorations)
	elif tile is ForestTile:
		decoration = _get_random_decoration(forest_decorations)
	return decoration

func _get_random_decoration(decorations: Dictionary) -> Decoration:
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
