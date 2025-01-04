class_name Tile
extends Node

@export var type: Types.TileType
@export var map_coords: Vector2i
@export var source_id: int
@export var atlas_coords: Vector2i
@export var decoration: Decoration = null
@export var building: Building = null

const TILE_WIDTH = 32
const TILE_HEIGHT = 16

func _init(type: Types.TileType, map_coords: Vector2i) -> void:
	self.type = type
	self.map_coords = map_coords
	setTextureFromType(type)

func setTextureFromType(type: Types.TileType) -> void:
	match (type):
		Types.TileType.WATER:
			self.source_id = 0
			self.atlas_coords = Vector2i(0, 0)
		Types.TileType.GRASS:
			self.source_id = 1
			self.atlas_coords = Vector2i(0, 0)
		Types.TileType.FOREST:
			self.source_id = 1
			self.atlas_coords = Vector2i(1, 0)
		Types.TileType.BEACH:
			self.source_id = 3
			self.atlas_coords = Vector2i(0, 0)
