class_name Building
extends Resource

@export var name: String
@export var cost: Dictionary
@export var placement_tiles: Array[Tile]
@export var view_radius: int

@export var educts: Dictionary
@export var product: ResourceManager.Type

@export var source_id: int
@export var atlas_coords: Vector2i
