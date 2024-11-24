class_name Tile
extends Object

const TILE_WIDTH = 32
const TILE_HEIGHT = 16
const TILE_SIZE = Vector2i(TILE_WIDTH, TILE_HEIGHT)

var name: String
var map_coords: Vector2i

var source_id: int
var atlas_coords: Vector2i

var decoration: Decoration = null
var building: Building = null

func _init(name: String, map_coords: Vector2i, source_id: int, atlas_coords: Vector2i) -> void:
	self.name = name
	self.map_coords = map_coords
	self.source_id = source_id
	self.atlas_coords = atlas_coords
