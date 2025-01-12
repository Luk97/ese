class_name ActionExecutor
extends Node

static func perform_action(action: Action, tile: Tile) -> void:
	match (action.id):
		Constants.ACTION_ID_BUILD_HOME:
			TileManager.place_building(action.building, tile.map_coords)
		Constants.ACTION_ID_BUILD_WOOOD_CUTTER:
			TileManager.place_building(action.building, tile.map_coords)
		Constants.ACTION_ID_BUILD_OUTPOST:
			TileManager.place_building(action.building, tile.map_coords)
		Constants.ACTION_ID_BUILD_BURNER:
			TileManager.place_building(action.building, tile.map_coords)
		Constants.ACTION_ID_BUILD_FARM:
			TileManager.place_building(action.building, tile.map_coords)
		Constants.ACTION_ID_BUILD_FIELD:
			TileManager.place_building(action.building, tile.map_coords)
		Constants.ACTION_ID_BUILD_WINDMILL:
			TileManager.place_building(action.building, tile.map_coords)
		Constants.ACTION_ID_BUILD_QUARRY:
			TileManager.place_building(action.building, tile.map_coords)
		Constants.ACTION_ID_BUILD_BUOY:
			TileManager.place_building(action.building, tile.map_coords)
		Constants.ACTION_ID_BUILD_FISHERBOAT:
			TileManager.place_building(action.building, tile.map_coords)
		Constants.ACTION_ID_CLEAR_FOREST:
			var terrain_action = action as TerrainAction
			var updated_tile = Tile.new(terrain_action.destination, tile.map_coords)
			TileManager.delete_decoration(tile)
			TileManager.place_tile(updated_tile)
			var earnings = terrain_action.earnings
			ResourceManager.place_resources(earnings.keys()[0], earnings.values()[0], updated_tile)
		Constants.ACTION_ID_CLEAR_MOUNTAIN:
			var terrain_action = action as TerrainAction
			var updated_tile = Tile.new(terrain_action.destination, tile.map_coords)
			TileManager.delete_decoration(tile)
			TileManager.place_tile(updated_tile)
			var earnings = terrain_action.earnings
			ResourceManager.place_resources(earnings.keys()[0], earnings.values()[0], updated_tile)
		_:
			printerr("There is an unhandeled action execution with action: ", action.id)

static func check_for_existing_tile(action: Action) -> bool:
	var tiles = TileManager.get_tiles()
	if action is BuildingAction:
		var building_action = action as BuildingAction
		for tile: Tile in tiles:
			if building_action.building.is_valid_placement_tile(tile.type) and ResourceManager.building_affordable(building_action.building) and tile.building == null:
				return true
		return false
	elif action is TerrainAction:
		var terrain_action = action as TerrainAction
		for tile: Tile in tiles:
			if tile.type in terrain_action.origins and tile.building == null:
				return true
		return false
	return false
