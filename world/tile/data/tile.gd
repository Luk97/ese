class_name Tile
extends Object

var name: String
var global_coords: Vector2i
var replaceable: bool

var source_id: int
var atlas_coords: Vector2i

func _init(name: String, global_coords: Vector2i,  source_id: int, atlas_coords: Vector2i, replaceable: bool) -> void:
	self.name = name
	self.global_coords = global_coords
	self.source_id = source_id
	self.atlas_coords = atlas_coords
	self.replaceable = replaceable
