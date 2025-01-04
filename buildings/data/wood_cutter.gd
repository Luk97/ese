class_name WoodCutter
extends Building

func _init() -> void:
	self.label = "Wood Cutter"
	self.cost = { Types.ResourceType.WOOD: 5 }
	self.view_radius = 2
	self.source_id = 5
	self.atlas_coords = Vector2i(0, 0)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [Types.TileType.FOREST]
