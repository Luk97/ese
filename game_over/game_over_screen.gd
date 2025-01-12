extends CanvasLayer

@onready var gameOverLabel: Label = %gameOverTitle
@onready var gameOverMessage: Label = %gameOverMessage
@onready var buttonContainer: HBoxContainer=%buttonContainer
@onready var newGameButton: Button=%NewGame
@onready var menuButton: Button=%Menu

var titleFontScale=0.5
var buttonFontScale=0.1
var buttonScaleXY=3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var windowXY=get_window().size.x /get_window().size.y
	var thisTitleFontSize = min(get_window().size.x * titleFontScale/windowXY*0.33, get_window().size.y * titleFontScale)
	gameOverLabel.add_theme_font_size_override("font_size",thisTitleFontSize)
	
	var thisButtonsFontSize = min(get_window().size.x * buttonFontScale/windowXY, get_window().size.y * buttonFontScale)
	var buttonx=max(newGameButton.size.x,menuButton.size.x)
	var buttony=max(newGameButton.size.y,menuButton.size.y)
	newGameButton.size=Vector2(buttonx,buttony)
	
	menuButton.size=Vector2(buttonx,buttony)
	newGameButton.add_theme_font_size_override("font_size",thisButtonsFontSize)
	menuButton.add_theme_font_size_override("font_size",thisButtonsFontSize)
	gameOverMessage.add_theme_font_size_override("font_size",thisButtonsFontSize/1.5)
	gameOverMessage.text = str("You survived ", GameManager.rounds, " rounds. Congratulations!")
