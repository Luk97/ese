extends Node2D

@onready var world = $World

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameInterface.get_node("Elements").connect("finish_round", world.on_round_finished)
	world.on_round_finished()
