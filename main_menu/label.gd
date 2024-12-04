extends Label
var fontScale=10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var thisFontSize = get_window().size.x / fontScale + get_window().size.y / fontScale
	add_theme_font_size_override("font_size",thisFontSize)
	pass
