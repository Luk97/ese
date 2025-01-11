class_name Burner
extends Building

func _init() -> void:
	self.label = "Burner"
	self.cost = { Types.ResourceType.WOOD: 6 }
	self.product = {
		Constants.PRODUCT_TYPE: Types.ResourceType.CHAR_COAL,
		Constants.PRODUCT_RATE: 2,
		Constants.PRODUCT_UNTIL_YIELD: 2
	}
	self.view_radius = 2
	self. source_id = 0
	self. atlas_coords = Vector2i(4, 7)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [
		Types.TileType.FOREST,
		 Types.TileType.DEEP_FOREST
	]
