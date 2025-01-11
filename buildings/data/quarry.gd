class_name Quarry
extends Building

func _init() -> void:
	self.label = "Quarry"
	self.cost = {
		Types.ResourceType.WOOD: 5,
		Types.ResourceType.STONE: 4
	}
	self.product = {
		Constants.PRODUCT_TYPE: Types.ResourceType.STONE,
		Constants.PRODUCT_AMOUNT: 5,
		Constants.PRODUCT_RATE: 3,
		Constants.PRODUCT_UNTIL_YIELD: 3
	}
	self.view_radius = 2
	self.source_id = 0
	self.atlas_coords = Vector2i(4, 5)

func is_valid_placement_tile(type: Types.TileType) -> bool:
	return type in [
		Types.TileType.MOUNTAIN, 
		Types.TileType.TALL_MOUNTAIN
	]
