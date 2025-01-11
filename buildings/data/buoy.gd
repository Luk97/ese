class_name Buoy
extends Building

func _init() -> void:
	self.label = "Buoy"
	self.cost = { Types.ResourceType.STONE: 6 }
	self.view_radius = 5
	self. source_id = 0
	self. atlas_coords = Vector2i(4, 8)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [
		Types.TileType.WATER,
		 Types.TileType.DEEP_WATER
	]
