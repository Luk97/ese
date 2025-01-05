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
		_:
			printerr("There is an unhandeled action execution with action: ", action)
