class_name Field
extends Building

func _init() -> void:
	self.label = "Field"
	self.cost = { Types.ResourceType.WOOD: 2 }
	self.view_radius = 1
	self.source_id = 12
	self.atlas_coords = Vector2i(0, 0)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [Types.TileType.GRASS]
