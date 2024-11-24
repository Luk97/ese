class_name TerrainAction
extends Action

var source_tiles: Array
var destination_tile: Array #this array is a workaround to pass in the type of  the tiles.

var source_id: int
var atlas_coords: Vector2i

func _init(name: String, description: String, preview_image_path: String, source_tiles: Array, destination_tile: Array, source_id: int, atlas_coords: Vector2i) -> void:
	self.source_tiles = [ForestTile]
	self.destination_tile = [GrassTile]
	self.source_id = 3
	self.atlas_coords = Vector2i(0, 0)
	super(name, description, preview_image_path)
