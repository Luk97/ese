class_name GrassTile
extends Tile

func _init(map_coords: Vector2i) -> void:
	var name = "Grass"
	var source_id = 1
	var atlas_coords = Vector2i(0, 0)
	super(name, map_coords, source_id, atlas_coords)
