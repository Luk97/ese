extends Node2D

const WORLD_SIZE = 32
const LAND_CHANCE = 0.1

func generate_world(seed: int) -> Array:
	var rng = RandomNumberGenerator.new()
	rng.seed = seed
	
	# This overwrites the seed
	rng.randomize()
	
	var world: Array = []
	
	for i in range(WORLD_SIZE):
		world.append([])
		for j in range(WORLD_SIZE):
			if rng.randf() <= LAND_CHANCE:
				world[i].append(1)
			else:
				world[i].append(0)
	return world
