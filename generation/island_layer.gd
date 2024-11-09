extends Node2D

@export var land_noise = FastNoiseLite.new()
@export var biome_noise = FastNoiseLite.new()

const WATER = 0
const GRASS = 1
const FOREST = 2
const INITIAL_WORLD_SIZE = 512
const LAND_THRESHOLD = 0   
const BIOME_THRESHOLD = -0.2


func create_island_layer(user_seed: int) -> Array:
	land_noise.set_seed(user_seed)
	
	var first_buffer: Array
	var second_buffer: Array
	
	_use_perlin_noise(first_buffer)
	second_buffer = _plug_holes(first_buffer)
	first_buffer = _set_biomes(second_buffer)
	return first_buffer

func _use_perlin_noise(world: Array) -> void:
	for x in range(INITIAL_WORLD_SIZE):
		world.append([])
		for y in range(INITIAL_WORLD_SIZE):
			var cell_value = land_noise.get_noise_2d(x, y)
			world[x].append(GRASS if cell_value > LAND_THRESHOLD else WATER)

func _plug_holes(previous_world: Array) -> Array:
	var new_world = previous_world.duplicate()
	var previous_world_size = previous_world.size()
	for x in range(previous_world_size):
		for y in range(previous_world_size):
			if previous_world[x][y] == WATER and _get_land_neighbours_count(previous_world, x, y) >= 5:
				new_world[x][y] = GRASS
			elif previous_world[x][y] == GRASS and _get_water_neighbours_count(previous_world, x, y) ==6:
				new_world[x][y] = WATER
	return new_world
	
func _set_biomes(previous_world: Array) -> Array:
	var new_world = previous_world.duplicate()
	var previous_world_size = previous_world.size()
	for x in range(previous_world_size):
		for y in range(previous_world_size):
			if previous_world[x][y] == GRASS:
				var cell_value = biome_noise.get_noise_2d(x, y)
				new_world[x][y] = GRASS if cell_value > BIOME_THRESHOLD else FOREST
			
	return new_world


func _get_water_neighbours_count(world: Array, x: int, y: int) -> int:
	return _get_neighbours(world, x, y).count(WATER)

func _get_land_neighbours_count(world: Array, x: int, y: int) -> int:
	return _get_neighbours(world, x, y).count(GRASS)
	
func _get_water_neighbour_coords(world: Array, x: int, y: int) -> Array:
	var neighbour_coords = _get_neighbour_coords(world, x, y)
	neighbour_coords.filter(func(cell): return world[cell.x][cell.y] == WATER)
	return neighbour_coords
	
func _get_neighbours(world: Array, x: int, y: int) -> Array:
	var world_size = world.size()
	var neighbours = []
	if _in_bounds(x-1, y-1, world_size):
		neighbours.append(world[x-1][y-1])
	if _in_bounds(x-1, y, world_size):
		neighbours.append(world[x-1][y])
	if _in_bounds(x, y-1, world_size):
		neighbours.append(world[x][y-1])
	if _in_bounds(x, y+1, world_size):
		neighbours.append(world[x][y+1])
	if _in_bounds(x+1, y, world_size):
		neighbours.append(world[x+1][y])
	if _in_bounds(x+1, y+1, world_size):
		neighbours.append(world[x+1][y+1])
	return neighbours

func _get_neighbour_coords(world: Array, x: int, y: int) -> Array:
	var world_size = world.size()
	var neighbours = []
	if _in_bounds(x-1, y-1, world_size):
		neighbours.append(Vector2i(x-1, y-1))
	if _in_bounds(x-1, y, world_size):
		neighbours.append(Vector2i(x-1, y))
	if _in_bounds(x, y-1, world_size):
		neighbours.append(Vector2i(x, y-1))
	if _in_bounds(x, y+1, world_size):
		neighbours.append(Vector2i(x, y+1))
	if _in_bounds(x+1, y, world_size):
		neighbours.append(Vector2i(x+1, y))
	if _in_bounds(x+1, y+1, world_size):
		neighbours.append(Vector2i(x+1, y+1))
	return neighbours

func _in_bounds(x: int, y: int, upper: int) -> bool:
	return x >= 0 and x < upper and y >= 0 and y < upper
