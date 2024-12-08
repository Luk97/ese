class_name BuildingManager
extends Node2D

signal pickup_collected()

@onready var tile_manager: TileManager = %TileManager
@export var wood: PackedScene

#=================== PUBLIC FUNCTIONS ===================

func update_building_productions() -> void:
	return
	var building_tiles = tile_manager.get_building_tiles()
	for tile in building_tiles:
		var producable = tile.building.producable
		if producable != null:
			if producable.rounds_left == 0:
				var scene: PackedScene = load("res://producable/producable.tscn")
				var scene_instance = scene.instantiate()
				scene_instance.position = tile_manager.get_global_coords(tile)
				scene_instance.connect("pickup_collected", _on_pickup_collected)
				add_child(scene_instance)
				producable.rounds_left = producable.rate
			else:
				producable.rounds_left -= 1
			tile_manager.update_producable(producable, tile)


#=================== PRIVATE FUNCTIONS ===================

func _on_pickup_collected() -> void:
	emit_signal("pickup_collected")
