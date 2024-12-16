class_name ActionManager
extends Node

signal action_selected(action: Action)

@export var selection: Array[Action]

@onready var catalog: Array[Action]
@onready var pool: Array[Action]
@onready var action_selection: ActionSelection = %ActionSelection
@onready var building_manager: BuildingManager = %BuildingManager
@onready var rng: RandomNumberGenerator


func get_starter_action() -> Action:
	return pool[0]

func start_action_selection() -> void:
	var actions = _get_random_selection()
	action_selection.set_action_selection_content(actions[0], actions[1], actions[2])
	action_selection.visible = true




func _ready() -> void:
	_initialize_catalog()
	_initialize_pool()
	var scale=Vector2(0.8,0.8);
	action_selection.scale=(scale);

func _initialize_catalog() -> void:
	catalog.append(load("res://action/building_action/home_action.tres"))
	catalog.append(load("res://action/building_action/wood_cutter_action.tres"))
	catalog.append(load("res://action/building_action/outpost_action.tres"))
	catalog.append(load("res://action/building_action/burner_action.tres"))
	catalog.append(load("res://action/building_action/farm_action.tres"))
	catalog.append(load("res://action/building_action/field_action.tres"))


func _initialize_pool() -> void:
	pool.append(load("res://action/building_action/home_action.tres"))
	pool.append(load("res://action/building_action/wood_cutter_action.tres"))
	pool.append(load("res://action/building_action/outpost_action.tres"))
	pool.append(load("res://action/building_action/burner_action.tres"))
	pool.append(load("res://action/building_action/farm_action.tres"))
	pool.append(load("res://action/building_action/field_action.tres"))

func _get_random_selection() -> Array:
	var pool_copy = pool.duplicate()
	var action_1 = pool_copy.pick_random()
	pool_copy.erase(action_1)
	var action_2 = pool_copy.pick_random()
	pool_copy.erase(action_2)
	var action_3 = pool_copy.pick_random()
	return [action_1, action_2, action_3]

func _on_action_selected(action: Action) -> void:
	action_selection.visible = false
	emit_signal("action_selected", action)
