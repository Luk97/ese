extends Node

signal pickup_collected()

@export var wood: PackedScene

#=================== PUBLIC FUNCTIONS ===================

func update_building_productions() -> void:
	var building_tiles = TileManager.get_building_tiles()
	for tile in building_tiles:
		var product: Dictionary = tile.building.product
		if not product.is_empty():
			if product[Constants.PRODUCT_UNTIL_YIELD] == 0:
				product[Constants.PRODUCT_UNTIL_YIELD] = product[Constants.PRODUCT_RATE]
				var scene: PackedScene = load("res://producable/producable.tscn")
				var scene_instance = scene.instantiate()
				scene_instance.position = TileManager.get_global_coords(tile)
				scene_instance.connect("pickup_collected", _on_pickup_collected)
				add_child(scene_instance)
			else:
				product[Constants.PRODUCT_UNTIL_YIELD] -= 1


#=================== PRIVATE FUNCTIONS ===================

func _on_pickup_collected() -> void:
	emit_signal("pickup_collected")
