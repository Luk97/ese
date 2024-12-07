extends Node2D

@onready var game_interface: CanvasLayer = %GameInterface
@onready var tile_manager: TileManager = %TileManager
@onready var action_manager: ActionManager = %ActionManager
@onready var preview_manager: PreviewManager = %PreviewManager
@onready var building_manager: BuildingManager = %BuildingManager

func _ready() -> void:
	var headquarter = building_manager.create_building(Building.Type.headquarter)
	var starter_action = action_manager.get_starter_action()

	GameManager.update_rounds()
	GameManager.update_wood(20)
	
	preview_manager.enable_preview(starter_action)
	building_manager.connect("pickup_collected", _on_pickup_collected)

func on_round_finished() -> void:
	print("check")
	

func _on_action_manager_action_selected(action: Action) -> void:
	if action is BuildingAction:
		var wood_change = action.building.cost
		GameManager.update_wood(-wood_change)
	preview_manager.enable_preview(action)

func _on_preview_manager_preview_done() -> void:
	building_manager.update_building_productions()

func _on_pickup_collected() -> void:
	GameManager.update_wood(1)

func _on_game_interface_round_finished() -> void:
	GameManager.update_rounds()
	action_manager.start_action_selection()
