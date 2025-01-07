extends Button

func _on_pressed() -> void:
	GameManager.show_world = false
	get_tree().change_scene_to_file("res://core/game.tscn")
