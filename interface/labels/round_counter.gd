extends NinePatchRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setFontSize(thisLabelFontSize:int)->void:
	add_theme_font_size_override("font_size",thisLabelFontSize)
