class_name Pickup
extends Node2D

var type: Types.ResourceType
var amount: int

signal resource_collected(type, amount)

func set_texture(resource_type: Types.ResourceType) -> void:
	var sprite = get_node("Sprite")
	match resource_type:
		Types.ResourceType.WOOD:
			sprite.texture = load("res://assets/items/wood.png")
		Types.ResourceType.CHAR_COAL:
			sprite.texture = load("res://assets/items/charcoal.png")
		Types.ResourceType.WHEAT:
			sprite.texture = load("res://assets/items/Wheat.png")
		Types.ResourceType.BREAD:
			sprite.texture = load("res://assets/items/bread.png")
		Types.ResourceType.PORK:
			sprite.texture = load("res://assets/items/bread.png")
		Types.ResourceType.FISH:
			sprite.texture = load("res://assets/items/fish.png")
		Types.ResourceType.STONE:
			sprite.texture = load("res://assets/items/Stone.png")
		_:
			printerr("cannot find texture for resource type: ", str(resource_type))

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouse and event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed():
		emit_signal("resource_collected", self.type, self.amount)
		queue_free()
