class_name ActionManager
extends Node

signal action_selected(action: Action)

@onready var action_selection: ActionSelection = %ActionSelection
@onready var building_manager: BuildingManager = %BuildingManager
@onready var rng: RandomNumberGenerator
@onready var repository: Node = %Repository

func get_starter_action() -> Action:
	return repository.get_starter_action()

func start_action_selection() -> void:
	var actions = repository.get_random_selection_from_pool()
	action_selection.set_action_selection_content(actions[0], actions[1], actions[2])
	action_selection.visible = true

func _ready() -> void:
	#Scaling the Container for the cards
	var scale=Vector2(0.8,0.8);
	action_selection.scale=(scale);
	#Das Offset macht so aktuell ein Scaling Problem!
	action_selection.offset=(Vector2(10*get_window().size.x/100,10*get_window().size.y/100));

func _on_action_selected(action: Action) -> void:
	action_selection.visible = false
	emit_signal("action_selected", action)
