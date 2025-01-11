class_name Windmill
extends Building

func _init() -> void:
	self.label = "Windmill"
	self.cost = { Types.ResourceType.WOOD: 6 }
	self.product = {
		Constants.PRODUCT_TYPE: Types.ResourceType.BREAD,
		Constants.PRODUCT_AMOUNT: 6,
		Constants.PRODUCT_RATE: 4,
		Constants.PRODUCT_UNTIL_YIELD: 4
	}
	self.view_radius = 3
	self.source_id = 0
	self.atlas_coords = Vector2i(4, 6)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [
		Types.TileType.GRASS, 
		Types.TileType.TALL_GRASS,
		Types.TileType.SAND,
		Types.TileType.WET_SAND,
	]
