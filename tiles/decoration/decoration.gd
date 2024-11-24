class_name Decoration
extends Object

var source_id: int
var atlas_coords: Vector2i

func _init(source_id: int, atlas_coords: Vector2i) -> void:
	self.source_id = source_id
	self.atlas_coords = atlas_coords
