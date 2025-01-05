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

func place_resources(type: Types.ResourceType, amount: int, tile: Tile) -> void:
	var scene: PackedScene = load("res://resources/resource.tscn")
	var scene_instance = scene.instantiate()
	scene_instance.type = type
	scene_instance.amount = amount
	scene_instance.position = TileManager.get_global_coords(tile)
	scene_instance.connect("resource_collected", _on_resource_collected)
	add_child(scene_instance)

func _on_resource_collected(type: Types.ResourceType, amount: int) -> void:
	update_resource(type, amount)
