class_name Fisherboat
extends Building

func _init() -> void:
	self.label = "Fisherboat"
	self.cost = { Types.ResourceType.WOOD: 4 }
	self.product = {
		Constants.PRODUCT_TYPE: Types.ResourceType.FISH,
		Constants.PRODUCT_AMOUNT: 4,
		Constants.PRODUCT_RATE: 3,
		Constants.PRODUCT_UNTIL_YIELD: 3
	}
	self.view_radius = 1
	self.source_id = 0
	self.atlas_coords = Vector2i(6, 8)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [
		Types.TileType.WATER, 
		Types.TileType.DEEP_WATER
	]
