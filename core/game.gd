extends Node2D

@onready var action_manager: ActionManager = %ActionManager
@onready var preview_manager: PreviewManager = %PreviewManager
@onready var building_manager: BuildingManager = %BuildingManager

func _ready() -> void:
	GameManager.initialize_game()
	
	var starter_action = action_manager.get_starter_action()
	preview_manager.enable_preview(starter_action)
	building_manager.connect("pickup_collected", _on_pickup_collected)

func _on_action_manager_action_selected(action: Action) -> void:
	preview_manager.enable_preview(action)

func _on_preview_manager_preview_done() -> void:
	building_manager.update_building_productions()

func _on_pickup_collected() -> void:
	ResourceManager.update_resource(Types.ResourceType.WOOD, 1)

func _on_game_interface_round_finished() -> void:
	GameManager.update_rounds()
	action_manager.start_action_selection()
