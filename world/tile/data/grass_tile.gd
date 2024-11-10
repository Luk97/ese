class_name GrassTile
extends Tile

func _init(global_coords: Vector2i) -> void:
	var name = "Grass"
	var source_id = 0
	var atlas_coords = Vector2i(4, 0)
	var replaceable = false
	var decorations = {}
	super(name, global_coords, source_id, atlas_coords, replaceable, decorations)
