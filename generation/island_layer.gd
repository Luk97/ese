extends Node2D

const WATER = 0
const LAND = 1
const INITIAL_WORLD_SIZE = 4
const INITIAL_LAND_CHANCE = 0.1

const LAND_CHANCE_FROM_LAND = 0.9
const LAND_CHANCE_FROM_WATER_WITH_LAND_NEIGHBOUR = 0.1
const LAND_CHANCE_FROM_WATER = 0.05                     

const ISLAND_CHANCE_SPREAD_LAND = 0.5
const ISLAND_CHANCE_BECOME_WATER = 0.3

var rng: RandomNumberGenerator

# Inspired by: https://www.alanzucconi.com/2022/06/05/minecraft-world-generation/
func create_island_layer(user_seed: int) -> Array:
	self.rng = RandomNumberGenerator.new()
	rng.seed = user_seed
	
	var first_buffer: Array
	var second_buffer: Array
	
	first_buffer = _first_zoom_iteration()
	_island_iteration(first_buffer)
	second_buffer = _zoom_iteration(first_buffer)
	first_buffer = _island_iteration(second_buffer)
	second_buffer = _island_iteration(first_buffer)
	first_buffer = _island_iteration(second_buffer)
	second_buffer = _island_iteration(first_buffer)
	first_buffer = _zoom_iteration(second_buffer)
	second_buffer = _zoom_iteration(first_buffer)
	first_buffer = _island_iteration(second_buffer)
	second_buffer = _zoom_iteration(first_buffer)
	first_buffer = _zoom_iteration(second_buffer)
	second_buffer = _zoom_iteration(first_buffer)
	first_buffer = _zoom_iteration(second_buffer)
	second_buffer = _island_iteration(first_buffer)
	first_buffer = _island_iteration(second_buffer)
	second_buffer = _island_iteration(first_buffer)
	first_buffer = _island_iteration(second_buffer)
	
	return first_buffer
	

# Create a 4x4 world with 10 percent beeing landmass.
func _first_zoom_iteration() -> Array:
	var new_world = []
	for x in range(INITIAL_WORLD_SIZE):
		new_world.append([])
		for y in range(INITIAL_WORLD_SIZE):
			var cell_value = LAND if rng.randf() <= INITIAL_LAND_CHANCE else WATER
			new_world[x].append(cell_value)
	return new_world

# Create a world where the previous landmass is scaled up with factor 2 to new world dimensions.
# To make the landscape more interesting, some landtiles become water again and vice verca.
func _zoom_iteration(previous_world: Array) -> Array:
	var previous_world_size = previous_world.size()
	var new_world_size = previous_world_size * 2
	var new_world = []
	for x in range(new_world_size):
		new_world.append([])
		for y in range(new_world_size):
			
	
		
			var land_chance: float
			var previous_world_index = Vector2i(floor(x / 2), floor(y / 2))
			
			if previous_world[previous_world_index.x][previous_world_index.y] == LAND:
				land_chance = LAND_CHANCE_FROM_LAND
			else:
				var has_land_neighbour = _get_land_neighbours_count(previous_world, x, y)
				land_chance = LAND_CHANCE_FROM_WATER_WITH_LAND_NEIGHBOUR if has_land_neighbour else LAND_CHANCE_FROM_WATER
			var cell_value: int = LAND if rng.randf() <= land_chance else WATER
			new_world[x].append(cell_value)
	return new_world
	
func _island_iteration(world: Array) -> Array:
	var new_world = world.duplicate()
	var world_size = world.size()
	for x in range(world_size):
		for y in range(world_size):
			if world[x][y] == LAND:
				var water_neighbours = _get_water_neighbour_coords(world, x, y)
				if rng.randf() <= ISLAND_CHANCE_SPREAD_LAND:
					var random_neighbour = water_neighbours.pick_random()
					new_world[random_neighbour.x][random_neighbour.y] = LAND
					if rng.randf() <= ISLAND_CHANCE_BECOME_WATER:
						new_world[x][y] = WATER
	return new_world

func _get_water_neighbours_count(world: Array, x: int, y: int) -> int:
	return _get_neighbours(world, x, y).count(WATER)

func _get_land_neighbours_count(world: Array, x: int, y: int) -> int:
	return _get_neighbours(world, x, y).count(LAND)
	
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
