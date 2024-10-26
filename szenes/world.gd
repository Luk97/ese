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
const RADIUS := 8

var current_chunk = Vector2()
var chunks = {}

var chunk_data = {
	"position": Vector2(),
	"tiles": {}
}

var curser_tile: Vector2
var original_tile: Vector2i = grass

func _ready() -> void:
	set_tile(groundLayer, Vector2i(0, 0), main_source, grass)
	update_chunks(get_current_chunk())

func _process(_delta: float) -> void:
	var chunk = get_current_chunk()
	debug_log.text = "Chunk: " + str(chunk) + "\n"
	if current_chunk != chunk:
		current_chunk = chunk
		update_chunks(chunk)
	curser()

func get_current_chunk() -> Vector2:
	var camera = get_viewport().get_camera_2d().global_position
	var tile = get_tile_of_layer(camera)
	return Vector2(floor(tile.x / CHUNK_SIZE), floor(tile.y / CHUNK_SIZE))

func update_chunks(center: Vector2):
	for y in range(center.y - RADIUS, center.y + RADIUS + 1):
		for x in range(center.x - RADIUS, center.x + RADIUS + 1):
			var chunk = Vector2(x, y)
			if not chunks.has(chunk):
				load_chunk(chunk)
				save_chunk(chunk)
	
	for chunk in chunks.keys():
		if RADIUS < chunk.distance_to(center):
			unload_chunk(chunk)

func load_chunk(chunk):
	var key = str(chunk)
	if chunk_data.has(key):
		for tile_pos in chunk_data[key]["tiles"].keys():
			var tile = chunk_data[key]["tiles"][tile_pos]
			var tile_position = Vector2i(chunk.x * CHUNK_SIZE + tile_pos.x, chunk.y * CHUNK_SIZE + tile_pos.y)
			set_tile(groundLayer, tile_position, main_source, tile)
	
	for y in range(CHUNK_SIZE):
		for x in range(CHUNK_SIZE):
			set_tile(groundLayer, Vector2i(chunk.x * CHUNK_SIZE + x, chunk.y * CHUNK_SIZE + y), main_source, water)
	chunks[chunk] = true

func unload_chunk(chunk):
	for y in range(CHUNK_SIZE):
		for x in range(CHUNK_SIZE):
			groundLayer.set_cell(Vector2i(chunk.x * CHUNK_SIZE + x, chunk.y * CHUNK_SIZE + y), -1)
	chunks.erase(chunk)

func save_chunk(chunk: Vector2):
	var key = str(chunk)
	if not chunk_data.has(chunk):
		chunk_data[key] = {
			"position": chunk,
			"tiles": {}
		}
	var only_water = true
	for y in range(CHUNK_SIZE):
		for x in range(CHUNK_SIZE):
			var tile = groundLayer.get_cell_atlas_coords(Vector2(chunk.x * CHUNK_SIZE + x, chunk.y * CHUNK_SIZE + y))
			if tile != water:
				chunk_data[key]["tiles"][Vector2i(x, y)] = tile
				only_water = false
	
	if only_water:
		chunk_data.erase(key)
	else:
		print("[DEBUG] Chunk " + key + " saved!")

func set_tile(layer: TileMapLayer, coords: Vector2i, source: int, tile: Vector2):
	if layer.get_cell_atlas_coords(coords) == Vector2i(-1, -1):
		layer.set_cell(coords, source, tile)

func get_tile_of_layer(pos: Vector2):
	var isometric_width = float((8 * TILE_WIDTH) + (7 * TILE_HEIGHT)) / CHUNK_SIZE
	var isometric_x = (pos.x / isometric_width) + (pos.y / TILE_HEIGHT)
	var isometric_y = (pos.y / TILE_HEIGHT) - (pos.x / isometric_width)
	return Vector2(floor(isometric_x), floor(isometric_y))

func curser():
	var mouse = get_global_mouse_position()
	var tile = get_tile_of_layer(mouse)
	debug_log.text += "Curser: " + str(tile) + "\n"
	
	if tile != curser_tile:
		if original_tile != null:
			groundLayer.set_cell(curser_tile, main_source, original_tile)
		
		original_tile = groundLayer.get_cell_atlas_coords(tile)
		groundLayer.set_cell(tile, main_source, forest)
		
		curser_tile = tile


#if tile_position != highlighted_tile_pos:
		## Vorheriges Tile zurücksetzen, wenn es existiert
		#if highlighted_tile_pos != null:
			#tile_map_layer.set_cell(highlighted_tile_pos.x, highlighted_tile_pos.y, original_tile_id)
#
		## Neues ursprüngliches Tile speichern und Hover-Tile setzen
		#original_tile_id = tile_map_layer.get_cell(tile_position.x, tile_position.y)
		#tile_map_layer.set_cell(tile_position.x, tile_position.y, hover_tile_id)
#
		## Aktualisiere die hervorgehobene Position
		#highlighted_tile_pos = tile_position
