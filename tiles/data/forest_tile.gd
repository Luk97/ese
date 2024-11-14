class_name ForestTile
extends Tile

var decorations = {
	"Forest_1": {
		"source_id": 2,
		"atlas_coords": Vector2i(0, 0),
		"probability": 0.5
	},
	"Forest_2": {
		"source_id": 2,
		"atlas_coords": Vector2i(1, 0),
		"probability": 0.5
	}
}

func _init(global_coords: Vector2i) -> void:
	var name = "Forest"
	var source_id = 0
	var atlas_coords = Vector2i(5, 0)
	var replaceable = false
	var decoration = null
	super(name, global_coords, source_id, atlas_coords, replaceable, decoration)
