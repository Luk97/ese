class_name BuildingManager
extends Node2D

@export var wood: PackedScene

@onready var tile_manager: TileManager = %TileManager

signal pickup_collected()

func update_pickups() -> void:
	var building_tiles = tile_manager.get_building_tiles()
	for tile in building_tiles:
		if tile.building is WoodCutter:
			var coords = tile_manager.get_global_coords(tile)
			if coords != Vector2(-1, -1):
				var scene_instance = wood.instantiate()
				scene_instance.position = coords
				scene_instance.connect("pickup_collected", _on_pickup_collected)
				add_child(scene_instance)
				
func _on_pickup_collected() -> void:
	emit_signal("pickup_collected")
