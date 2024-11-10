extends TileMapLayer

@export var altitude_noise = FastNoiseLite.new()
@export var temperature_noise = FastNoiseLite.new()
@export var moisture_noise = FastNoiseLite.new()

@onready var rng: RandomNumberGenerator

# TODO: this needs to be input from the user when starting a new game
const SEED = 123

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.seed = SEED
	altitude_noise.seed = rng.randi()
	temperature_noise.seed = rng.randi()
	moisture_noise.seed = rng.randi()

func _process(delta: float) -> void:
	var radius = calculate_radius()
	generate_chunk(radius)

func calculate_radius() -> Vector2i:
	var visible_area = CameraController.get_visible_area()
	var visible_tiles = Vector2i(visible_area.x / Tile.TILE_WIDTH * 3, visible_area.y / Tile.TILE_HEIGHT * 3)
	return visible_tiles

func generate_chunk(radius: Vector2i) -> void:
	var center_coords = get_center_tile_coords()
	for x in range(radius.x):
		for y in range(radius.y):
			var tile_coords = Vector2i(center_coords.x - radius.x / 2 + x, center_coords.y - radius.y / 2 + y)
			
			# values from [-1..1]
			var altitude = altitude_noise.get_noise_2d(tile_coords.x, tile_coords.y)
			var temperature = temperature_noise.get_noise_2d(tile_coords.x, tile_coords.y)
			var moisture = moisture_noise.get_noise_2d(tile_coords.x, tile_coords.y)
			
			# values from [0..10]
			altitude = stretch_noise_value(altitude)
			temperature = stretch_noise_value(temperature)
			moisture = stretch_noise_value(moisture)
			
			var tile = get_tile_from_environment(altitude, temperature, moisture, tile_coords)
			set_cell(tile.global_coords, tile.source_id, tile.atlas_coords)

func get_center_tile_coords() -> Vector2i:
	var center = CameraController.get_center()
	return local_to_map(center)

func get_cursor_tile_coords() -> Vector2i:
	var local_mouse_coords = get_local_mouse_position()
	return local_to_map(local_mouse_coords) + Vector2i(1, 1)

func stretch_noise_value(value: float) -> float:
	return 5 * value + 5
	
func get_tile_from_environment(altitude: float, temperature: float, moisture: float, coords: Vector2i) -> Tile:
	if altitude < 5:
		return WaterTile.new(coords)
	elif temperature < 5:
		return ForestTile.new(coords)
	else:
		return GrassTile.new(coords)
