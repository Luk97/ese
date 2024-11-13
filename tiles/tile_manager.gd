class_name TileManager
extends Node2D

@onready var ground_layer: GroundLayer = %GroundLayer
@onready var decoration_layer: DecorationLayer = %DecorationLayer
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

const SEED = 123
const SPAWN_RADIUS = Vector2i(10, 10)

var tiles: Dictionary = {}

func _ready() -> void:
	_initialize_starter_area()

#=================== PUBLIC FUNCTIONS ===================

func set_tile(tile: Tile) -> void:
	tiles[tile.global_coords] = tile
	ground_layer.set_cell(tile.global_coords, tile.source_id, tile.atlas_coords)
	var decoration = tile.decoration
	if decoration != null:
		decoration_layer.set_cell(tile.global_coords - Vector2i(1, 1), decoration.source_id, decoration.atlas_coords)

func set_building(building: Building, coords: Vector2i) -> void:
	if tiles.has(coords):
		decoration_layer.set_cell(coords - Vector2i(1, 1), building.source_id, building.atlas_coords)
func get_cursor_tile() -> Tile:
	return tiles[ground_layer.get_cursor_tile_coords()]

#=================== PRIVATE FUNCTIONS ===================

func _initialize_starter_area() -> void:
	ground_layer.generate_chunk(SPAWN_RADIUS)
