extends Node2D

@onready var island_layer: Node2D = $IslandLayer

func generate_world(user_seed: int) -> Array:
	#TODO: the same seed should produce always the same result
	
	# This overwrites the seed
	#rng.randomize()
	
	var new_world = island_layer.create_island_layer(user_seed)
	return new_world
