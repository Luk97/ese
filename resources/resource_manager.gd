extends Node

signal wood_updated(int)
signal stone_updated(int)
signal food_updated(int)

var resources:Dictionary = {
	Types.ResourceType.WOOD: GameManager.START_WOOD,
	Types.ResourceType.STONE: GameManager.START_STONE,
	Types.ResourceType.FOOD: GameManager.START_FOOD
}

func initialize_resources() -> void:
	resources[Types.ResourceType.WOOD] = GameManager.START_WOOD
	resources[Types.ResourceType.STONE] = GameManager.START_STONE
	resources[Types.ResourceType.FOOD] = GameManager.START_FOOD
	emit_signal("wood_updated", resources[Types.ResourceType.WOOD])
	emit_signal("stone_updated", resources[Types.ResourceType.STONE])
	emit_signal("food_updated", resources[Types.ResourceType.FOOD])

func building_affordable(building: Building) -> bool:
	for key in building.cost.keys():
		if resources.has(key) and resources[key] < building.cost[key]:
			return false
	return true

func update_resource(type: Types.ResourceType, amount: int) -> void:
	match type:
		Types.ResourceType.WOOD:
			resources[Types.ResourceType.WOOD] += amount
			emit_signal("wood_updated", resources[Types.ResourceType.WOOD])
		Types.ResourceType.CHAR_COAL:
			resources[Types.ResourceType.WOOD] += amount
			emit_signal("wood_updated", resources[Types.ResourceType.WOOD])
		Types.ResourceType.WHEAT:
			resources[Types.ResourceType.FOOD] += amount
			emit_signal("food_updated", resources[Types.ResourceType.FOOD])
		Types.ResourceType.BREAD:
			resources[Types.ResourceType.FOOD] += amount
			emit_signal("food_updated", resources[Types.ResourceType.FOOD])
		Types.ResourceType.PORK:
			resources[Types.ResourceType.FOOD] += amount
			emit_signal("food_updated", resources[Types.ResourceType.FOOD])
		Types.ResourceType.FISH:
			resources[Types.ResourceType.FOOD] += amount
			emit_signal("food_updated", resources[Types.ResourceType.FOOD])
		Types.ResourceType.STONE:
			resources[Types.ResourceType.STONE] += amount
			emit_signal("stone_updated", resources[Types.ResourceType.STONE])
		Types.ResourceType.FOOD:
			resources[Types.ResourceType.FOOD] += amount
			emit_signal("food_updated", resources[Types.ResourceType.FOOD])

func place_resources(resource_type: Types.ResourceType, amount: int, tile: Tile) -> void:
	var scene: PackedScene = load("res://resources/resource.tscn")
	var scene_instance = scene.instantiate() as Pickup
	scene_instance.type = resource_type
	scene_instance.amount = amount
	scene_instance.set_texture(resource_type)
	scene_instance.position = TileManager.get_global_coords(tile)
	scene_instance.connect("resource_collected", _on_resource_collected)
	add_child(scene_instance)

func get_wood_count() -> int:
	return self.resources[Types.ResourceType.WOOD]

func get_food_count() -> int:
	return self.resources[Types.ResourceType.FOOD]

func _on_resource_collected(type: Types.ResourceType, amount: int) -> void:
	update_resource(type, amount)
