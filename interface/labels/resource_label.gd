extends NinePatchRect

@export var resource_texture: Texture2D

@onready var label: Label = %Label
@onready var texture_rect: TextureRect = %TextureRect
var labelFontScale=2

func _ready() -> void:
	texture_rect.texture = resource_texture

func set_resource_count(resource_count: int) -> void:
	label.text = str(resource_count)
	
func setFontSize(thisLabelFontSize:int)->void:
	label.add_theme_font_size_override("font_size",thisLabelFontSize)
	
func _process(delta: float) -> void:
	pass

func get_resource_count()->String:
	return label.text
	
func get_Text_Length()->int:
	return label.text.length()
