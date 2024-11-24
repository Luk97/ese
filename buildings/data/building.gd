class_name Building
extends Object

var name: String
var possible_tiles: Array
var view_radius: int

var source_id: int
var atlas_coords: Vector2i

func _init(name: String, possible_tiles: Array, source_id: int, atlas_coords: Vector2i, view_radius: int) -> void:
	self.name = name
	self.possible_tiles = possible_tiles
	self.source_id = source_id
	self.atlas_coords = atlas_coords
	self.view_radius = view_radius
