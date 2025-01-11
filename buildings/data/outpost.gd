class_name Outpost
extends Building

func _init() -> void:
	self.label = "Outpost"
	self.cost = { Types.ResourceType.WOOD: 7 }
	self.view_radius = 5
	self.source_id = 0
	self.atlas_coords = Vector2i(0, 8)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [Types.TileType.GRASS, Types.TileType.SAND]
