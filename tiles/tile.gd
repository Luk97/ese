class_name Tile
extends Node

@export var type: Types.TileType
@export var map_coords: Vector2i
@export var source_id: int = -1
@export var atlas_coords: Vector2i = Vector2i(-1,  -1)
@export var decoration: Decoration = null
@export var building: Building = null

const TILE_WIDTH = 32
const TILE_HEIGHT = 16

func _init(tile_type: Types.TileType, coords: Vector2i) -> void:
	self.type = tile_type
	self.map_coords = coords
	setTextureFromType(tile_type)

func setTextureFromType(tile_type: Types.TileType) -> void:
	match tile_type:
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
		Types.TileType.MOUNTAIN:
			self.source_id = 2
			self.atlas_coords = Vector2i(0, 0)
		Types.TileType.DESERT:
			self.source_id = 3
			self.atlas_coords = Vector2i(0, 0)
		_:
			printerr("undefined texture for this tile type: ", tile_type)
