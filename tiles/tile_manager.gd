extends Node2D

@export var tiles: Dictionary = {}

@onready var ground_layer: GroundLayer = %GroundLayer
@onready var top_layer: TileMapLayer = %TopLayer

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var seed = hash("Lukas") #NOTE: this is temporary and should be seleceted by the user



#=================== PUBLIC FUNCTIONS ===================

func get_tile(coords: Vector2i) -> Tile:
	return tiles[coords] if tiles.has(coords) else null

func upsert_tile(tile: Tile) -> void:
	tiles[tile.map_coords] = tile
	ground_layer.set_cell(tile.map_coords, tile.source_id, tile.atlas_coords)
	if tile.building != null:
		top_layer.set_cell(tile.map_coords - Vector2i(1, 1), tile.building.source_id, tile.building.atlas_coords)
		ground_layer.generate_tiles(tile.map_coords, tile.building.view_radius)
	elif tile.decoration != null:
		top_layer.set_cell(tile.map_coords - Vector2i(1, 1), tile.decoration.source_id, tile.decoration.atlas_coords)
	

func get_cursor_tile() -> Tile:
	var coords = ground_layer.get_cursor_tile_coords()
	return tiles[coords] if tiles.has(coords) else null




func place_building(building: Building, coords: Vector2i) -> void:
	if tiles.has(coords):
		tiles[coords].building = building
		top_layer.set_cell(coords - Vector2i(1, 1), building.source_id, building.atlas_coords)
		ground_layer.generate_tiles(coords, building.view_radius)

func update_producable(producable: Producable, tile: Tile) -> void:
	if tiles.has(tile.map_coords) and tiles[tile.map_coords].building != null:
		tiles[tile.map_coords].building.producable = producable



func get_building_tiles() -> Array:
	return tiles.values().filter(_has_building)

func get_global_coords(tile: Tile) -> Vector2i:
	if tiles.has(tile.map_coords):
		return ground_layer.map_to_local(tile.map_coords - Vector2i(1, 1))
	return Vector2i(-1, -1)


#=================== PRIVATE FUNCTIONS ===================

func _ready() -> void:
	_initialize_random()
	_initialize_starter_area()

func _initialize_random() -> void:
	#NOTE: this is disabled for random worlds each game start
	#rng.seed = seed
	ground_layer.altitude_noise.seed = rng.randi()
	ground_layer.temperature_noise.seed = rng.randi()
	ground_layer.moisture_noise.seed = rng.randi()

func _initialize_starter_area() -> void:
	# TODO: this should find a valid starting point
	ground_layer.generate_tiles(Vector2i(0, 0), 0)

func _has_building(tile: Tile) -> bool:
	return tile.building != null
