extends Node2D

@onready var generator: Node2D = %WorldGenerator

func get_water_neighbours_count(world: Array, x: int, y: int) -> int:
	return _get_neighbours(world, x, y).count(generator.WATER)

func get_land_neighbours_count(world: Array, x: int, y: int) -> int:
	return _get_neighbours(world, x, y).count(generator.GRASS)



	
func _get_water_neighbour_coords(world: Array, x: int, y: int) -> Array:
	var neighbour_coords = _get_neighbour_coords(world, x, y)
	neighbour_coords.filter(func(cell): return world[cell.x][cell.y] == generator.WATER)
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
