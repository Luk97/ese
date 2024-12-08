extends Node

const WOOD = "Wood"
const WHEAT = "Wheat"

signal wood_updated(int)
signal wheat_updated(int)

enum Type {
	None,
	Wood,
	Wheat
}

var resources:Dictionary = {
	Type.Wood: GameManager.START_WOOD,
	Type.Wheat: GameManager.START_WHEAT
}

func initialize_resources() -> void:
	emit_signal("wood_updated", resources[Type.Wood])
	emit_signal("wheat_updated", resources[Type.Wheat])

func update_wood(change: int) -> void:
	resources[Type.Wood] += change
	emit_signal("wood_updated", resources[Type.Wood])

func update_wheat(change: int) -> void:
	resources[Type.Wheat] += change
	emit_signal("wheat_updated", resources[Type.Wheat])
