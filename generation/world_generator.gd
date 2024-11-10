extends Node2D

@export var land_noise = FastNoiseLite.new()
@export var biome_noise = FastNoiseLite.new()

@onready var utils: Node2D = %Utils

const WATER = 0
const GRASS = 1
const FOREST = 2

const INITIAL_WORLD_SIZE = 128
const LAND_THRESHOLD = 0   
const BIOME_THRESHOLD = -0.15

func generate_world(seed: int) -> Array:
	land_noise.set_seed(seed)
	biome_noise.set_seed(seed)
	
	var first_buffer: Array
	var second_buffer: Array
	
	_generate_land_mass(first_buffer)
	second_buffer = _set_biomes(first_buffer)
	return second_buffer

func _generate_land_mass(world: Array) -> void:
	for x in range(INITIAL_WORLD_SIZE):
		world.append([])
		for y in range(INITIAL_WORLD_SIZE):
			var cell_value = land_noise.get_noise_2d(x, y)
			world[x].append(GRASS if cell_value > LAND_THRESHOLD else WATER)

func _set_biomes(previous_world: Array) -> Array:
	var new_world = previous_world.duplicate()
	var previous_world_size = previous_world.size()
	for x in range(previous_world_size):
		for y in range(previous_world_size):
			if previous_world[x][y] == GRASS:
				var cell_value = biome_noise.get_noise_2d(x, y)
				new_world[x][y] = GRASS if cell_value > BIOME_THRESHOLD else FOREST
			
	return new_world
	
