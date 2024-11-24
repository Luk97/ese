class_name GroundLayer
extends TileMapLayer

@export var altitude_noise = FastNoiseLite.new()
@export var temperature_noise = FastNoiseLite.new()
@export var moisture_noise = FastNoiseLite.new()

@onready var tile_manager: TileManager = get_parent()


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
				
				# values from [0..10]
				altitude = _stretch_noise_value(altitude)
				temperature = _stretch_noise_value(temperature)
				moisture = _stretch_noise_value(moisture)
				
				var tile = _get_tile_from_environment(altitude, temperature, moisture, tile_coords)
				tile_manager.place_tile(tile)


#=================== PRIVATE FUNCTIONS ===================

# NOTE: This is used for show casing the world generation
func _process(delta: float) -> void:
	pass
	#var radius = _calculate_radius()
	#var center = local_to_map(CameraController.get_center())
	#generate_tiles(center, radius)

func _calculate_radius() -> int:
	var visible_area = CameraController.get_visible_area()
	return visible_area.x / Tile.TILE_WIDTH

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
