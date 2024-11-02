extends Node2D
class_name Tile

const TileType = preload("tile_type.gd")

var type: TileType.Type
var global_coords: Vector2i
var local_coords: Vector2i

func _init(tile_type: TileType.Type, global_coords: Vector2i, local_coords: Vector2i):
	type = tile_type
	global_coords = global_coords
	local_coords = local_coords
