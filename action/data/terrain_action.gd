class_name TerrainAction
extends Action

var origins: Array
var destination: Array #this array is a workaround to pass in the type of  the tiles.

var source_id: int
var atlas_coords: Vector2i

func _init(name: String, description: String, preview_image_path: String, origins: Array, destination: Array, source_id: int, atlas_coords: Vector2i) -> void:
	self.origins = origins
	self.destination = destination
	self.source_id = source_id
	self.atlas_coords = atlas_coords
	super(name, description, preview_image_path)
