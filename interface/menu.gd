extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	get_tree().call_group("collectables", "queue_free")
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")


func setFontSize(thisLabelFontSize:int)->void:
	add_theme_font_size_override("font_size",thisLabelFontSize)
