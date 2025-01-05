class_name Pickup
extends Node2D

var type: Types.ResourceType
var amount: int

signal resource_collected(type, amount)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouse and event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed():
		emit_signal("resource_collected", self.type, self.amount)
		queue_free()
