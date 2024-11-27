class_name BuildingManager
extends Node2D

signal pickup_collected()

const NAME = "name"
const PLACEMENTS = "placements"
const VIEW_RADIUS = "view_radius"
const SOURCE_ID = "source_id"
const ATLAS_COORDS = "atlas_coords"

@onready var tile_manager: TileManager = %TileManager
@export var wood: PackedScene

@export var buildings: Dictionary = {
	Building.Type.headquarter: {
		NAME: "Headquarter",
		PLACEMENTS: [GrassTile],
		VIEW_RADIUS: 2,
		SOURCE_ID: 4,
		ATLAS_COORDS: Vector2i(0, 0)
	},
	Building.Type.wood_cutter: {
		NAME: "Wood Cutter",
		PLACEMENTS: [ForestTile],
		VIEW_RADIUS: 1,
		SOURCE_ID: 5,
		ATLAS_COORDS: Vector2i(0, 0)
	}
}



#=================== PUBLIC FUNCTIONS ===================

func get_building(type: Building.Type) -> Building:
	if buildings.has(type):
		var b = buildings[type]
		return Building.new(b[NAME], type, b[PLACEMENTS], b[SOURCE_ID], b[ATLAS_COORDS], b[VIEW_RADIUS])
	return null

func update_pickups() -> void:
	var building_tiles = tile_manager.get_building_tiles()
	for tile in building_tiles:
		if tile.building.type == Building.Type.wood_cutter:
			var coords = tile_manager.get_map_coords(tile)
			if coords != Vector2i(-1, -1):
				var scene_instance = wood.instantiate()
				scene_instance.position = coords
				scene_instance.connect("pickup_collected", _on_pickup_collected)
				add_child(scene_instance)


#=================== PRIVATE FUNCTIONS ===================

func _on_pickup_collected() -> void:
	emit_signal("pickup_collected")
