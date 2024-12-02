class_name Building
extends Object

enum Type {
	headquarter,
	wood_cutter
}

var name: String
var type: Type
var possible_tiles: Array
var cost: int
var view_radius: int
var producable: Producable = null


var source_id: int
var atlas_coords: Vector2i

func _init(name: String, type: Type, possible_tiles: Array, cost: int, source_id: int, atlas_coords: Vector2i, view_radius: int, producable: Producable = null) -> void:
	self.name = name
	self.type = type
	self.possible_tiles = possible_tiles
	self.cost = cost
	self.source_id = source_id
	self.atlas_coords = atlas_coords
	self.view_radius = view_radius
	self.producable = producable
