class_name Farm
extends Building

func _init() -> void:
	self.label = "Farm"
	self.cost = {
		Types.ResourceType.WOOD: 4,
		Types.ResourceType.STONE: 8
	}
	self.product = {
		Constants.PRODUCT_TYPE: Types.ResourceType.PORK,
		Constants.PRODUCT_AMOUNT: 10,
		Constants.PRODUCT_RATE: 5,
		Constants.PRODUCT_UNTIL_YIELD: 5
	}
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
