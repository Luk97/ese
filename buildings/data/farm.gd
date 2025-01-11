class_name Farm
extends Building

func _init() -> void:
	self.label = "Farm"
	self.cost = { Types.ResourceType.WOOD: 5 }
	self.view_radius = 2
	self.source_id = 0
	self.atlas_coords = Vector2i(0, 9)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [
		Types.TileType.GRASS, 
		Types.TileType.TALL_GRASS,
		Types.TileType.SAND,
		Types.TileType.WET_SAND
	]
