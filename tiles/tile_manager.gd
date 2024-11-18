class_name TileManager
extends Node2D

@onready var ground_layer: GroundLayer = %GroundLayer
@onready var decoration_manager: DecorationManager = %DecorationManager
@onready var top_layer: TileMapLayer = %TopLayer

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

const SEED = 123
const SPAWN_RADIUS = 4

var tiles: Dictionary = {}

func _ready() -> void:
	_initialize_starter_area()


#=================== PUBLIC FUNCTIONS ===================

func place_tile(tile: Tile) -> void:
	tiles[tile.global_coords] = tile
	ground_layer.set_cell(tile.global_coords, tile.source_id, tile.atlas_coords)
	top_layer.erase_cell(tile.global_coords - Vector2i(1, 1))
	var decoration = decoration_manager.get_random_decoration(tile)
	if (decoration != null):
		tiles[tile.global_coords].decoration = decoration
		top_layer.set_cell(tile.global_coords - Vector2i(1, 1), decoration.source_id, decoration.atlas_coords)

func place_building(building: Building, coords: Vector2i) -> void:
	if tiles.has(coords):
		tiles[coords].building = building
		top_layer.set_cell(coords - Vector2i(1, 1), building.source_id, building.atlas_coords)
		ground_layer.generate_tiles(coords, 2)

func get_cursor_tile() -> Tile:
	var coords = ground_layer.get_cursor_tile_coords()
	if tiles.has(coords):
		return tiles[coords]
	return null

func get_building_tiles() -> Array:
	return tiles.values().filter(_has_building)

func get_global_coords(tile: Tile) -> Vector2:
	if tiles.has(tile.global_coords):
		return ground_layer.map_to_local(tile.global_coords - Vector2i(1, 1))
	return Vector2(-1, -1)

#=================== PRIVATE FUNCTIONS ===================

func _initialize_starter_area() -> void:
	ground_layer.generate_tiles(Vector2i(0, 0), SPAWN_RADIUS)

func _has_building(tile: Tile) -> bool:
	return tile.building != null
