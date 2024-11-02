extends Node2D
class_name ChunkManager

@export var terrain_layer: TileMapLayer

const TileType = preload("../tile/tile_type.gd")

const TILE_SOURCE_ID = 0
const water = Vector2i(0, 0)
const grass = Vector2i(4, 0)
const forest = Vector2i(5, 0)

var chunks = {}

func _ready() -> void:
	terrain_layer = get_node("TerrainLayer")

func get_cursor_tile_coords() -> Vector2i:
	var local_mouse_coords = terrain_layer.get_local_mouse_position()
	return terrain_layer.local_to_map(local_mouse_coords) + Vector2i(1, 1)

func set_tile(global_tile_coords, tile_type: TileType.Type) -> void:
	var texture = _get_tile_texture(tile_type)
	terrain_layer.set_cell(global_tile_coords, TILE_SOURCE_ID, texture)

func erase_tile(global_tile_coords) -> void:
	terrain_layer.erase_cell(global_tile_coords)

func is_empty_tile(global_tile_coords: Vector2i) -> bool:
	return terrain_layer.get_cell_atlas_coords(global_tile_coords) == Vector2i(-1, -1)
	
func _get_tile_texture(tile_type: TileType.Type) -> Vector2i:
	match tile_type:
		TileType.WATER:
			return Vector2i(0, 0)
		TileType.GRASS:
			return Vector2i(4, 0)
		TileType.FOREST:
			return Vector2i(5, 0)
		_:
			print("Unknown Tile Type:" + str(tile_type))
			return Vector2i(0, 0)
