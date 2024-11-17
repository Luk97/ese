extends Node2D

@export var rounds: int = 1

@onready var game_interface: CanvasLayer = %GameInterface
@onready var tile_manager: TileManager = %TileManager
@onready var action_manager: ActionManager = %ActionManager
@onready var preview_manager: PreviewManager = %PreviewManager


func _ready() -> void:
	var headquarter = Headquarter.new()
	var starter_action = BuildingAction.new(headquarter)
	preview_manager.enable_preview(starter_action)

func _on_round_finished() -> void:
	rounds += 1
	game_interface.set_round_count(rounds)
	action_manager.start_action_selection()

func _on_action_manager_action_selected(action: Action) -> void:
	preview_manager.enable_preview(action)


func _on_preview_manager_preview_done() -> void:
	pass # Replace with function body.
