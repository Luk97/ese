class_name GroundLayer
extends TileMapLayer

@export var altitude_noise = FastNoiseLite.new()
@export var temperature_noise = FastNoiseLite.new()
@export var moisture_noise = FastNoiseLite.new()

@onready var tile_manager: TileManager = %TileManager

func _ready() -> void:
	var seed = randi()
	#tile_manager.rng.seed = tile_manager.SEED
	tile_manager.rng.seed = seed
	altitude_noise.seed = tile_manager.rng.randi()
	temperature_noise.seed = tile_manager.rng.randi()
	moisture_noise.seed = tile_manager.rng.randi()

# NOTE: This is used for testing the world generation
func _process(delta: float) -> void:
	pass
	#var radius = _calculate_radius()
	#generate_chunk(radius)



#=================== PUBLIC FUNCTIONS ===================

func get_cursor_tile_coords() -> Vector2i:
	var local_mouse_coords = get_local_mouse_position()
	return local_to_map(local_mouse_coords) + Vector2i(1, 1)

func generate_chunk(radius: Vector2i) -> void:
	var center_coords = _get_center_tile_coords()
	for x in range(radius.x):
		for y in range(radius.y):
			var tile_coords = Vector2i(center_coords.x + x, center_coords.y + y)
			if get_cell_source_id(tile_coords) == -1:
				
				# values from [-1..1]
				var altitude = altitude_noise.get_noise_2d(tile_coords.x, tile_coords.y)
				var temperature = temperature_noise.get_noise_2d(tile_coords.x, tile_coords.y)
				var moisture = moisture_noise.get_noise_2d(tile_coords.x, tile_coords.y)
				
				# values from [0..10]
				altitude = _stretch_noise_value(altitude)
				temperature = _stretch_noise_value(temperature)
				moisture = _stretch_noise_value(moisture)
				
				var tile = _get_tile_from_environment(altitude, temperature, moisture, tile_coords)
				tile_manager.place_new_tile(tile)

func generate_start_tiles(radius: int) -> void:
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			var tile_coords = Vector2i(x, y)
			
			if abs(x - y) <= radius:
				# values from [-1..1]
				var altitude = altitude_noise.get_noise_2d(tile_coords.x, tile_coords.y)
				var temperature = temperature_noise.get_noise_2d(tile_coords.x, tile_coords.y)
				var moisture = moisture_noise.get_noise_2d(tile_coords.x, tile_coords.y)
				
				# values from [0..10]
				altitude = _stretch_noise_value(altitude)
				temperature = _stretch_noise_value(temperature)
				moisture = _stretch_noise_value(moisture)
				
				var tile = _get_tile_from_environment(altitude, temperature, moisture, tile_coords)				
				tile_manager.place_tile(tile)


#=================== PRIVATE FUNCTIONS ===================

func _calculate_radius() -> Vector2i:
	var visible_area = CameraController.get_visible_area()
	var visible_tiles = Vector2i(visible_area.x / Tile.TILE_WIDTH * 3, visible_area.y / Tile.TILE_HEIGHT * 3)
	return visible_tiles

func _stretch_noise_value(value: float) -> float:
	return 5 * value + 5
	
func _get_tile_from_environment(altitude: float, temperature: float, moisture: float, coords: Vector2i) -> Tile:
	if altitude < 5:
		return WaterTile.new(coords)
	elif temperature < 5:
		return ForestTile.new(coords)
	else:
		return GrassTile.new(coords)

func _get_center_tile_coords() -> Vector2i:
	var center = CameraController.get_center()
	return local_to_map(center)
