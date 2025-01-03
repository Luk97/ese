extends NinePatchRect

@export var resource_texture: Texture2D

@onready var label: Label = %Label
@onready var texture_rect: TextureRect = %TextureRect
var labelFontScaleX=20
var labelFontScaleY=10

func _ready() -> void:
	texture_rect.texture = resource_texture

func set_resource_count(resource_count: int) -> void:
	label.text = str(resource_count)

func _process(delta: float) -> void:
	var thisLabelFontSize=min(get_window().size.x / labelFontScaleX, get_window().size.y / labelFontScaleY)
	label.add_theme_font_size_override("font_size",thisLabelFontSize)
