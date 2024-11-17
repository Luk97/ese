class_name ActionManager
extends Node2D

@onready var action_selection: CanvasLayer = $ActionSelection

signal action_selected(action: Action)

var pool: Dictionary = {}

func _ready() -> void:
	_initialize_action_pool()
	action_selection.visible = false


#=================== PUBLIC FUNCTIONS ===================

func start_action_selection() -> void:
	action_selection.visible = true


#=================== PRIVATE FUNCTIONS ===================

func _initialize_action_pool():
	var headquarter_action = BuildingAction.new(Headquarter.new())
	var wood_cutter_action = BuildingAction.new(WoodCutter.new())
	var forest_grub_action = TerrainAction.new()
	pool[headquarter_action.name] = headquarter_action
	pool[wood_cutter_action.name] = wood_cutter_action
	pool[forest_grub_action.name] = forest_grub_action


func _on_button_pressed() -> void:
	action_selection.visible = false
	emit_signal("action_selected", pool["Headquarter"])


func _on_button_2_pressed() -> void:
	action_selection.visible = false
	emit_signal("action_selected", pool["Wood Cutter"])


func _on_button_3_pressed() -> void:
	action_selection.visible = false
	emit_signal("action_selected", pool["Grub Forest"])
