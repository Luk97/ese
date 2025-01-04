class_name Home
extends Building

func _init() -> void:
	
	self.label = "Home"
	self.cost = { Types.ResourceType.WOOD: 5}
	self.view_radius = 2
	self.source_id = 4
	self.atlas_coords = Vector2i(0, 0)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [Types.TileType.GRASS, Types.TileType.BEACH]
