extends Node2D

@onready var ground_layer: TileMapLayer = %GroundLayer

const TILE_SOURCE_ID = 0
const water = Vector2i(0, 0)
const grass = Vector2i(4, 0)
const forest = Vector2i(5, 0)

func get_cursor_tile_coords() -> Vector2i:
	var local_mouse_coords = ground_layer.get_local_mouse_position()
	return ground_layer.local_to_map(local_mouse_coords) + Vector2i(1, 1)

func place_tile(tile_coords: Vector2i, tile_name: String) -> void:
	var texture = _get_tile_texture(tile_name)
	ground_layer.set_cell(tile_coords, TILE_SOURCE_ID, texture)
	
func _get_tile_texture(tile_name: String) -> Vector2i:
	match tile_name:
		"Water":
			return water
		"Grass":
			return grass
		"Forest":
			return forest
		_:
			print("Unknown Tile Type:" + str(tile_name))
			return Vector2i(0, 0)
