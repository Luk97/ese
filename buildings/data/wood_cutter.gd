class_name WoodCutter
extends Building

func _init() -> void:
	self.label = "Wood Cutter"
	self.cost = { Types.ResourceType.WOOD: 5 }
	self.product = {
		Constants.PRODUCT_TYPE: Types.ResourceType.WOOD,
		Constants.PRODUCT_AMOUNT: 3,
		Constants.PRODUCT_RATE: 2,
		Constants.PRODUCT_UNTIL_YIELD: 2
	}
	self.view_radius = 2
	self.source_id = 0
	self.atlas_coords = Vector2i(0, 7)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [
		Types.TileType.FOREST,
		 Types.TileType.DEEP_FOREST
	]
