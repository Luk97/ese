extends Node2D

@onready var tile_manager: Node2D = %TileManager

var possible_placements_positions: Array = []

var previous_tile_coords: Vector2i
var show_preview: bool

func _process(delta: float) -> void:
	if show_preview:
		_show_tile_preview()
		
func create_new_world(new_world: Array) -> void:
	for i in range(-16, 16):
		for j in range(-16, 16):
			var coords = Vector2i(i, j)
			if new_world[i+16][j+16] == 0:
				tile_manager.place_tile(WaterTile.new(coords))
			else:
				tile_manager.place_tile(GrassTile.new(coords))

func enable_preview() -> void:
	# TODO: it is hardcoded for a grass tile for now. Generalize it.
	possible_placements_positions = tile_manager.find_possible_placements()
	show_preview = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		# Place tile
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed() and show_preview:
			var tile_coords = tile_manager.get_cursor_tile_coords()
			if possible_placements_positions.has(tile_coords):
				tile_manager.place_tile(GrassTile.new(tile_coords))
				show_preview = false

func _show_tile_preview() -> void:
	var tile_coords = tile_manager.get_cursor_tile_coords()
	
	if previous_tile_coords != tile_coords and possible_placements_positions.has(previous_tile_coords):
		tile_manager.place_tile(WaterTile.new(previous_tile_coords))
		pass
	
	if possible_placements_positions.has(tile_coords):
		tile_manager.place_tile(ForestTile.new(tile_coords))
		previous_tile_coords = tile_coords
