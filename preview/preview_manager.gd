class_name PreviewManager
extends Node2D

@onready var tile_manager: TileManager = %TileManager

var enabled: bool
var preview_action: Action = null
var previous_tile: Tile = null

func _process(delta: float) -> void:
	if enabled:
		_show_preview()

#=================== PUBLIC FUNCTIONS ===================

func enable_preview(action: Action):
	preview_action = action
	enabled = true



#=================== PRIVATE FUNCTIONS ===================

func _show_preview():
	var cursor_tile = tile_manager.get_cursor_tile()
	
	match preview_action.type:
		Action.ActionType.BUILDING:
			_handle_building_preview(preview_action as BuildingAction, cursor_tile)
			
	if previous_tile != null and previous_tile != cursor_tile:
		tile_manager.set_tile(previous_tile)

func _handle_building_preview(building_action: BuildingAction, tile: Tile) -> void:
	for tile_type in building_action.building.possible_tiles:
		if is_instance_of(tile, tile_type) and tile.building == null:
			print("placing...")
			tile_manager.set_building(building_action.building, tile.global_coords)
			previous_tile = tile
			return
