class_name Field
extends Building

func _init() -> void:
	self.label = "Field"
	self.cost = { Types.ResourceType.WOOD: 2 }
	self.product = {
		Constants.PRODUCT_TYPE: Types.ResourceType.WHEAT,
		Constants.PRODUCT_AMOUNT: 1,
		Constants.PRODUCT_RATE: 2,
		Constants.PRODUCT_UNTIL_YIELD: 2
	}
	self.view_radius = 1
	self.source_id = 0
	self.atlas_coords = Vector2i(4, 9)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [
		Types.TileType.GRASS, 
		Types.TileType.TALL_GRASS
	]
