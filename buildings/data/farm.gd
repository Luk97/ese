class_name Farm
extends Building

func _init() -> void:
	self.label = "Farm"
	self.cost = { Types.ResourceType.WOOD: 5 }
	self.view_radius = 2
	self.source_id = 11
	self.atlas_coords = Vector2i(0, 0)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [Types.TileType.GRASS]
