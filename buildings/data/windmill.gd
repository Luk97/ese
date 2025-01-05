class_name Windmill
extends Building

func _init() -> void:
	self.label = "Windmill"
	self.cost = { Types.ResourceType.WOOD: 6 }
	self.view_radius = 3
	self.source_id = 6
	self.atlas_coords = Vector2i(0, 0)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [Types.TileType.GRASS, Types.TileType.BEACH]
