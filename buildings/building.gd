class_name Building
extends Node

@export var label: String
@export var cost: Dictionary
@export var view_radius: int

@export var product: Dictionary
@export var source_id: int
@export var atlas_coords: Vector2i

func is_valid_placement_tile(type: Types.TileType) -> bool:
	printerr("Building class does not implement the function \"is_valid_placement_tile\"")
	return false
