extends Node

#=================== PUBLIC FUNCTIONS ===================

func update_building_productions() -> void:
	var building_tiles = TileManager.get_building_tiles()
	for tile in building_tiles:
		var product: Dictionary = tile.building.product
		if not product.is_empty():
			if product[Constants.PRODUCT_UNTIL_YIELD] == 0:
				product[Constants.PRODUCT_UNTIL_YIELD] = product[Constants.PRODUCT_RATE]
				var resource_type = product[Constants.PRODUCT_TYPE]
				ResourceManager.place_resources(resource_type, 1, tile)
			else:
				product[Constants.PRODUCT_UNTIL_YIELD] -= 1
