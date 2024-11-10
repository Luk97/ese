class_name Tile
extends Object

const TILE_WIDTH = 32
const TILE_HEIGHT = 16
const TILE_SIZE = Vector2i(TILE_WIDTH, TILE_HEIGHT)

var name: String
var global_coords: Vector2i
var replaceable: bool

var source_id: int
var atlas_coords: Vector2i

var decorations: Dictionary

func _init(name: String, global_coords: Vector2i, source_id: int, atlas_coords: Vector2i, replaceable: bool, decorations: Dictionary) -> void:
	self.name = name
	self.global_coords = global_coords
	self.source_id = source_id
	self.atlas_coords = atlas_coords
	self.replaceable = replaceable
	self.decorations = decorations
