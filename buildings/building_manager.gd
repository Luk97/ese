extends Node

#=================== PUBLIC FUNCTIONS ===================

func update_building_productions() -> void:
	var building_tiles: Array = TileManager.get_building_tiles()
	for tile: Tile in building_tiles:
		if not tile.building.product.is_empty():
			if tile.building.product[Constants.PRODUCT_UNTIL_YIELD] == 0:
				tile.building.product[Constants.PRODUCT_UNTIL_YIELD] = tile.building.product[Constants.PRODUCT_RATE]
				var resource_type = tile.building.product[Constants.PRODUCT_TYPE]
				ResourceManager.place_resources(resource_type, 1, tile)
			tile.building.product[Constants.PRODUCT_UNTIL_YIELD] -= 1
			TileManager.update_tile(tile)
