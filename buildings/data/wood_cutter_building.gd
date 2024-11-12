class_name WoodCutter
extends Building

func _init() -> void:
	var name = "Wood Cutter"
	var possible_tiles = [ForestTile]
	var source_id = 1
	var atlas_coords = Vector2i(2, 0)
	super(name, possible_tiles, source_id, atlas_coords)
