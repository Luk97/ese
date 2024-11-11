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
	#_place_starter_tile()

#=================== PUBLIC FUNCTIONS ===================

func set_tile(tile: Tile) -> void:
	tiles[tile.global_coords] = tile
	ground_layer.set_cell(tile.global_coords, tile.source_id, tile.atlas_coords)
	var decoration = tile.decoration
	if decoration != null:
		decoration_layer.set_cell(tile.global_coords - Vector2i(1, 1), decoration.source_id, decoration.atlas_coords)

func get_cursor_tile() -> Tile:
	return tiles[ground_layer.get_cursor_tile_coords()]

#=================== PRIVATE FUNCTIONS ===================

func _initialize_starter_area() -> void:
	ground_layer.generate_chunk(SPAWN_RADIUS)

func _place_starter_tile() -> void:
	var land_tile_coords = tiles.keys().filter(_is_grass_tile)
	var starter_tile_index = rng.randi_range(0, land_tile_coords.size() - 1)
	var starter_tile_coords = land_tile_coords[starter_tile_index]
	
	# TODO: this should be handeled by a building manager
	var headquarter = Headquarter.new()
	decoration_layer.set_cell(starter_tile_coords, headquarter.source_id, headquarter.atlas_coords)
	
	_center_camera(starter_tile_coords)

func _is_grass_tile(tile_coords: Vector2i) -> bool:
	var adjusted_coords = tile_coords + Vector2i(1, 1)
	if tiles.has(adjusted_coords):
		return tiles[adjusted_coords] is GrassTile
	else:
		return false

func _center_camera(starter_tile_coords: Vector2i) -> void:
	var global_coords = ground_layer.map_to_local(starter_tile_coords)
	CameraController.center_view(global_coords)
