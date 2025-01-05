extends Node2D

@export var tiles: Dictionary = {}

@onready var ground_layer: GroundLayer = %GroundLayer
@onready var top_layer: TileMapLayer = %TopLayer


#=================== PUBLIC FUNCTIONS ===================

func get_tile(coords: Vector2i) -> Tile:
	return tiles[coords] if tiles.has(coords) else null

func place_tile(tile: Tile) -> void:
	tiles[tile.map_coords] = tile
	ground_layer.set_cell(tile.map_coords, tile.source_id, tile.atlas_coords)
	
	if tile.decoration != null:
		top_layer.set_cell(tile.map_coords - Vector2i(1, 1), tile.decoration.source_id, tile.decoration.atlas_coords)
	else:
		var decoration = DecorationManager.get_random_decoration(tile.type)
		if decoration != null:
			tiles[tile.map_coords].decoration = decoration
			top_layer.set_cell(tile.map_coords - Vector2i(1, 1), tile.decoration.source_id, tile.decoration.atlas_coords)

func get_cursor_tile() -> Tile:
	var coords = ground_layer.get_cursor_tile_coords()
	return tiles[coords] if tiles.has(coords) else null

func is_free_tile(coords: Vector2i) -> bool:
	return tiles[coords].building == null

func place_building(building: Building, coords: Vector2i) -> void:
	for key in building.cost.keys():
		ResourceManager.update_resource(key, -building.cost[key])
	tiles[coords].building = building
	top_layer.set_cell(coords - Vector2i(1, 1), building.source_id, building.atlas_coords)
	ground_layer.generate_tiles(coords, building.view_radius)

func get_building_tiles() -> Array:
	return tiles.values().filter(_has_building)

func get_global_coords(tile: Tile) -> Vector2i:
	if tiles.has(tile.map_coords):
		return ground_layer.map_to_local(tile.map_coords - Vector2i(1, 1))
	return Vector2i(-1, -1)


#=================== PRIVATE FUNCTIONS ===================

func _ready() -> void:
	_initialize_starter_area()

func _initialize_starter_area() -> void:
	var coords = ground_layer.place_starter_tile()
	CameraController.center_view(ground_layer.map_to_local(coords))

func _has_building(tile: Tile) -> bool:
	return tile.building != null
