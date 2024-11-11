extends Node2D

@onready var tile_manager: TileManager = %TileManager
@onready var decoration_layer: DecorationLayer = %DecorationLayer

var possible_placements_positions: Array = []

var previous_cursor_tile: Tile
var show_preview: bool

var headquarter: Building = Headquarter.new()

func _ready() -> void:
	show_preview = true
	_show_preview()

func _process(delta: float) -> void:
	if show_preview:
		_show_preview()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed() and show_preview:
			var cursor_tile = tile_manager.get_cursor_tile()
			if is_instance_of(cursor_tile, GrassTile):
				decoration_layer.set_cell(cursor_tile.global_coords - Vector2i(1, 1), headquarter.source_id, headquarter.atlas_coords)
				show_preview = false

func _show_preview() -> void:
	var cursor_tile = tile_manager.get_cursor_tile()
	if previous_cursor_tile != null and previous_cursor_tile != cursor_tile:
		decoration_layer.erase_cell(previous_cursor_tile.global_coords - Vector2i(1, 1))
		#decoration_layer.set_cell(cursor_tile.global_coords, headquarter.source_id, headquarter.atlas_coords)
	
	if is_instance_of(cursor_tile, GrassTile):
		decoration_layer.set_cell(cursor_tile.global_coords - Vector2i(1, 1), headquarter.source_id, headquarter.atlas_coords)
		previous_cursor_tile = cursor_tile
