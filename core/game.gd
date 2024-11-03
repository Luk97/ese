extends Node2D

@export var rounds: int = 1

@onready var game_interface: CanvasLayer = %GameInterface
@onready var world: Node2D = %World
@onready var world_generator: Node2D = %WorldGenerator

func _ready() -> void:
	var new_world = world_generator.generate_world(123)
	world.create_new_world(new_world)
	world.enable_preview()

func _on_round_finished() -> void:
	rounds += 1
	game_interface.set_round_count(rounds)
	world.enable_preview()
