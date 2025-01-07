extends CanvasLayer

@onready var gameOverLabel: Label = %gameOverTitle
@onready var gameOverMessage: Label = %gameOverMessage
@onready var buttonContainer: HBoxContainer=%buttonContainer
@onready var newGameButton: Button=%NewGame
@onready var menuButton: Button=%Menu

var buttonScaleXY=3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
