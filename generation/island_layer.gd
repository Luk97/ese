extends Node2D

const WATER = 0
const LAND = 1
const INITIAL_WORLD_SIZE = 4

const LAND_CHANCE_INITIAL = 0.1
const LAND_CHANCE_FROM_LAND = 0.9
const LAND_CHANCE_FROM_WATER_WITH_LAND_NEIGHBOUR = 0.2
const LAND_CHANCE_FROM_WATER = 0.1

const ISLAND_CHANCE_ZERO_LAND_NEIGHBOURS = 0.0
const ISLAND_CHANCE_ONE_LAND_NEIGHBOURS = 0.1
const ISLAND_CHANCE_TWO_LAND_NEIGHBOURS = 0.1
const ISLAND_CHANCE_THREE_LAND_NEIGHBOURS = 0.2
const ISLAND_CHANCE_FOUR_LAND_NEIGHBOURS = 0.4
const ISLAND_CHANCE_FIVE_LAND_NEIGHBOURS = 0.8
const ISLAND_CHANCE_SIX_LAND_NEIGHBOURS = 0.9
const ISLAND_CHANCE_BECOME_WATER = 0.1

var rng: RandomNumberGenerator

# Inspired by: https://www.alanzucconi.com/2022/06/05/minecraft-world-generation/
func create_island_layer(rng: RandomNumberGenerator) -> Array:
	self.rng = rng
	
	var first_world_iteration = _first_zoom_iteration()
	_island_iteration(first_world_iteration)
	var second_world_iteration = _zoom_iteration(first_world_iteration)
	_island_iteration(second_world_iteration)
	_island_iteration(second_world_iteration)
	_island_iteration(second_world_iteration)
	_island_iteration(second_world_iteration)
	var third_world_iteration = _zoom_iteration(second_world_iteration)
	var fourth_world_iteration = _zoom_iteration(third_world_iteration)
	_island_iteration(fourth_world_iteration)
	#var fifth_world_iteration = _zoom_iteration(fourth_world_iteration)
	#var sixth_world_iteration = _zoom_iteration(fifth_world_iteration)
	#var seventh_world_iteration = _zoom_iteration(sixth_world_iteration)
	#var eigth_world_iteration = _zoom_iteration(seventh_world_iteration)
	return fourth_world_iteration
	

# Create a 4x4 world with 10 percent beeing landmass.
func _first_zoom_iteration() -> Array:
	var new_world = []
	for x in range(INITIAL_WORLD_SIZE):
		new_world.append([])
		for y in range(INITIAL_WORLD_SIZE):
			if rng.randf() <= LAND_CHANCE_INITIAL:
				new_world[x].append(LAND)
			else:
				new_world[x].append(WATER)
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
	
func _island_iteration(world: Array) -> void:
	var world_size = world.size()
	for x in range(world_size):
		for y in range(world_size):
			if world[x][y] == WATER:
				var land_neighbours = _get_land_neighbours_count(world, x, y)
				var land_chance: float
				match land_neighbours:
					0: land_chance = ISLAND_CHANCE_ZERO_LAND_NEIGHBOURS
					1: land_chance = ISLAND_CHANCE_ONE_LAND_NEIGHBOURS
					2: land_chance = ISLAND_CHANCE_TWO_LAND_NEIGHBOURS
					3: land_chance = ISLAND_CHANCE_THREE_LAND_NEIGHBOURS
					4: land_chance = ISLAND_CHANCE_FOUR_LAND_NEIGHBOURS
					5: land_chance = ISLAND_CHANCE_FIVE_LAND_NEIGHBOURS
					6: land_chance = ISLAND_CHANCE_SIX_LAND_NEIGHBOURS
				world[x][y] = LAND if rng.randf() <= land_chance else WATER
			else:
				world[x][y] = WATER if rng.randf() <= ISLAND_CHANCE_BECOME_WATER else LAND

func _get_land_neighbours_count(world: Array, x: int, y: int) -> int:
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
		
	return neighbours.count(LAND)


func _in_bounds(x: int, y: int, upper: int) -> bool:
	return x >= 0 and x < upper and y >= 0 and y < upper
