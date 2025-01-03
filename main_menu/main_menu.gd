extends Control
#var thisFont = preload("res://assets/PixelArt.ttf")
@onready var title: Label = %Titel
@onready var startGame: Button = %StartGame
@onready var speichern: Button = %Speichern
@onready var showcase: Button = %Showcase
@onready var credits: Button = %Credits
@onready var beendenButton: Button = %BeendenButton


var fontScale=70
var titleFontScaleX=10
var titleFontScaleY=5
var ButtonFontScaleX=30
var ButtonFontScaleY=15



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	pass



func _process(delta: float) -> void:
	var thisTitleFontSize = min(get_window().size.x / titleFontScaleX, get_window().size.y / titleFontScaleY)
	title.add_theme_font_size_override("font_size",thisTitleFontSize)
	var thisButtonFontSize=min(get_window().size.x / ButtonFontScaleX, get_window().size.y / ButtonFontScaleY)
	startGame.add_theme_font_size_override("font_size",thisButtonFontSize)
	speichern.add_theme_font_size_override("font_size",thisButtonFontSize)
	showcase.add_theme_font_size_override("font_size",thisButtonFontSize)
	credits.add_theme_font_size_override("font_size",thisButtonFontSize)
	beendenButton.add_theme_font_size_override("font_size",thisButtonFontSize)
