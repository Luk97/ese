class_name PreviewManager
extends Node2D

@onready var preview_layer: TileMapLayer = %PreviewLayer

var enabled: bool = false
var valid_placement: bool = false
var action: Action = null
var cursor_tile: Tile = null

signal preview_done()

#=================== PUBLIC FUNCTIONS ===================

func enable_preview(action: Action):
	self.action = action
	self.enabled = true


#=================== PRIVATE FUNCTIONS ===================

func _process(delta: float) -> void:
	if enabled:
		self.preview_layer.clear()
		_update_cursor_tile()
		if self.action == null or self.cursor_tile == null:
			return
		_evaluate_placement()
		_show_preview()

func _unhandled_input(event: InputEvent) -> void:
	if enabled and event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed() and self.cursor_tile != null and self.valid_placement:
			self.preview_layer.clear()
			ActionExecutor.perform_action(action, cursor_tile)
			self.enabled = false
			emit_signal("preview_done")

func _update_cursor_tile() -> void:
	self.cursor_tile = TileManager.get_cursor_tile()

func _evaluate_placement() -> void:
	self.valid_placement = _is_valid_tile(self.action, self.cursor_tile)
	
func _is_valid_tile(action: Action, tile: Tile) -> bool:
	match (action.type):
		Types.ActionType.BUILD_NEW_BUILDING:
			return action.building.is_valid_placement_tile(tile.type) and TileManager.is_free_tile(tile.map_coords)
		_:
			push_error("There is an unhandeled action execution with action: ", action)
			return false

func _show_preview() -> void:
	var modulate_color = Color(0, 1, 0, 0.75) if self.valid_placement else Color(1, 0, 0, 0.75)
	var source_id = action.source_id if action.building == null else action.building.source_id
	var atlas_coords = action.atlas_coords if action.building == null else action.building.atlas_coords
	preview_layer.set_modulate(modulate_color)
	preview_layer.set_cell(cursor_tile.map_coords - Vector2i(1, 1), source_id, atlas_coords)
