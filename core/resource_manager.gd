extends Node

signal wood_updated(int)
signal wheat_updated(int)

var resources:Dictionary = {
	Types.ResourceType.WOOD: GameManager.START_WOOD,
	Types.ResourceType.WHEAT: GameManager.START_WHEAT
}

func initialize_resources() -> void:
	emit_signal("wood_updated", resources[Types.ResourceType.WOOD])
	emit_signal("wheat_updated", resources[Types.ResourceType.WHEAT])

func update_resource(type: Types.ResourceType, amount: int) -> void:
	resources[type] += amount
	match type:
		Types.ResourceType.WOOD:
			emit_signal("wood_updated", resources[Types.ResourceType.WOOD])
		Types.ResourceType.WHEAT:
			emit_signal("wheat_updated", resources[Types.ResourceType.WHEAT])
