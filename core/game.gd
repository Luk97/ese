extends Node2D

@onready var action_manager: ActionManager = %ActionManager
@onready var preview_manager: PreviewManager = %PreviewManager
@onready var game_interface: CanvasLayer = %GameInterface
var is_game_over_executed: bool = false

func _ready() -> void:
	randomize()
	GameManager.initialize_game()
	game_interface.showcase(GameManager.show_world)
	self.is_game_over_executed = false
	game_interface.update_progress_bar_buttons()
	
	if not GameManager.show_world:
		TileManager.initialize_starter_area()
		var starter_action = action_manager.get_starter_action()
		preview_manager.enable_preview(starter_action)

func _on_action_manager_action_selected(action: Action) -> void:
	if action is BuildingAction:
		for key in action.building.cost.keys():
			ResourceManager.update_resource(key, -action.building.cost[key])
	preview_manager.enable_preview(action)

func _on_preview_manager_preview_done() -> void:
	BuildingManager.update_building_productions()

func _on_game_interface_round_finished() -> void:
	GameManager.update_rounds()
	game_interface.decrease_warmth_progress()
	game_interface.decrease_food_progress()
	game_interface.update_progress_bar_buttons()
	action_manager.start_action_selection()


func _on_game_interface_game_over() -> void:
	if not self.is_game_over_executed:
		self.is_game_over_executed = true
		get_tree().change_scene_to_file("res://game_over/gameOverScreen.tscn")
