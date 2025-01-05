class_name BuildingAction
extends Action

@export var building: Building

func _init(id: String, title: String, description: String, texture: Texture, action_buiding: Building) -> void:
	self.building = action_buiding
	super(id, title, description, texture)

func is_valid_tile(tile: Tile) -> bool:
	return self.building.is_valid_placement_tile(tile.type) and TileManager.is_free_tile(tile.map_coords)
