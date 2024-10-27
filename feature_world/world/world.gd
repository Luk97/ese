extends Node2D

@export var debug_log: Label

@export var groundLayer: TileMapLayer
@export var worldLayer: TileMapLayer
@export var skyLayer: TileMapLayer

const main_source := 0
const water = Vector2i(0, 0)
const grass = Vector2i(4, 0)
const forest = Vector2i(5, 0)

const TILE_WIDTH := 32
const TILE_HEIGHT := 16

const CHUNK_SIZE := 8

var current_chunk = Vector2()
var chunks = {}

var chunkManager = ChunkManager.new()

var curser_tile: Vector2
var original_tile: Vector2i = grass

func _ready() -> void:
	set_tile(groundLayer, Vector2i(0, 0), main_source, grass)
	chunkManager.updateChunks(groundLayer)

func _process(_delta: float) -> void:
	chunkManager.updateChunks(groundLayer)
	curser()

func curser():
	var mouse = get_global_mouse_position()
	var tile = _get_tile_of_layer(mouse)
	debug_log.text = "Curser: " + str(tile) + "\n"
	
	if tile != curser_tile:
		if original_tile != null:
			groundLayer.set_cell(curser_tile, main_source, original_tile)
		
		original_tile = groundLayer.get_cell_atlas_coords(tile)
		groundLayer.set_cell(tile, main_source, forest)
		
		curser_tile = tile

func _get_tile_of_layer(pos: Vector2):
	var isometric_width = float((8 * TILE_WIDTH) + (7 * TILE_HEIGHT)) / CHUNK_SIZE
	var isometric_x = (pos.x / isometric_width) + (pos.y / TILE_HEIGHT)
	var isometric_y = (pos.y / TILE_HEIGHT) - (pos.x / isometric_width)
	return Vector2(floor(isometric_x), floor(isometric_y))
	
func set_tile(layer: TileMapLayer, coords: Vector2i, source: int, tile: Vector2):
	if layer.get_cell_atlas_coords(coords) == Vector2i(-1, -1):
		layer.set_cell(coords, source, tile)
