class_name Burner
extends Building

func _init() -> void:
	self.label = "Burner"
	self.cost = { Types.ResourceType.WOOD: 6 }
	self.view_radius = 2
	self. source_id = 0
	self. atlas_coords = Vector2i(4, 7)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [Types.TileType.MOUNTAIN]
