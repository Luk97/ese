extends Node2D

@onready var chunk_manager = $ChunkManager
@export var debug_log: Label

const TileType = preload("../tile/tile_type.gd").Type

var previous_tile_coords: Vector2i
var is_previous_tile_preview: bool
var show_preview: bool

func _process(_delta: float) -> void:
	if show_preview:
		_show_tile_preview()

func on_round_finished() -> void:
	show_preview = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse and show_preview:
		var tile_coords = chunk_manager.get_cursor_tile_coords()
		
		# Place tile
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed():
			chunk_manager.set_tile(tile_coords, TileType.GRASS)
			is_previous_tile_preview = false
			show_preview = false

func _show_tile_preview():
	var current_tile_coords = chunk_manager.get_cursor_tile_coords()
	
	# Cursor entered a new tile
	if current_tile_coords != previous_tile_coords:
		
		# Erase the tile the cursor just exited when it was a preview tile
		if (is_previous_tile_preview):
			chunk_manager.erase_tile(previous_tile_coords)
		
		# Place preview tile where the cursor is currently
		if (chunk_manager.is_empty_tile(current_tile_coords)):
			chunk_manager.set_tile(current_tile_coords, TileType.FOREST)
			is_previous_tile_preview = true
		else:
			is_previous_tile_preview = false
		
		previous_tile_coords = current_tile_coords
