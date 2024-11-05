extends Node2D

@onready var rng: RandomNumberGenerator
@onready var island_layer: Node2D = $IslandLayer

func _ready() -> void:
	rng = RandomNumberGenerator.new()

func generate_world(seed: int) -> Array:
	rng.seed = seed
	
	# This overwrites the seed
	rng.randomize()
	
	var world: Array = []
	
	var new_world = island_layer.create_island_layer(rng)
	
	return new_world



func terrain_creation_second_iteration(world: Array):
	pass
