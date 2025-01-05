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
		Constants.ACTION_ID_CLEAR_FOREST:
			var terrain_action = action as TerrainAction
			var updated_tile = Tile.new(terrain_action.destination, tile.map_coords)
			TileManager.delete_decoration(tile)
			TileManager.place_tile(updated_tile)
			var earnings = terrain_action.earnings
			ResourceManager.place_resources(earnings.keys()[0], earnings.values()[0], updated_tile)
		_:
			printerr("There is an unhandeled action execution with action: ", action.id)
