extends Control


@onready var ui: Label = %UI
@onready var graphics: Label = %Graphics
@onready var gamelogic: Label = %Gamelogic
@onready var beendenButton: Button = %BeendenButton


var labelFontScale=0.3
var labels=3
var ButtonFontScaleX=30
var ButtonFontScaleY=15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var thisLabelFontSize=min(get_window().size.x * labelFontScale/labels, get_window().size.y  * labelFontScale/labels)
	ui.add_theme_font_size_override("font_size",thisLabelFontSize)
	graphics.add_theme_font_size_override("font_size",thisLabelFontSize)
	gamelogic.add_theme_font_size_override("font_size",thisLabelFontSize)
	var thisButtonFontSize=min(get_window().size.x / ButtonFontScaleX, get_window().size.y / ButtonFontScaleY)
	beendenButton.add_theme_font_size_override("font_size",thisButtonFontSize)
