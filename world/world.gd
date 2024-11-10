extends Node2D

@onready var ground_layer: TileMapLayer = %GroundLayer

var possible_placements_positions: Array = []

var previous_tile_coords: Vector2i
var show_preview: bool

func _process(delta: float) -> void:
	if show_preview:
		_show_tile_preview()
		

func enable_preview() -> void:
	show_preview = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed() and show_preview:
			var tile_coords = ground_layer.get_cursor_tile_coords()
			if possible_placements_positions.has(tile_coords):
				ground_layer.place_tile(GrassTile.new(tile_coords))
				show_preview = false

func _show_tile_preview() -> void:
	var tile_coords = ground_layer.get_cursor_tile_coords()
	
	if previous_tile_coords != tile_coords and possible_placements_positions.has(previous_tile_coords):
		ground_layer.place_tile(WaterTile.new(previous_tile_coords))
		pass
	
	if possible_placements_positions.has(tile_coords):
		ground_layer.place_tile(ForestTile.new(tile_coords))
		previous_tile_coords = tile_coords
