extends Node2D
class_name Chunk

const TileType = preload("../tile/tile_type.gd").Type

func _init(chunk_coords: Vector2, layer: TileMapLayer):
	pass

func set_tile(tile: Tile):
	pass

func get_tile(tile_coords: Vector2i):
	pass
