class_name ForestTile
extends Tile

func _init(global_coords: Vector2i) -> void:
	var name = "Forest"
	var source_id = 0
	var atlas_coords = Vector2i(5, 0)
	var replaceable = false
	super(name, global_coords, source_id, atlas_coords, replaceable)
