class_name WaterTile
extends Tile

func _init(global_coords: Vector2i) -> void:
	var name = "Water"
	var source_id = 0
	var atlas_coords = Vector2i(0, 0)
	super(name, global_coords, source_id, atlas_coords)
