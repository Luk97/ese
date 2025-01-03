extends Control

var labelFontScaleX=10
var labelFontScaleY=5
@onready var ui: Label = %UI
@onready var graphics: Label = %Graphics
@onready var gamelogic: Label = %Gamelogic

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var thisLabelFontSize=min(get_window().size.x / labelFontScaleX, get_window().size.y / labelFontScaleY)
	ui.add_theme_font_size_override("font_size",thisLabelFontSize)
	graphics.add_theme_font_size_override("font_size",thisLabelFontSize)
	gamelogic.add_theme_font_size_override("font_size",thisLabelFontSize)
