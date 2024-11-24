class_name ActionManager
extends Node2D

@onready var action_selection: ActionSelection = %ActionSelection

signal action_selected(action: Action)

var total_actions: Dictionary = {
	"headquarter": BuildingAction.new(
		"This has no further function yet.",
		"res://assets/Home.png",
		Headquarter.new()
	),
	"wood_cutter": BuildingAction.new(
		"This produces wood each round.",
		"res://assets/Woodcutter.png",
		WoodCutter.new()
	),
	"grub_forest": TerrainAction.new(
		"Grub Forest",
		"Remove one forest tile. It becomes a grass tile.",
		"res://assets/axe.png",
		[ForestTile],
		[GrassTile],
		3,
		Vector2i(0, 0)
	)
}

var pool: Dictionary = {}


#=================== PUBLIC FUNCTIONS ===================

func get_starter_action() -> Action:
	return total_actions["headquarter"]

func start_action_selection() -> void:
	action_selection.visible = true


#=================== PRIVATE FUNCTIONS ===================

func _ready() -> void:
	_initialize_action_pool()
	action_selection.visible = false
	var action_1 = pool["headquarter"]
	var action_2 = pool["wood_cutter"]
	var action_3 = pool["grub_forest"]
	action_selection.set_action_selection_content(action_1, action_2, action_3)

func _initialize_action_pool():
	pool["headquarter"] = total_actions["headquarter"]
	pool["wood_cutter"] = total_actions["wood_cutter"]
	pool["grub_forest"] = total_actions["grub_forest"]

func _on_action_selection_action_selected(action: Action) -> void:
	action_selection.visible = false
	emit_signal("action_selected", action)
