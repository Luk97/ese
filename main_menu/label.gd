extends Label
var fontScaleX=10
var fontScaleY=5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var thisFontSize = min(get_window().size.x / fontScaleX, get_window().size.y / fontScaleY)
	add_theme_font_size_override("font_size",thisFontSize)
	pass
