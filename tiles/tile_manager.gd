class_name TileManager
extends Node2D

@export var tiles: Dictionary = {}
@export var spawn_coords = Vector2i(0, 0)
@export var spawn_radius = 0

@onready var ground_layer: GroundLayer = %GroundLayer
@onready var top_layer: TileMapLayer = %TopLayer
@onready var decoration_manager: DecorationManager = %DecorationManager

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var seed = hash("Lukas") #NOTE: this is temporary and should be seleceted by the user

#=================== PUBLIC FUNCTIONS ===================

func place_tile(tile: Tile) -> void:
	tiles[tile.map_coords] = tile
	ground_layer.set_cell(tile.map_coords, tile.source_id, tile.atlas_coords)
	
	var decoration = decoration_manager.get_random_decoration(tile)
	if (decoration != null):
		tiles[tile.map_coords].decoration = decoration
		top_layer.set_cell(tile.map_coords - Vector2i(1, 1), decoration.source_id, decoration.atlas_coords)

func place_building(building: Building, coords: Vector2i) -> void:
	if tiles.has(coords):
		tiles[coords].building = building
		top_layer.set_cell(coords - Vector2i(1, 1), building.source_id, building.atlas_coords)
		ground_layer.generate_tiles(coords, building.view_radius)

func get_cursor_tile() -> Tile:
	var coords = ground_layer.get_cursor_tile_coords()
	if tiles.has(coords):
		return tiles[coords]
	return null

func get_building_tiles() -> Array:
	return tiles.values().filter(_has_building)

func get_map_coords(tile: Tile) -> Vector2i:
	if tiles.has(tile.map_coords):
		return ground_layer.map_to_local(tile.map_coords - Vector2i(1, 1))
	return Vector2i(-1, -1)


#=================== PRIVATE FUNCTIONS ===================

func _ready() -> void:
	_initialize_random()
	_initialize_starter_area()

func _initialize_random() -> void:
	rng.seed = seed
	ground_layer.altitude_noise.seed = rng.randi()
	ground_layer.temperature_noise.seed = rng.randi()
	ground_layer.moisture_noise.seed = rng.randi()

func _initialize_starter_area() -> void:
	ground_layer.generate_tiles(spawn_coords, spawn_radius)

func _has_building(tile: Tile) -> bool:
	return tile.building != null
