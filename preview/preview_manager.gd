class_name PreviewManager
extends Node2D

@onready var tile_manager: TileManager = %TileManager
@onready var preview_layer: TileMapLayer = %PreviewLayer

var enabled: bool = false
var action: Action = null

signal preview_done()

#=================== PUBLIC FUNCTIONS ===================

func enable_preview(action: Action):
	self.action = action
	self.enabled = true


#=================== PRIVATE FUNCTIONS ===================

func _process(delta: float) -> void:
	if enabled:
		_show_preview()

func _unhandled_input(event: InputEvent) -> void:
	if enabled and event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed():
			var cursor_tile = tile_manager.get_cursor_tile()
			if action is BuildingAction and _is_valid_building_tile(action.building, cursor_tile):
				preview_layer.clear()
				tile_manager.place_building(action.building, cursor_tile.global_coords)
				enabled = false
				emit_signal("preview_done")
			elif action is TerrainAction and _is_valid_terrain_tile(action.source_tiles, cursor_tile):
				preview_layer.clear()
				tile_manager.place_tile(action.destination_tile[0].new(cursor_tile.global_coords))
				enabled = false
				emit_signal("preview_done")
func _show_preview():
	preview_layer.clear()
	
	if action == null:
		return
	
	var cursor_tile = tile_manager.get_cursor_tile()
	if cursor_tile == null: return
	
	var source_id: int
	var atlas_coords: Vector2i
	var is_valid = false
	
	if action is BuildingAction:
		source_id = action.building.source_id
		atlas_coords = action.building.atlas_coords
		if _is_valid_building_tile(action.building, cursor_tile):
			is_valid = true
	elif action is TerrainAction:
		source_id = action.source_id
		atlas_coords = action.atlas_coords
		if _is_valid_terrain_tile(action.source_tiles, cursor_tile):
			is_valid = true
	
	var modulate_color = Color(0, 1, 0, 0.75) if is_valid else Color(1, 0, 0, 0.75)
	preview_layer.set_modulate(modulate_color)
	_set_preview(cursor_tile.global_coords, source_id, atlas_coords)

func _is_valid_building_tile(building: Building, tile: Tile) -> bool:
	for possible_tile_type in building.possible_tiles:
		if is_instance_of(tile, possible_tile_type) and tile.building == null:
			return true
	return false

func _is_valid_terrain_tile(source_tiles: Array, tile: Tile) -> bool:
	for source_tile_type in source_tiles:
		if is_instance_of(tile, source_tile_type) and tile.building == null:
			return true
	return false

func _set_preview(coords: Vector2i, source_id: int, atlas_coords: Vector2i) -> void:
	preview_layer.set_cell(coords - Vector2i(1, 1), source_id, atlas_coords)
