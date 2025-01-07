extends NinePatchRect
@onready var label: Label = %RoundCounterLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setFontSize(thisLabelFontSize:int)->void:
	label.add_theme_font_size_override("font_size",thisLabelFontSize)

func get_Text()->String:
	return label.text
	
func get_Text_Length()->int:
	return label.text.length()
