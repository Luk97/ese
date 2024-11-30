class_name BuildingManager
extends Node2D

signal pickup_collected()

const NAME = "name"
const PLACEMENTS = "placements"
const VIEW_RADIUS = "view_radius"
const SOURCE_ID = "source_id"
const ATLAS_COORDS = "atlas_coords"
const PRODUCABLE_TYPE = "producable_type"
const PRODUCABLE_RATE = "producable_rate"

@onready var tile_manager: TileManager = %TileManager
@export var wood: PackedScene

@export var buildings: Dictionary = {
	Building.Type.headquarter: {
		NAME: "Headquarter",
		PLACEMENTS: [GrassTile],
		VIEW_RADIUS: 2,
		SOURCE_ID: 4,
		ATLAS_COORDS: Vector2i(0, 0),
		PRODUCABLE_TYPE: null,
		PRODUCABLE_RATE: null
	},
	Building.Type.wood_cutter: {
		NAME: "Wood Cutter",
		PLACEMENTS: [ForestTile],
		VIEW_RADIUS: 1,
		SOURCE_ID: 5,
		ATLAS_COORDS: Vector2i(0, 0),
		PRODUCABLE_TYPE: Producable.Type.wood,
		PRODUCABLE_RATE: 3
	}
}



#=================== PUBLIC FUNCTIONS ===================

func create_building(type: Building.Type) -> Building:
	var info = buildings[type]
	var producable: Producable = null
		
	if info[PRODUCABLE_TYPE] != null and info[PRODUCABLE_RATE] != null:
		producable = Producable.new(info[PRODUCABLE_TYPE], info[PRODUCABLE_RATE])
		
	return Building.new(
		info[NAME], type,
		info[PLACEMENTS],
		info[SOURCE_ID],
		info[ATLAS_COORDS],
		info[VIEW_RADIUS],
		producable
	) 

func update_building_productions() -> void:
	var building_tiles = tile_manager.get_building_tiles()
	for tile in building_tiles:
		var producable = tile.building.producable
		if producable != null:
			if producable.rounds_left == 0:
				var scene: PackedScene = load("res://producable/producable.tscn")
				var scene_instance = scene.instantiate()
				scene_instance.position = tile_manager.get_global_coords(tile)
				scene_instance.connect("pickup_collected", _on_pickup_collected)
				add_child(scene_instance)
				producable.rounds_left = producable.rate
			else:
				producable.rounds_left -= 1
			tile_manager.update_producable(producable, tile)


#=================== PRIVATE FUNCTIONS ===================

func _on_pickup_collected() -> void:
	emit_signal("pickup_collected")
