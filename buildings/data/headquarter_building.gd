class_name Headquarter
extends Building

func _init() -> void:
	var name = "Headquarter"
	var possible_tiles = [GrassTile]
	var source_id = 1
	var atlas_coords = Vector2i(1, 0)
	super(name, possible_tiles, source_id, atlas_coords)
