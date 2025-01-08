extends Control
#var thisFont = preload("res://assets/PixelArt.ttf")
@onready var title: Label = %Titel
@onready var startGame: Button = %StartGame
@onready var speichern: Button = %Speichern
@onready var showcase: Button = %Showcase
@onready var credits: Button = %Credits
@onready var beendenButton: Button = %BeendenButton
@onready var menuContainer: MarginContainer = %MenuContainer

var fontScale=70
var titleFontScale=0.15
var ButtonScale=0.4
var buttons=4

func _process(delta: float) -> void:
	var thisTitleFontSize = min(get_window().size.x * titleFontScale*1.3, get_window().size.y * titleFontScale)
	title.add_theme_font_size_override("font_size",thisTitleFontSize)
	
	var thisButtonFontSize=min(get_window().size.x * ButtonScale/buttons, get_window().size.y * ButtonScale/buttons)
	startGame.add_theme_font_size_override("font_size",thisButtonFontSize)
	speichern.add_theme_font_size_override("font_size",thisButtonFontSize)
	showcase.add_theme_font_size_override("font_size",thisButtonFontSize)
	credits.add_theme_font_size_override("font_size",thisButtonFontSize)
	beendenButton.add_theme_font_size_override("font_size",thisButtonFontSize)


func _on_showcase_pressed() -> void:
	GameManager.show_world = true
	get_tree().change_scene_to_file("res://core/game.tscn")
