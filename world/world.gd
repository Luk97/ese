extends Node2D

@onready var tile_placement_finder: Node2D = %TilePlacementFinder
@onready var tile_manager: Node2D = %TileManager

var possible_placements_positions: Array = []

var previous_tile_coords: Vector2i
var show_preview: bool

func _process(delta: float) -> void:
	if show_preview:
		_show_tile_preview()

func enable_preview() -> void:
	# TODO: it is hardcoded for a grass tile for now. Generalize it.
	possible_placements_positions = tile_placement_finder.find_possible_placements("Grass")
	show_preview = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		# Place tile
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed() and show_preview:
			var tile_coords = tile_manager.get_cursor_tile_coords()
			if possible_placements_positions.has(tile_coords):
				tile_manager.place_tile(tile_coords, "Grass")
				show_preview = false

func _show_tile_preview() -> void:
	var tile_coords = tile_manager.get_cursor_tile_coords()
	
	if previous_tile_coords != tile_coords and possible_placements_positions.has(previous_tile_coords):
		tile_manager.place_tile(previous_tile_coords, "Water")
	
	if possible_placements_positions.has(tile_coords):
		tile_manager.place_tile(tile_coords, "Forest")
		previous_tile_coords = tile_coords
