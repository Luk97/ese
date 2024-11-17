class_name Headquarter
extends Building

func _init() -> void:
	var name = "Headquarter"
	var possible_tiles = [GrassTile]
	var source_id = 4
	var atlas_coords = Vector2i(0, 0)
	super(name, possible_tiles, source_id, atlas_coords)
