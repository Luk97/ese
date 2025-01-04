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
		_:
			push_error("There is an unhandeled action execution with action: ", action)
