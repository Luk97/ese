class_name TerrainAction
extends Action

@export var origins: Array[Types.TileType]
@export var destination: Types.TileType
@export var earnings: Dictionary
@export var source_id: int
@export var atlas_coords: Vector2i

func _init(id: String, title: String, description: String, texture: Texture, origins: Array[Types.TileType], destination: Types.TileType, earnings: Dictionary, source_id: int = -1, atlas_coords: Vector2i = Vector2i(-1, -1)) -> void:
	self.origins = origins
	self.destination = destination
	self.earnings = earnings
	self.source_id = source_id
	self.atlas_coords = atlas_coords
	super(id, title, description, texture)

func is_valid_tile(tile: Tile) -> bool:
	return tile.type in self.origins and tile.building == null
