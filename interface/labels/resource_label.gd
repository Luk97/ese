extends NinePatchRect

@export var resource_texture: Texture2D

@onready var label: Label = %Label
@onready var texture_rect: TextureRect = %TextureRect

func _ready() -> void:
	texture_rect.texture = resource_texture

func set_resource_count(resource_count: int) -> void:
	label.text = str(resource_count)
