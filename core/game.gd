extends Node2D

@export var rounds: int = 1
@export var wood_count: int = 0

@onready var game_interface: CanvasLayer = %GameInterface
@onready var tile_manager: TileManager = %TileManager
@onready var action_manager: ActionManager = %ActionManager
@onready var preview_manager: PreviewManager = %PreviewManager
@onready var building_manager: BuildingManager = %BuildingManager

func _ready() -> void:
	var headquarter = building_manager.create_building(Building.Type.headquarter)
	var starter_action = action_manager.get_starter_action()
	preview_manager.enable_preview(starter_action)
	building_manager.connect("pickup_collected", _on_pickup_collected)

func _on_round_finished() -> void:
	rounds += 1
	game_interface.set_round_count(rounds)
	action_manager.start_action_selection()

func _on_action_manager_action_selected(action: Action) -> void:
	preview_manager.enable_preview(action)

func _on_preview_manager_preview_done() -> void:
	building_manager.update_building_productions()

func _on_pickup_collected() -> void:
	wood_count += 1
	game_interface.set_wood_count(wood_count)
