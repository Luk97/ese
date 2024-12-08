class_name Tile
extends Resource

@export var name: String
@export var source_id: int
@export var atlas_coords: Vector2i

var map_coords: Vector2i
var decoration: Decoration = null
var building: Building = null

const TILE_WIDTH = 32
const TILE_HEIGHT = 16
