extends Node2D

@export var rounds: int = 1

@onready var game_interface: CanvasLayer = %GameInterface
@onready var world: Node2D = %World
@onready var world_generator: Node2D = %WorldGenerator

func _on_round_finished() -> void:
	rounds += 1
	game_interface.set_round_count(rounds)
