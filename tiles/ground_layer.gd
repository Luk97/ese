class_name GroundLayer
extends TileMapLayer

@export var altitude_noise = FastNoiseLite.new()
@export var temperature_noise = FastNoiseLite.new()
@export var moisture_noise = FastNoiseLite.new()
@export var biome_map: Array

@onready var tile_manager: TileManager = get_parent()

const STRETCH_FACTOR = 32

#=================== PUBLIC FUNCTIONS ===================

# Get the map coordinates of the tile where the cursor is currently hovering over.
# The offset is needed because the wall of the tile behind would overwrite the top
# coordinate of the surface of the hovered tile.
func get_cursor_tile_coords() -> Vector2i:
	var local_mouse_coords = get_local_mouse_position()
	return local_to_map(local_mouse_coords) + Vector2i(1, 1)

# Generated tiles according to the different noise maps for altitude, temperature and
# moisture. Tiles get circular generated around the given center.
func generate_tiles(center: Vector2i, radius: int) -> void:
	var tiles = get_used_cells()
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			var tile_coords = Vector2i(center.x + x, center.y + y)
			
			if tiles.has(tile_coords):
				continue
			
			if abs(x - y) <= radius:
				# values from [-1..1]
				var altitude = altitude_noise.get_noise_2d(tile_coords.x, tile_coords.y)
				var temperature = temperature_noise.get_noise_2d(tile_coords.x, tile_coords.y)
				var moisture = moisture_noise.get_noise_2d(tile_coords.x, tile_coords.y)
				
				# values from [0..100]
				altitude = _stretch_noise_value(altitude)
				temperature = _stretch_noise_value(temperature)
				moisture = _stretch_noise_value(moisture)
				
				var tile = _get_tile_from_environment(altitude, temperature, moisture, tile_coords)
				tile_manager.place_tile(tile)

func place_starter_tile() -> Vector2i:
	var search_radius = 1
	while true:
		for x in range(-search_radius, search_radius + 1):
			for y in range(-search_radius, search_radius + 1):
				if abs(x - y) <= search_radius:
					var tile_coords = Vector2i(x, y)
					var altitude = altitude_noise.get_noise_2d(tile_coords.x, tile_coords.y)
					var temperature = temperature_noise.get_noise_2d(tile_coords.x, tile_coords.y)
					var moisture = moisture_noise.get_noise_2d(tile_coords.x, tile_coords.y)
					
					# values from [0..100]
					altitude = _stretch_noise_value(altitude)
					temperature = _stretch_noise_value(temperature)
					moisture = _stretch_noise_value(moisture)
					
					var tile = _get_tile_from_environment(altitude, temperature, moisture, tile_coords)
					if tile.type == Types.TileType.GRASS:
						tile_manager.place_tile(tile)
						return tile.map_coords
		search_radius += 1
	return Vector2i(0, 0)


#=================== PRIVATE FUNCTIONS ===================

func _ready() -> void:
	altitude_noise.seed = GameManager.rng.randi()
	temperature_noise.seed = GameManager.rng.randi()
	moisture_noise.seed = GameManager.rng.randi()
	_generate_biome_map()

# NOTE: This is used for show casing the world generation
func _process(delta: float) -> void:
	if GameManager.show_world:
		var radius = _calculate_radius()
		var center = local_to_map(CameraController.get_center())
		generate_tiles(center, radius)

func _calculate_radius() -> int:
	var visible_area = CameraController.get_visible_area()
	return min(visible_area.x / Tile.TILE_WIDTH, 30)

func _stretch_noise_value(value: float) -> float:
	return 50 * value + 50
	
func _get_tile_from_environment(altitude: float, temperature: float, moisture: float, coords: Vector2i) -> Tile:
	if altitude < 40:
		return Tile.new(Types.TileType.DEEP_WATER, coords)
	elif altitude < 50:
		return Tile.new(Types.TileType.WATER, coords)
	elif altitude < 53:
		if GameManager.rng.randf() < 0.3:
			return Tile.new(Types.TileType.WET_SAND, coords)
		else:
			return Tile.new(Types.TileType.SAND, coords)
	else:
		var tile_type = _get_biome_from_coords(coords)
		return Tile.new(tile_type, coords)

func _get_center_tile_coords() -> Vector2i:
	var center = CameraController.get_center()
	return local_to_map(center)

func _generate_biome_map() -> void:
	for x in range(0, STRETCH_FACTOR):
		self.biome_map.append([])
		for y in range(0, STRETCH_FACTOR):
			var biome = _get_biome_from_random()
			self.biome_map[x].append(biome)

func _get_biome_from_random() -> Types.TileType:
	var random = GameManager.rng.randf()
	if random < 0.05:
		return Types.TileType.WATER
	elif random < 0.2:
		return Types.TileType.FOREST
	elif random < 0.25:
		return Types.TileType.DEEP_FOREST
	elif random < 0.28:
		return Types.TileType.MOUNTAIN
	elif random < 0.3:
		return Types.TileType.TALL_MOUNTAIN
	elif random < 0.4:
		return Types.TileType.TALL_GRASS
	else:
		return Types.TileType.GRASS

func _get_biome_from_coords(coords: Vector2i) -> Types.TileType:
	var chunk_coords = Vector2i(
		floor((coords.x + STRETCH_FACTOR * 4) / (STRETCH_FACTOR * 8)), 
		floor((coords.y + STRETCH_FACTOR * 4) / (STRETCH_FACTOR * 8))
	)
	return biome_map[abs(coords.x % 16)][abs(coords.y % 16)]
