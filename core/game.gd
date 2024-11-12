extends Node2D

@export var rounds: int = 1

@onready var game_interface: CanvasLayer = %GameInterface
@onready var tile_manager: TileManager = %TileManager
@onready var decoration_layer: DecorationLayer = %DecorationLayer
@onready var action_manager: ActionManager = %ActionManager

var previous_cursor_tile: Tile = null
var show_preview: bool

var building: Building = Headquarter.new()

func _ready() -> void:
	show_preview = true
	_show_preview()

func _process(_delta: float) -> void:
	if show_preview:
		_show_preview()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed() and show_preview:
			var cursor_tile = tile_manager.get_cursor_tile()
			if is_instance_of(cursor_tile, GrassTile):
				cursor_tile.building = building
				tile_manager.set_tile(cursor_tile)
				decoration_layer.set_cell(cursor_tile.global_coords - Vector2i(1, 1), building.source_id, building.atlas_coords)
				previous_cursor_tile = null
				show_preview = false

func _on_round_finished() -> void:
	rounds += 1
	game_interface.set_round_count(rounds)
	action_manager.start_action_selection()

func _show_preview() -> void:
	var cursor_tile = tile_manager.get_cursor_tile()
	if previous_cursor_tile != null and previous_cursor_tile != cursor_tile and previous_cursor_tile.building == null:
		decoration_layer.erase_cell(previous_cursor_tile.global_coords - Vector2i(1, 1))
	
	if is_instance_of(cursor_tile, GrassTile):
		decoration_layer.set_cell(cursor_tile.global_coords - Vector2i(1, 1), building.source_id, building.atlas_coords)
		previous_cursor_tile = cursor_tile

# TODO: there should be a preview handler instead of handling this in the game directly.
func _on_action_manager_action_selected(action: Action) -> void:
	var building_action = action as BuildingAction
	building = building_action.building
	show_preview = true
